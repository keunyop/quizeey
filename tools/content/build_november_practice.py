"""Build the separate November set without touching October IDs or payloads."""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


def build():
    groups = []
    seen = set()
    topics = set()
    current = None
    for number, line in enumerate((ROOT / 'web/content/practice-2026-11.txt').read_text(encoding='utf-8').splitlines(), 1):
        if not line or line.startswith('#'):
            continue
        if line.startswith('@'):
            topic, exam, source = line[1:].split(';')
            if not exam.isdecimal() or topic in topics or not source.startswith('https://'):
                raise ValueError(f'Invalid group at {number}')
            seen.add(exam)
            topics.add(topic)
            current = {'topic': topic, 'examIds': [exam], 'source': source, 'questions': []}
            groups.append(current)
            continue
        parts = line.split('|')
        if current is None or len(parts) not in (6, 7) or any(not p.strip() for p in parts) or len(set(parts[1:5])) != 4:
            raise ValueError(f'Invalid question at {number}')
        item = {'prompt': parts[0], 'choices': parts[1:5], 'explanation': parts[5]}
        if len(parts) == 7:
            if not parts[6].startswith('https://'):
                raise ValueError(f'Invalid source at {number}')
            item['source'] = parts[6]
        current['questions'].append(item)
    catalog = json.loads((ROOT / 'web/src/data/exam-catalog.json').read_text(encoding='utf-8'))
    if not seen <= {e['id'] for e in catalog} or len(groups) != 16 or any(len(g['questions']) != 20 for g in groups):
        raise ValueError('Expected sixteen topic groups with twenty questions each')
    old = json.loads((ROOT / 'web/src/data/practice-2026-10.json').read_text(encoding='utf-8'))
    old_prompts = {q['prompt'] for g in old['groups'] for q in g['questions']}
    prompts = [q['prompt'] for g in groups for q in g['questions']]
    if len(set(prompts)) != len(prompts) or old_prompts.intersection(prompts):
        raise ValueError('Repeated question prompt')
    payload = {'version': '2026-11', 'kind': 'original-practice', 'groups': groups}
    (ROOT / 'web/src/data/practice-2026-11.json').write_text(json.dumps(payload, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(f'{len(seen)} exam identities, {len(groups)} topics, {len(prompts)} November questions; October unchanged')


if __name__ == '__main__':
    build()
