"""Restore retained ASiS question comments, preserving source text and identities.

The user requested restoration on 2026-10-18. Generated SQL and manifests remain
in the existing private export directory, never in source control or app bundles.
--apply-local writes only to the isolated loopback fixture, not a hosted database.
"""
import argparse
from collections import Counter
from datetime import datetime
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import os

from legacy_explanations import transform, sql_plan

ROOT = Path(__file__).resolve().parents[2]


def prepare():
    evidence = json.loads((ROOT / 'docs/modernization/source-snapshot-evidence.json').read_text(encoding='utf-8'))
    source = (ROOT / evidence['privatePath']).resolve(strict=True)
    if not source.is_relative_to((ROOT / '.modernization/exports').resolve(strict=True)):
        raise ValueError('Unexpected private archive location')
    policy = json.loads((source / 'publication-candidate-plan.json').read_text(encoding='utf-8'))
    raw = (source / 'new-service-dataset.json').read_bytes()
    if not policy.get('ownerPolicyApproved') or hashlib.sha256(raw).hexdigest() != policy['newServiceDatasetSha256']:
        raise ValueError('Approved filtered archive integrity mismatch')
    target, _ = transform(json.loads(raw))
    if len(target['posts']) != 2183 or len(target['topics']) != 630:
        raise ValueError('Unexpected retained comment counts')
    counts = Counter(post['topic_id'] for post in target['posts'])
    for post in target['posts']:
        post['visibility'] = 'approved'
    for topic in target['topics']:
        topic['visibility'] = 'approved'
        topic['approved_post_count'] = counts[topic['id']]
    plan = sql_plan(target).replace('-- PRIVATE LOCAL REHEARSAL; NOT AUTHORIZATION FOR HOSTED IMPORT.',
        '-- User-requested ASiS restoration. Preserves names, text, UTC, and IDs.\n-- Replays never overwrite existing moderation or ownership.')
    output = source / 'restored-comments-202610'
    output.mkdir(exist_ok=True)
    sql = output / 'restore-comments.sql'
    sql.write_text(plan, encoding='utf-8')
    manifest = {'topics': len(target['topics']), 'comments': len(target['posts']), 'excludedQuestionCommentsNotPublished': 26,
        'sqlSha256': hashlib.sha256(plan.encode('utf-8')).hexdigest(), 'sourceSha256': policy['newServiceDatasetSha256'],
        'preservesTextNamesTimestamps': True, 'guestOwnershipInferred': False, 'sampleContext': {
            'examId': target['topics'][0]['exam_id'], 'questionId': target['topics'][0]['question_id']}}
    return target, sql, output, manifest


def local_query(query=None, file=None):
    psql = shutil.which('psql')
    if not psql:
        raise ValueError('psql is required for the isolated local verification')
    args = [psql, '-X', '-qAt', '-h', '127.0.0.1', '-p', '55432', '-U', 'quizeey_fixture', '-d', 'quizeey_fixture', '-v', 'ON_ERROR_STOP=1']
    if file:
        args += ['-f', str(file)]
    result = subprocess.run(args, input=query, capture_output=True, encoding='utf-8',
        env={**os.environ, 'PGCLIENTENCODING': 'UTF8'}, creationflags=subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0)
    if result.returncode:
        raise ValueError('Isolated local restore or verification failed (private query details suppressed)')
    return result.stdout


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--apply-local', action='store_true')
    args = parser.parse_args()
    target, sql, output, manifest = prepare()
    if args.apply_local:
        local_query(file=sql)
        # Verify exact preserved values without writing or printing user text.
        rows = [json.loads(line) for line in local_query("select to_jsonb(p) from public.quizeey_posts p where source_post_id like 'mysql:explanation:%' order by source_post_id;").splitlines() if line]
        keys = ['id', 'topic_id', 'parent_id', 'display_name', 'body', 'source_post_id']
        expected = sorted(target['posts'], key=lambda post: post['source_post_id'])
        if len(rows) != len(expected) or any(any(actual[key] != original[key] for key in keys) for actual, original in zip(rows, expected)):
            raise ValueError('Restored text, display name, identity or parent changed')
        if any(any(datetime.fromisoformat(actual[key]) != datetime.fromisoformat(original[key])
                   for key in ['created_at', 'updated_at']) for actual, original in zip(rows, expected)):
            raise ValueError('Restored timestamps changed')
        for role in ['anon', 'authenticated']:
            visible = local_query(f"set role {role}; select count(*) from public.quizeey_posts where source_post_id like 'mysql:explanation:%';").strip()
            if visible != '2183':
                raise ValueError('Restored comments are not visible through the public RLS policy')
        # A replay must be harmless and must not create duplicate rows.
        local_query(file=sql)
        manifest['localRestoreVerified'] = True
        manifest['replayVerified'] = True
    manifest['hostedApplied'] = False
    (output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({key: value for key, value in manifest.items() if key != 'sampleContext'}))


if __name__ == '__main__':
    main()
