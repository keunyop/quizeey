"""Read verified, approved SQL batches for the connector; persist conservative checkpoints.

Only --read-index emits SQL, for functions orchestration to pass directly to the
approved database tool. Do not print that output to chat or save it in Git.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import sys

sys.stdout.reconfigure(encoding='utf-8')

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / '.modernization/exports/source-265c3ca16e/cloud-preview-content'
PROJECT = 'tfkhnrbshvyfmrzxqfmq'
DATASET = '88ed4da320cf3bbd40d65f1aa6de7ba6b81a09f5aa6bbcef1e3860ca58ccb42f'
CHECKPOINT = SOURCE / 'upload-checkpoint.json'


def save(data):
    temporary = CHECKPOINT.with_suffix('.next.json')
    temporary.write_text(json.dumps(data, indent=2) + '\n', encoding='utf-8')
    temporary.replace(CHECKPOINT)


def main():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--read-index', type=int)
    group.add_argument('--ack-index', type=int)
    group.add_argument('--manifest', action='store_true')
    parser.add_argument('--count', type=int, default=1)
    args = parser.parse_args()
    manifest = json.loads((SOURCE / 'manifest.json').read_text(encoding='utf-8'))
    if manifest['projectId'] != PROJECT or manifest['datasetSha256'] != DATASET:
        raise ValueError('Target or dataset mismatch')
    if manifest['nativePostsIncluded'] or manifest['sourceAuthorColumnsIncluded']:
        raise ValueError('Content scope mismatch')
    if len(manifest['batches']) != 191:
        raise ValueError('Batch count mismatch')
    state = json.loads(CHECKPOINT.read_text(encoding='utf-8')) if CHECKPOINT.exists() else {
        'projectId': PROJECT, 'datasetSha256': DATASET,
        'ownerApprovalDate': '2026-10-17', 'baselineVerifiedEmpty': True,
        'completed': [], 'pending': None,
    }
    if state['projectId'] != PROJECT or state['datasetSha256'] != DATASET:
        raise ValueError('Checkpoint mismatch')
    if args.manifest:
        print(json.dumps({'manifest': manifest, 'checkpoint': state}))
        return
    if args.ack_index is not None:
        if state['pending'] is None or state['pending']['index'] != args.ack_index:
            raise ValueError('Unexpected acknowledgement')
        confirmed = datetime.now(timezone.utc).isoformat()
        for batch in state['pending'].get('batches', [state['pending']]):
            state['completed'].append({**batch, 'confirmedAt': confirmed})
        state['pending'] = None
        save(state)
        print(json.dumps({'confirmed': args.ack_index, 'completed': len(state['completed'])}))
        return
    index = args.read_index
    if state['pending'] is not None or index != len(state['completed']):
        raise ValueError('Pending or out-of-order batch; inspect DB before resuming')
    if not 1 <= args.count <= 5:
        raise ValueError('Invalid group size')
    queries, batches = [], []
    total_bytes = 0
    for next_index in range(index, min(index + args.count, len(manifest['batches']))):
        batch = manifest['batches'][next_index]
        # Keep each request within one table and below 700 KB. Every original
        # batch still has its own transaction and hash. If a group call fails,
        # retain every in-flight index and reconcile instead of retrying.
        if batches and batch['table'] != batches[0]['table']:
            break
        file = (SOURCE / batch['file']).resolve()
        if file.parent != SOURCE.resolve() or file.suffix != '.sql':
            raise ValueError('Batch path mismatch')
        raw = file.read_bytes()
        if hashlib.sha256(raw).hexdigest() != batch['sha256']:
            raise ValueError('Batch hash mismatch')
        if batches and total_bytes + len(raw) > 700000:
            break
        query = raw.decode('utf-8')
        if not query.startswith('BEGIN;') or not query.endswith('COMMIT;'):
            raise ValueError('Transaction framing mismatch')
        queries.append(query)
        batches.append({'index': next_index, **batch})
        total_bytes += len(raw)
    query = '\n'.join(queries)
    state['pending'] = {'index': index, 'batches': batches, 'startedAt': datetime.now(timezone.utc).isoformat()}
    save(state)
    print(json.dumps({'index': index, 'projectId': PROJECT, 'batches': batches, 'query': query}, ensure_ascii=False))


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        raise SystemExit('Approved content bridge failed (' + type(error).__name__ + '); no source printed.')
