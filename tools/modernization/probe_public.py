"""Small, serial public GET audit. No REST writes, cookies, ads, or load testing."""
import csv
import hashlib
import json
import time
from datetime import datetime, timezone
from html.parser import HTMLParser
from pathlib import Path
from urllib.error import HTTPError
from urllib.parse import urlsplit
from urllib.request import HTTPRedirectHandler, Request, build_opener

ROOT = Path(__file__).resolve().parents[2]
PATHS = ["/", "/en", "/kr", "/app", "/sqlp-developer", "/kr/sqlp-developer",
         "/en/aws-certified-developer-associate", "/test?testId=5", "/robots.txt",
         "/sitemap.xml", "/ads.txt", "/naver90f2a35cffe6ae01fc8515f4efe88a59.html"]


def allowed(url):
    parsed = urlsplit(url)
    return parsed.scheme in {"http", "https"} and parsed.hostname in {"quizeey.com", "www.quizeey.com"} and parsed.path in {urlsplit(p).path for p in PATHS}


class Redirects(HTTPRedirectHandler):
    def __init__(self):
        super().__init__()
        self.chain = []

    def redirect_request(self, req, fp, code, msg, headers, newurl):
        if not allowed(newurl):
            raise ValueError("Redirect outside safe audit allowlist")
        self.chain.append({"status": code, "url": newurl})
        return super().redirect_request(req, fp, code, msg, headers, newurl)


class Metadata(HTMLParser):
    def __init__(self):
        super().__init__()
        self.in_title = False
        self.title = ""
        self.canonical = ""
        self.description = ""
        self.language = ""
        self.scripts = []

    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        if tag == "title": self.in_title = True
        if tag == "html": self.language = a.get("lang", "")
        if tag == "link" and a.get("rel") == "canonical": self.canonical = a.get("href", "")
        if tag == "meta" and a.get("name") == "description": self.description = a.get("content", "")
        if tag == "script" and a.get("src"): self.scripts.append(a["src"])

    def handle_endtag(self, tag):
        if tag == "title": self.in_title = False

    def handle_data(self, data):
        if self.in_title: self.title += data


def main():
    urls = ["https://quizeey.com" + p for p in PATHS] + ["http://quizeey.com/", "https://www.quizeey.com/", "http://www.quizeey.com/"]
    results = []
    for url in urls:
        redirect = Redirects()
        opener = build_opener(redirect)
        record = {"url": url, "checkedAt": datetime.now(timezone.utc).isoformat()}
        try:
            try:
                response = opener.open(Request(url, headers={"User-Agent": "Quizeey-Compatibility-Audit/1.0 (public read-only)"}), timeout=15)
            except HTTPError as error:
                response = error
            with response:
                data = response.read(2_000_001)
                if len(data) > 2_000_000: raise ValueError("Audit body limit exceeded")
                decoded = data.decode("utf-8", errors="replace")
                parser = Metadata()
                parser.feed(decoded)
                record.update(status=response.status, finalUrl=response.url, redirects=redirect.chain,
                              title=parser.title.strip(), canonical=parser.canonical,
                              language=parser.language, description=parser.description,
                              scripts=parser.scripts, sha256=hashlib.sha256(data).hexdigest(),
                              contentType=response.headers.get("Content-Type", ""))
        except Exception as error:
            record["error"] = type(error).__name__  # No credentials or response bodies in errors.
        results.append(record)
        print(json.dumps({k: record[k] for k in ("url", "status", "finalUrl", "error") if k in record}))
        time.sleep(1)
    out = ROOT / "docs/modernization"
    (out / "public-probe.json").write_text(json.dumps(results, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    inventory = out / "seo-url-inventory.csv"
    with inventory.open(encoding="utf-8", newline="") as file:
        reader = csv.DictReader(file)
        fields = reader.fieldnames
        rows = list(reader)
    by_url = {r["url"]: r for r in results}
    for row in rows:
        if (probe := by_url.get(row["url"])) and "status" in probe:
            row.update(http_status=probe["status"], redirects=json.dumps(probe["redirects"]),
                       canonical=probe["canonical"], verification_status="live public GET: " + probe["checkedAt"])
    with inventory.open("w", encoding="utf-8", newline="") as file:
        writer = csv.DictWriter(file, fields)
        writer.writeheader()
        writer.writerows(rows)


if __name__ == "__main__": main()
