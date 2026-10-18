"""Inspect source SQL/dumps for schema/export evidence without executing content or reading secrets."""
import hashlib
import json
import re
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def main():
    paths = sorted((ROOT / 'src').rglob('*.sql')) + sorted((ROOT / 'src/main/resources/dumps').glob('*'))
    files = []
    for path in paths:
        if not path.is_file(): continue
        data = path.read_bytes()
        try: content = data.decode('utf-8'); encoding = 'utf-8'
        except UnicodeDecodeError: content = data.decode('cp949',errors='replace'); encoding = 'cp949 fallback; verify original encoding'
        statements = re.findall(r'\binsert\s+into\s+([a-z_]+)\s*\(([^)]+)\)', content, re.I)
        columns = {}
        for table, names in statements: columns.setdefault(table.lower(), sorted(set(n.strip().lower() for n in names.split(','))))
        files.append({'path': path.relative_to(ROOT).as_posix(), 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest(),
                      'textEncoding': encoding, 'ddlStatements': len(re.findall(r'\b(?:create|alter)\s+table\b',content,re.I)),
                      'insertStatements': dict(Counter(table.lower() for table,_ in statements)), 'insertColumns': columns,
                      'hasQuestionPrimaryIds': any('quest_id' in names.split(',') for table,names in statements if table.lower()=='question'),
                      'hasChoicePrimaryIds': any('exmp_id' in names.split(',') for table,names in statements if table.lower()=='example'),
                      'sourceQuestionMarkers': len(re.findall(r'(?:^|\n)(?:NO\.\d+|\d+\.)',content)),
                      'assetHosts': sorted(set(re.findall(r'https?://([^/\s"<>]+)',content)))})
    result = {'files':files, 'liveDdlAvailable':False, 'productionSnapshotAvailable':False,
              'disqusExportAvailable':False,
              'finding':'Source SQL/dumps and JPA provide partial content/relationship evidence, not deployed IDs or complete live schema. No data generator or SQL was executed.'}
    (ROOT/'docs/modernization/source-data-evidence.json').write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(result,ensure_ascii=False,indent=2))


if __name__=='__main__':main()
