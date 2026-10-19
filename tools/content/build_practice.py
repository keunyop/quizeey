"""Build public, original practice content; never reads private legacy exports."""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def build():
    catalog = json.loads((ROOT / 'web/src/data/exam-catalog.json').read_text(encoding='utf-8'))
    groups, assigned, current = [], set(), None
    for number, line in enumerate((ROOT / 'web/content/practice-2026-10.txt').read_text(encoding='utf-8').splitlines(), 1):
        if not line or line.startswith('#'):
            continue
        if line.startswith('@'):
            key, ids, source = line[1:].split(';')
            if assigned.intersection(ids.split()) or not source.startswith('https://'):
                raise ValueError(f'Duplicate assignment or unsafe reference at line {number}')
            current = {'topic': key, 'examIds': ids.split(), 'source': source, 'questions': []}
            groups.append(current)
            assigned.update(current['examIds'])
        else:
            parts = line.split('|')
            if current is None or len(parts) != 6 or len(set(parts[1:5])) != 4 or any(not value.strip() for value in parts):
                raise ValueError(f'Invalid question at line {number}')
            current['questions'].append({'prompt': parts[0], 'choices': parts[1:5], 'explanation': parts[5]})
    expected = {exam['id']: exam.get('questionCount', 3) for exam in catalog}
    blocks = {exam['id']: exam.get('idBlockSize', 100) for exam in catalog}
    if any(block not in (100, 1000) for block in blocks.values()):
        raise ValueError('Unsupported authored identity block size')
    if assigned != set(expected) or any(
        any(len(group['questions']) != expected[exam_id] or
            not 1 <= len(group['questions']) < blocks[exam_id]
            for exam_id in group['examIds'])
        for group in groups
    ):
        raise ValueError('Every catalog exam must have its declared question count within its identity block')
    payload = {'version': '2026-10', 'kind': 'original-practice', 'groups': groups}
    output = ROOT / 'web/src/data/practice-2026-10.json'
    output.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    total = sum(len(group['questions']) * len(group['examIds']) for group in groups)
    print(f'{len(assigned)} exams, {len(groups)} topic groups, {total} original practice questions')


if __name__ == '__main__':
    build()
