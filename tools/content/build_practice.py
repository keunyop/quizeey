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
    if assigned != {exam['id'] for exam in catalog} or any(len(group['questions']) != 3 for group in groups):
        raise ValueError('Every catalog exam must have exactly three authored questions')
    payload = {'version': '2026-10', 'kind': 'original-practice', 'groups': groups}
    output = ROOT / 'web/src/data/practice-2026-10.json'
    output.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(f'{len(assigned)} exams, {len(groups)} topic groups, {len(assigned) * 3} original practice questions')


if __name__ == '__main__':
    build()
