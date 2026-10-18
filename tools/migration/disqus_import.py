"""Deterministic, offline Disqus normalization. Never creates accounts/capabilities."""
import hashlib
import json
import re
import xml.etree.ElementTree as ET
from html.parser import HTMLParser
from pathlib import Path
import argparse


class PlainText(HTMLParser):
    def __init__(self): super().__init__(); self.parts = []; self.suppressed = 0
    def handle_starttag(self, tag, attrs):
        if tag in {"script", "style"}: self.suppressed += 1
        if tag in {"p", "br", "div", "li"}: self.parts.append("\n")
    def handle_endtag(self, tag):
        if tag in {"script", "style"} and self.suppressed: self.suppressed -= 1
    def handle_data(self, value):
        if not self.suppressed: self.parts.append(value)


def normalize(xml, mapping):
    if len(xml.encode("utf-8")) > 50_000_000 or re.search(r"<!\s*(?:DOCTYPE|ENTITY)", xml, re.I):
        raise ValueError("Unsupported or unsafe XML")
    root = ET.fromstring(xml)
    def name(element): return element.tag.split("}")[-1]
    def attr_id(element): return next((v for k, v in element.attrib.items() if k.split("}")[-1] == "id"), None)
    def child(element, tag): return next((e for e in element if name(e) == tag), None)
    def value(element, tag):
        found = child(element, tag)
        return "" if found is None else "".join(found.itertext()).strip()
    def flag(element, tag): return value(element, tag).lower()
    threads = {attr_id(e): e for e in root if name(e) == "thread"}
    posts, excluded, errors = [], [], []
    seen = set()
    for element in root:
        if name(element) != "post": continue
        id_ = attr_id(element)
        if not id_ or id_ in seen:
            errors.append({"sourceId": id_, "issue": "missing_or_duplicate_source_id"}); continue
        seen.add(id_)
        thread_ref = child(element, "thread")
        thread_id = attr_id(thread_ref) if thread_ref is not None else None
        thread = threads.get(thread_id)
        if thread is None or thread_id not in mapping:
            errors.append({"sourceId": id_, "issue": "unmapped_thread", "threadId": thread_id}); continue
        if any(flag(element, key) == "true" for key in ["isDeleted", "isSpam", "isPrivate"]) or any(flag(thread, key) == "true" for key in ["isDeleted", "isPrivate"]):
            excluded.append(id_); continue
        context = mapping[thread_id]
        if context.get("locale") not in {"ko", "en"} or not context.get("testId"):
            errors.append({"sourceId": id_, "issue": "invalid_context"}); continue
        parser = PlainText()
        parser.feed(value(element, "message"))
        author = child(element, "author")
        parent = child(element, "parent")
        # Missing moderation/privacy flags stay pending even if thread mapping is reviewed.
        public = context.get("allowPublicImport") is True and all(flag(element, key) == "false" for key in ["isDeleted", "isSpam"]) and flag(thread, "isPrivate") == "false"
        posts.append({"source": "disqus", "sourceId": id_, "threadId": thread_id,
                      "parentSourceId": attr_id(parent) if parent is not None else None,
                      "testId": str(context["testId"]), "questId": str(context["questId"]) if context.get("questId") else None,
                      "locale": context["locale"], "body": "".join(parser.parts).strip(),
                      "displayName": value(author, "name") if author is not None else "",
                      "createdAtRaw": value(element, "createdAt"), "visibility": "approved" if public else "pending",
                      "guestOwnership": None})
    valid_ids = {p["sourceId"]: p["threadId"] for p in posts}
    for post in posts:
        if post["parentSourceId"] and valid_ids.get(post["parentSourceId"]) != post["threadId"]:
            errors.append({"sourceId": post["sourceId"], "issue": "missing_or_cross_thread_parent"})
    parents = {p['sourceId']: p['parentSourceId'] for p in posts}
    checked = set()
    for id_ in parents:
        chain = set()
        cursor = id_
        while cursor and cursor in parents and cursor not in checked:
            if cursor in chain:
                errors.append({'sourceId':id_,'issue':'cyclic_parent'})
                break
            chain.add(cursor)
            cursor=parents[cursor]
        checked.update(chain)
    posts.sort(key=lambda p: p["sourceId"])
    report = {"exportSha256": hashlib.sha256(xml.encode("utf-8")).hexdigest(), "eligiblePosts": len(posts),
              "excludedSourceIds": sorted(excluded), "errors": errors,
              "payloadSha256": hashlib.sha256(json.dumps(posts, ensure_ascii=False, sort_keys=True).encode("utf-8")).hexdigest()}
    return posts, report


def main():
    root=Path(__file__).resolve().parents[2]
    parser=argparse.ArgumentParser(description='Offline Disqus normalization; no DB connection')
    parser.add_argument('export',type=Path)
    parser.add_argument('mapping',type=Path)
    parser.add_argument('--output-dir',type=Path,default=root/'.modernization/disqus')
    args=parser.parse_args()
    destination=args.output_dir.resolve()
    if not destination.is_relative_to((root/'.modernization').resolve()): parser.error('Private output must stay in ignored .modernization/')
    if args.export.stat().st_size>50_000_000: parser.error('Export exceeds bounded partition limit')
    posts,report=normalize(args.export.read_text(encoding='utf-8-sig'),json.loads(args.mapping.read_text(encoding='utf-8-sig')))
    destination.mkdir(parents=True,exist_ok=True)
    (destination/'reconciliation.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
    if report['errors']: raise SystemExit('Import blocked; inspect private reconciliation report. No post payload emitted.')
    (destination/'normalized-posts.json').write_text(json.dumps(posts,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print('Offline Disqus normalization passed. Private payload emitted; no import/account creation performed.')


if __name__=='__main__':main()
