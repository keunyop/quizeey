"""Offline, deterministic legacy inventory. Never reads application.yml or calls APIs."""
import csv
import hashlib
import html
import json
import re
import subprocess
from collections import Counter
from pathlib import Path
from urllib.parse import urlsplit

ROOT = Path(__file__).resolve().parents[2]
RES = ROOT / "src/main/resources"
OUT = ROOT / "docs/modernization"
JAVA = ROOT / "src/main/java/com/questionbank/webservice"


def text(path):
    return path.read_text(encoding="utf-8") if path.exists() else ""


def clean(value):
    return html.unescape(re.sub(r"\s+", " ", re.sub(r"<[^>]+>", " ", value))).strip()


def metadata(template):
    source = text(template)
    title = re.search(r"<title>(.*?)</title>", source, re.S)
    desc = re.search(r'<meta\s+name="description"\s+content="([^"]*)"', source, re.S)
    headings = re.findall(r"<h[12][^>]*>(.*?)</h[12]>", source, re.S)
    links = re.findall(r'<a\b[^>]*href="([^"]+)"[^>]*>(.*?)</a>', source, re.S)
    return {
        "title": clean(title[1]) if title else "",
        "description": clean(desc[1]) if desc else "",
        "headings": [clean(h) for h in headings if clean(h) and "{{" not in h],
        "links": [{"href": href, "label": clean(label)} for href, label in links
                  if href.startswith("/") and not href.startswith("//") and "{{" not in href],
    }


def discover():
    controller = text(JAVA / "web/WebController.java")
    mapping = dict(re.findall(r'TESTMAP\.put\("([^"]+)", new String\[\] \{ "(\d+)"', controller))
    enums = dict((name, (id_, en, ko)) for name, id_, en, ko in re.findall(
        r'(\w+)\("(\d+)", "([^"]*)", "([^"]*)"\)', text(JAVA / "service/enums/TestEnum.java")))
    routes = []
    for annotation, body in re.findall(r'@GetMapping\((.*?)\)\s*public String \w+\(.*?\)\s*\{(.*?)(?=\n\t@GetMapping|\n\})', controller, re.S):
        paths = re.findall(r'"([^"{}]+)"', annotation)
        for path in paths:
            path = "/" + path.lstrip("/")
            locale = "en" if path == "/en" or path.startswith("/en/") else "ko"
            base = re.sub(r"^/(?:en|kr)(?=/|$)", "", path) or "/"
            id_ = mapping.get(base)
            special = re.search(r'String testId = TestEnum\.(\w+)\.getCode', body)
            if special:
                id_ = enums[special[1]][0]
            if base == "/":
                template = "en/main" if locale == "en" else "main"
            elif path == "/app":
                template = "app/main"
            elif base == "/test" or special:
                template = "en/test" if locale == "en" else "test"
            elif id_:
                template = ("en/test" if locale == "en" else "test") + base
            else:
                template = path.lstrip("/")
            file = RES / "templates" / (template + ".hbs")
            info = metadata(file)
            if special and id_:
                enum = next(v for v in enums.values() if v[0] == id_)
                name = enum[1 if locale == "en" else 2]
                info["headings"] = [name]
            routes.append({"path": path, "locale": locale, "testId": id_, "template": template,
                           "templateExists": file.exists(), **info})

    sitemap = re.findall(r"<loc>(.*?)</loc>", text(RES / "static/sitemap.xml"))
    urls = {url: {"sitemap"} for url in sitemap}
    by_path = {r["path"]: r for r in routes}
    for route in routes:
        urls.setdefault("https://quizeey.com" + route["path"], set()).add("controller")
    for file in sorted((RES / "templates").rglob("*.hbs")):
        for link in metadata(file)["links"]:
            urls.setdefault("https://quizeey.com" + link["href"], set()).add("template-link")
    for file in (RES / "static").iterdir():
        if file.is_file():
            urls.setdefault("https://quizeey.com/" + file.name, set()).add("static")
    # Semantic cases, not invented production question IDs.
    for path in ("/test?testId=5", "/kr/test?testId=5", "/en/test?testId=1"):
        urls.setdefault("https://quizeey.com" + path, set()).add("query-contract")

    OUT.mkdir(parents=True, exist_ok=True)
    fields = ["url", "sources", "query_behavior", "http_status", "redirects", "canonical", "language",
              "title", "content_summary", "target_behavior", "traffic_priority", "verification_status"]
    with (OUT / "seo-url-inventory.csv").open("w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fields)
        writer.writeheader()
        for url, sources in sorted(urls.items()):
            path = urlsplit(url).path
            route = by_path.get(path, {})
            writer.writerow(dict(zip(fields, [url, ";".join(sorted(sources)),
                "exact questId; testId required on /test; reject malformed/ambiguous values" if route.get("testId") or path.endswith("/test") else "inspect; never strip globally",
                "", "", "", route.get("locale", "unknown"), route.get("title", ""),
                " | ".join(route.get("headings", [])), "preserve; resolve evidence gaps before cutover",
                "unknown: GSC export needed", "source-only; live verification pending"])))

    templates = "\n".join(text(p) for p in sorted((RES / "templates").rglob("*.hbs")))
    collisions = {id_: paths for id_, paths in (
        (id_, sorted(p for p, v in mapping.items() if v == id_)) for id_ in set(mapping.values())) if len(paths) > 1}
    rest = text(JAVA / "web/WebRestController.java")
    endpoints = [{"method": method.upper(), "path": path} for method, path in re.findall(r'@(Get|Post)Mapping\("([^"]+)"\)', rest)]
    payload = {
        "sourceCommit": subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=ROOT, text=True).strip(),
        "sitemapEntries": len(sitemap), "inventoryUrls": len(urls), "routes": routes,
        "testIdCollisions": collisions, "endpoints": endpoints,
        "publicIdentifiers": {"adsense": sorted(set(re.findall(r"ca-pub-\d+", templates))),
                              "analytics": sorted(set(re.findall(r"(?:UA-\d+-\d+|G-[A-Z0-9]+)", templates))),
                              "slots": sorted(set(re.findall(r'data-ad-slot="(\d+)"', templates)))},
        "missingTemplates": [r["path"] for r in routes if not r["templateExists"]],
    }
    fixtures = ROOT / "web/fixtures"
    fixtures.mkdir(parents=True, exist_ok=True)
    (fixtures / "legacy-contract.json").write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({k: v for k, v in payload.items() if k != "routes"}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    discover()
