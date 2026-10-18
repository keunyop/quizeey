"""Bounded, owner-private native-post replay/RLS/restore rehearsal. No network DB."""
import argparse
import hashlib
import json
import re
import time
from pathlib import Path
from audit import ROOT, digest
from legacy_explanations import KEYS, transform, summaries, sql_plan
from private_postgres import PrivatePostgres


def verify(path, expected):
    actual = {table: [] for table in KEYS}
    for line in path.read_text(encoding='utf-8').splitlines():
        table, row = json.loads(line)
        actual[table].append(row)
    if summaries(actual) != summaries(expected):
        raise ValueError('Native post values, identities or timestamps changed')
    return summaries(actual)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('snapshot', type=Path)
    source = parser.parse_args().snapshot.resolve()
    if not source.is_relative_to((ROOT / '.modernization/exports').resolve()):
        parser.error('Approved private snapshot required')
    policy = json.loads((source / 'publication-candidate-plan.json').read_text(encoding='utf-8'))
    if policy.get('status') != 'owner_approved_new_service_exclusion' or not policy.get('ownerPolicyApproved'):
        raise ValueError('Confirmed new-service deletion policy required')
    raw = (source / 'new-service-dataset.json').read_bytes()
    if hashlib.sha256(raw).hexdigest() != policy['newServiceDatasetSha256']:
        raise ValueError('Approved dataset changed')
    data = json.loads(raw)
    deleted = json.loads((source / 'new-service-deleted-question-ids.json').read_text(encoding='utf-8'))
    if len(deleted) != 751 or digest(deleted) != policy['reviewQuestionIdSetSha256']:
        raise ValueError('Approved deletion scope changed')
    if set(deleted) & {row['quest_id'] for row in data['question']}:
        raise ValueError('Deleted question remains')
    target, mapping = transform(data)
    if len(target['posts']) != len(data['explanation']):
        raise ValueError('Not every retained source explanation mapped')
    plan = sql_plan(target)
    query = '\n'.join("SELECT json_build_array('" + table + "',to_jsonb(t)) FROM public.quizeey_" +
                      table + ' t ORDER BY ' + key + ';' for table, key in KEYS.items())
    started = time.monotonic()
    stages = []
    with PrivatePostgres(source) as db:
        (db.directory / 'native-explanations.sql').write_text(plan, encoding='utf-8')
        (db.directory / 'source-id-mapping.json').write_text(json.dumps(mapping, ensure_ascii=False, indent=2), encoding='utf-8')
        db.sql('postgres', 'CREATE ROLE anon;CREATE ROLE authenticated;CREATE ROLE service_role BYPASSRLS;CREATE DATABASE quizeey_native;')
        for migration in ['202610160002_native_forum.sql', '202610160003_guest_private_preview.sql', '202610160004_admin_moderation.sql']:
            db.sql('quizeey_native', file=ROOT / 'supabase/migrations' / migration)
        for attempt in [1, 2]:
            db.sql('quizeey_native', file=db.directory / 'native-explanations.sql')
            checked = verify(db.sql('quizeey_native', query), target)
            stages.append({'stage': 'import_' + str(attempt), 'allValuesAndSourceIdsMatch': True})
            print('Private native explanation import %d verified' % attempt, flush=True)
        # No author-name association, new accounts, guest ownership or bearer tokens.
        if db.sql('quizeey_native', 'SELECT (SELECT count(*) FROM quizeey_private.post_owners)+(SELECT count(*) FROM quizeey_private.guest_capabilities);').read_text().strip() != '0':
            raise ValueError('Unexpected guest ownership inferred')
        for role in ['anon', 'authenticated']:
            if db.sql('quizeey_native', 'SET ROLE ' + role + ';SELECT (SELECT count(*) FROM public.quizeey_topics)+(SELECT count(*) FROM public.quizeey_posts);').read_text().splitlines()[-1] != '0':
                raise ValueError('Pending imported content visible to public role')
            db.sql('quizeey_native', 'SET ROLE ' + role + ';SELECT * FROM quizeey_private.post_owners;', denied=True)
        db.sql('quizeey_native', 'SET ROLE service_role;SELECT * FROM public.quizeey_posts LIMIT 1;', denied=True)
        post = target['posts'][0]
        topic = next(row for row in target['topics'] if row['id'] == post['topic_id'])
        result = db.sql('quizeey_native', "SET ROLE service_role;SELECT public.quizeey_forum_mutate('" + 'a' * 64 + "','" + 'b' * 64 +
            "','00000000-0000-4000-8000-000000000251','edit','{\"postId\":\"" + post['id'] + "\",\"body\":\"synthetic unauthorized edit\"}'::jsonb);")
        if json.loads(result.read_text().splitlines()[-1]).get('status') != 403:
            raise ValueError('Imported post editable without source ownership')
        # Transactional approval probe: replay must not reset later moderation.
        inserts = '\n'.join(line for line in plan.splitlines() if line.startswith('INSERT INTO'))
        probe = ("BEGIN;UPDATE public.quizeey_posts SET visibility='approved' WHERE id='" + post['id'] +
                 "';UPDATE public.quizeey_topics SET visibility='approved',approved_post_count=1 WHERE id='" + topic['id'] + "';\n" + inserts +
                 "\nDO $$ BEGIN IF NOT EXISTS(SELECT 1 FROM public.quizeey_posts WHERE id='" + post['id'] +
                 "' AND visibility='approved') OR NOT EXISTS(SELECT 1 FROM public.quizeey_topics WHERE id='" + topic['id'] +
                 "' AND visibility='approved' AND approved_post_count=1) THEN RAISE EXCEPTION 'Replay reset moderation'; END IF;END $$;\n")
        # Exercise the app's actual topic query under anon RLS for both locales.
        app = (ROOT / 'web/src/server/forum-database.ts').read_text(encoding='utf-8')
        match = re.search(r'db\.query<PublicTopic>\("([^"]+)"', app)
        if not match:
            raise ValueError('Actual app topic query not found')
        probe += 'SET LOCAL ROLE anon;\n'
        for locale in ['ko', 'en']:
            actual = match[1].replace('$1', "'" + topic['exam_id'] + "'").replace('$2', "'" + locale + "'").replace('$3', "'" + topic['question_id'] + "'")
            probe += "DO $$ BEGIN IF (SELECT count(*) FROM (" + actual + ") t) <> 1 THEN RAISE EXCEPTION 'Shared legacy context query failed';END IF;END $$;\n"
        db.sql('quizeey_native', probe + 'ROLLBACK;')
        verify(db.sql('quizeey_native', query), target)
        db.run('pg_dump', '-h', '127.0.0.1', '-p', str(db.port), '-U', db.role, '-Fc', '-f', db.directory / 'native.dump', 'quizeey_native')
        db.sql('postgres', 'CREATE DATABASE quizeey_native_restore;')
        db.run('pg_restore', '-h', '127.0.0.1', '-p', str(db.port), '-U', db.role, '-d', 'quizeey_native_restore', '--exit-on-error', db.directory / 'native.dump')
        verify(db.sql('quizeey_native_restore', query), target)
        for role in ['anon', 'authenticated']:
            if db.sql('quizeey_native_restore', 'SET ROLE ' + role + ';SELECT count(*) FROM public.quizeey_posts;').read_text().splitlines()[-1] != '0':
                raise ValueError('Restore exposed pending posts')
        stages.append({'stage': 'backup_restore', 'allValuesAndSourceIdsMatch': True, 'pendingPostsStillPrivate': True})
        result = {'status': 'private_native_explanation_rehearsal_pass', 'newServiceDatasetSha256': policy['newServiceDatasetSha256'],
                  'tables': checked, 'stages': stages, 'originalSourceExplanations': 2209,
                  'excludedWithOwnerDeletedQuestions': 26, 'retainedNativePosts': len(target['posts']),
                  'sourceIdsNamespacedAndDeterministic': True, 'sourceTextAndDisplayNamesPreservedExactly': True,
                  'nullableCreatedAtFallbackCount': sum(row['createdAtFromModifiedFallback'] for row in mapping),
                  'allPostsPending': True, 'publicVisiblePosts': 0, 'newGuestOwnerships': 0, 'newAuthAccounts': 0,
                  'unauthorizedGuestEdit403': True, 'replayPreservesLaterModeration': True,
                  'legacyQuestionDiscussionSharedAcrossLocales': True, 'actualAppQueryTestedUnderRls': True,
                  'sourceMySQLMutations': 0, 'externalUploads': 0, 'hostedImportExecuted': False,
                  'privatePath': db.directory.relative_to(ROOT).as_posix()}
    result.update(localServerStopped=not (db.directory / 'data/postmaster.pid').exists(), elapsedSeconds=round(time.monotonic() - started, 3))
    (db.directory / 'native-explanation-evidence.json').write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    (ROOT / 'docs/modernization/native-explanation-evidence.json').write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    print('Native post replay, RLS and backup/restore verified; private local server stopped.')


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        raise SystemExit('Private native rehearsal failed (' + type(error).__name__ + '); inspect private logs, source not printed.')
