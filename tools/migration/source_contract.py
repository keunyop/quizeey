"""Validate an approved offline snapshot against verified live DDL, inventory HTML.

No network/DB calls. Detailed asset references and row IDs stay in the snapshot's
private directory; the repository receives counts and schema/hash provenance only.
"""
import argparse
from collections import Counter, defaultdict
from datetime import datetime
import hashlib
from html.parser import HTMLParser
from html import escape
import json
from pathlib import Path
import re

from audit import ROOT, TABLES, digest


def validate_contract(data, schema):
    columns = defaultdict(list)
    for column in schema['columns']: columns[column['TABLE_NAME']].append(column)
    errors = []
    for table, primary in TABLES.items():
        if not isinstance(data.get(table), list):
            errors.append({'table': table, 'issue': 'missing_table'}); continue
        expected = {column['COLUMN_NAME'] for column in columns[table]}
        if not expected: raise ValueError('Verified table schema missing')
        for row in data[table]:
            if set(row) != expected:
                errors.append({'table': table, 'id': row.get(primary), 'issue': 'column_set_mismatch'})
            for column in columns[table]:
                name = column['COLUMN_NAME']; value = row.get(name)
                issue = None
                if value is None:
                    if column['IS_NULLABLE'] != 'YES': issue = 'unexpected_null'
                else:
                    kind = column['COLUMN_TYPE']
                    if kind.startswith('varchar('):
                        width = int(re.fullmatch(r'varchar\((\d+)\)', kind)[1])
                        if not isinstance(value, str): issue = 'invalid_text_type'
                        elif len(value) > width: issue = 'text_width_exceeded'
                        elif any(char == '\0' or 0xd800 <= ord(char) <= 0xdfff for char in value):
                            issue = 'postgres_unrepresentable_text'
                    elif kind.startswith(('int(', 'bigint(')):
                        bigint = kind.startswith('bigint(')
                        valid = (isinstance(value, str) and bool(re.fullmatch(r'-?\d+', value))) if bigint else type(value) is int
                        limit = 2 ** (63 if bigint else 31)
                        if not valid or not -limit <= int(value) < limit: issue = 'invalid_integer'
                    elif kind == 'timestamp':
                        try:
                            if not isinstance(value, str) or not re.fullmatch(r'\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}(?:\.\d{1,6})?', value):
                                raise ValueError()
                            datetime.fromisoformat(value)
                        except (TypeError, ValueError): issue = 'invalid_source_timestamp'
                    else: raise ValueError('Unsupported verified source type')
                if issue: errors.append({'table': table, 'id': row.get(primary), 'column': name, 'issue': issue})
    return errors


class MarkupInventory(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.tags = Counter(); self.risks = Counter(); self.references = []

    def handle_starttag(self, tag, attributes):
        known={'a','area','b','blockquote','body','br','button','caption','code','col','colgroup','dd','div','dl','dt',
               'em','embed','font','form','h1','h2','h3','head','hr','html','i','iframe','image','img','input','li',
               'link','map','meta','object','ol','p','pre','script','select','small','span','strong','style','sub',
               'sup','svg','table','tbody','td','textarea','th','thead','title','tr','u','ul','video'}
        # Technical placeholders can look like tags. Never publish arbitrary source
        # strings as metric keys (they could contain names or private references).
        self.tags[tag if tag in known else 'other_tag'] += 1
        if tag in {'script', 'iframe', 'object', 'embed', 'form', 'input', 'button', 'style', 'link', 'meta'}:
            self.risks['active_tag_' + tag] += 1
        for key, value in attributes:
            if key.startswith('on'): self.risks['event_attribute'] += 1
            if not value: continue
            if key in {'href', 'src', 'xlink:href', 'action', 'formaction', 'data'}:
                if re.match(r'\s*(javascript|vbscript|data):', value, re.I): self.risks['active_url_scheme'] += 1
            if key in {'src', 'srcset', 'poster', 'data', 'xlink:href'} or (tag == 'a' and key == 'href') or (tag == 'image' and key == 'href'):
                self.references.append({'tag': tag, 'attribute': key, 'value': value})
            if key == 'style':
                for match in re.finditer(r'url\(\s*[\'"]?(.*?)[\'"]?\s*\)', value, re.I):
                    self.references.append({'tag': tag, 'attribute': 'style_url', 'value': match[1]})

    handle_startendtag = handle_starttag


def inspect_markup(data):
    tags = Counter(); risks = Counter(); references = []; fields = 0
    for table, names in {'question': ['quest_txt', 'explanation', 'reference'],
                         'example': ['exmp_txt'], 'explanation': ['explanation']}.items():
        for row in data[table]:
            for name in names:
                value = row.get(name)
                if not isinstance(value, str) or not value: continue
                parser = MarkupInventory(); parser.feed(value); parser.close()
                fields += 1; tags.update(parser.tags); risks.update(parser.risks)
                references.extend({'table': table, 'id': row[TABLES[table]], 'column': name, **ref} for ref in parser.references)
    return {'textFieldsInspected': fields, 'tags': dict(tags), 'markupRiskOccurrences': dict(risks),
            'referenceOccurrences': len(references), 'externalFetches': 0,
            'scope': 'HTML shape inventory only, not sanitization, content rights review, or verified file checksum manifest'}, references


def relationship_review(data):
    questions = defaultdict(list); choices = defaultdict(list); choice_numbers = defaultdict(list)
    for row in data['question']: questions[(row['test_id'],row['ver_nbr'],row['quest_nbr'])].append(row)
    for row in data['example']:
        key = (row['test_id'],row['ver_nbr'],row['quest_nbr'])
        choices[key].append(row); choice_numbers[(*key,row['exmp_nbr'])].append(row)
    review = {'questionGroups': [], 'choiceGroups': [],
              'sourceLookup': 'QuestionService.getQuestion: choices selected by test_id/ver_nbr/quest_nbr; source behavior only, not a semantic repair approval',
              'automaticRepairs': 0, 'publicationAllowed': False}
    for key, rows in questions.items():
        if len(rows) < 2: continue
        fields = ['quest_txt','explanation','reference','multi_answer_yn']
        variants = {digest({name: row[name] for name in fields}) for row in rows}
        review['questionGroups'].append({'key': key, 'questionIds': [r['quest_id'] for r in rows],
                                        'contentVariants': len(variants), 'sourceSharedChoiceIds': [r['exmp_id'] for r in choices[key]]})
    for key, rows in choice_numbers.items():
        if len(rows) < 2: continue
        variants = {digest({name: row[name] for name in ['exmp_txt','answer_yn']}) for row in rows}
        review['choiceGroups'].append({'key': key, 'choiceIds': [r['exmp_id'] for r in rows], 'contentVariants': len(variants)})
    summary = {'duplicateQuestionGroups': len(review['questionGroups']),
               'identicalQuestionContentGroups': sum(g['contentVariants']==1 for g in review['questionGroups']),
               'differingQuestionContentGroups': sum(g['contentVariants']>1 for g in review['questionGroups']),
               'duplicateChoiceNumberGroups': len(review['choiceGroups']),
               'identicalChoiceContentGroups': sum(g['contentVariants']==1 for g in review['choiceGroups']),
               'differingChoiceContentGroups': sum(g['contentVariants']>1 for g in review['choiceGroups']),
               'automaticRepairs': 0, 'publicationAllowed': False}
    return summary, review


def review_html(data, review):
    # Fully offline, script-free review artifact. Treat source markup as TEXT;
    # browser opening must not contact source image/link/ad/analytics endpoints.
    header = '<!doctype html><html lang="ko"><meta charset="utf-8"><meta http-equiv="Content-Security-Policy" content="default-src \'none\'; style-src \'unsafe-inline\'; base-uri \'none\'; form-action \'none\'"><meta name="robots" content="noindex,nofollow"><title>Quizeey 원본 관계 검토</title><style>body{font:16px system-ui;max-width:1100px;margin:2rem auto;padding:1rem}pre{white-space:pre-wrap;overflow-wrap:anywhere}section{border-top:2px solid #777;margin-top:2rem}article{border:1px solid #ccc;padding:1rem;margin:1rem 0}h2{font-size:1.2rem}</style><body><h1>원본 관계 검토</h1><p>소유자 전용 로컬 자료. 원본 수정·자동 병합·공개 이전 없음. HTML은 실행하지 않고 문자로 표시합니다. 작성자 이름·외부 요청·스크립트 없음.</p>'
    questions = {r['quest_id']:r for r in data['question']}
    choices = {r['exmp_id']:r for r in data['example']}
    sections = [header]
    for group in review['questionGroups']:
        sections.append('<section><h2>문제 키 '+escape(str(group['key']))+' / 내용 종류 '+str(group['contentVariants'])+'</h2>')
        for id_ in group['questionIds']:
            row=questions[id_]
            sections.append('<article><h3>quest_id '+escape(id_)+' / multi_answer_yn '+escape(row['multi_answer_yn'])+'</h3>')
            for field in ['quest_txt','explanation','reference']:
                sections.append('<p>'+field+'</p><pre>'+escape(row[field] or '')+'</pre>')
            sections.append('</article>')
        sections.append('<h3>기존 소스가 같은 키로 조회하는 선택지 후보</h3>')
        for id_ in group['sourceSharedChoiceIds']:
            row=choices[id_]
            sections.append('<article>exmp_id '+escape(id_)+' / 번호 '+str(row['exmp_nbr'])+' / answer_yn '+escape(row['answer_yn'])+'<pre>'+escape(row['exmp_txt'])+'</pre></article>')
        sections.append('</section>')
    for group in review['choiceGroups']:
        sections.append('<section><h2>중복 선택지 키 '+escape(str(group['key']))+' / 내용 종류 '+str(group['contentVariants'])+'</h2>')
        for id_ in group['choiceIds']:
            row=choices[id_]
            sections.append('<article>exmp_id '+escape(id_)+' / answer_yn '+escape(row['answer_yn'])+'<pre>'+escape(row['exmp_txt'])+'</pre></article>')
        sections.append('</section>')
    return ''.join(sections)+'</body></html>'


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('snapshot', type=Path)
    args = parser.parse_args()
    source = args.snapshot.resolve()
    if not source.is_relative_to((ROOT / '.modernization/exports').resolve()):
        parser.error('Private source snapshot directory required')
    schema = json.loads((ROOT / 'tools/migration/verified_schema.json').read_text(encoding='utf-8'))
    evidence = json.loads((source / 'snapshot-evidence.json').read_text(encoding='utf-8'))
    if evidence.get('sessionTimezone') != '+00:00' or not evidence.get('sessionReadOnly'):
        raise RuntimeError('Verified UTC read-only snapshot required')
    with (source / 'normalized.json').open('rb') as stream:
        if hashlib.file_digest(stream, 'sha256').hexdigest() != evidence['normalizedSha256']:
            raise RuntimeError('Snapshot hash changed')
    data = json.loads((source / 'normalized.json').read_text(encoding='utf-8'))
    errors = validate_contract(data, schema)
    markup, references = inspect_markup(data)
    relations, review = relationship_review(data)
    (source / 'source-contract-errors.json').write_text(json.dumps(errors, indent=2) + '\n', encoding='utf-8')
    (source / 'asset-reference-inventory.json').write_text(json.dumps(references, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    (source / 'relationship-review.json').write_text(json.dumps(review, indent=2) + '\n', encoding='utf-8')
    (source / 'relationship-review.html').write_text(review_html(data,review), encoding='utf-8')
    result = {'status': 'pass' if not errors else 'blocked', 'sourceSnapshotSha256': evidence['snapshotSha256'],
              'verifiedSchemaSha256': digest(schema), 'schemaVerified': schema['schemaVerified'],
              'errors': dict(Counter(error['issue'] for error in errors)), 'markup': markup, 'relationships': relations,
              'privateReferencesPrinted': False, 'publicServingEnabled': False}
    (source / 'source-contract-evidence.json').write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    (ROOT / 'docs/modernization/source-contract-evidence.json').write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(result, indent=2))
    if errors: raise SystemExit(1)


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        raise SystemExit('Private source contract check failed (' + type(error).__name__ + '); no source content printed.')
