"""Synthetic restoration checks; no owner-private archive is read."""
import hashlib
import json
import os
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

import restore_comments


class RestoreCommentsTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix='quizeey-restored-comments-')
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.source = self.root / '.modernization/exports/synthetic'
        self.source.mkdir(parents=True)
        docs = self.root / 'docs/modernization'
        docs.mkdir(parents=True)
        (docs / 'source-snapshot-evidence.json').write_text(json.dumps({'privatePath': '.modernization/exports/synthetic'}), encoding='utf-8')
        questions = [{'quest_id': 10000000 + i, 'test_id': 5} for i in range(630)]
        self.posts = [{'expl_id': 1000000 + i, 'quest_id': questions[i % 630]['quest_id'],
            'user_nm': None if i % 2 else '작성자', 'explanation': "Original ' text & <script>literal</script> 한글 " + str(i),
            'created_date': '2020-01-01T00:00:00', 'modified_date': '2020-01-02T00:00:00'} for i in range(2183)]
        self.raw = json.dumps({'question': questions, 'explanation': self.posts}, ensure_ascii=False).encode('utf-8')
        (self.source / 'new-service-dataset.json').write_bytes(self.raw)
        (self.source / 'publication-candidate-plan.json').write_text(json.dumps({
            'ownerPolicyApproved': True, 'newServiceDatasetSha256': hashlib.sha256(self.raw).hexdigest()}), encoding='utf-8')

    def prepare(self):
        with patch.object(restore_comments, 'ROOT', self.root):
            return restore_comments.prepare()

    def test_preserves_text_names_source_ids_and_timestamps_without_assigning_guest_ownership(self):
        target, sql, _, manifest = self.prepare()
        self.assertEqual(len(target['posts']), 2183)
        self.assertEqual(len(target['topics']), 630)
        original = {str(post['expl_id']): post for post in self.posts}
        for post in target['posts']:
            source = original[post['source_post_id'].split(':')[-1]]
            self.assertEqual(post['body'], source['explanation'])
            self.assertEqual(post['display_name'], source['user_nm'])
            self.assertEqual(post['created_at'], '2020-01-01T00:00:00.000000+00:00')
            self.assertEqual(post['visibility'], 'approved')
        self.assertEqual(sum(topic['approved_post_count'] for topic in target['topics']), 2183)
        self.assertFalse(manifest['guestOwnershipInferred'])
        plan = sql.read_text(encoding='utf-8')
        self.assertIn('ON CONFLICT (source_post_id) DO NOTHING', plan)
        self.assertNotIn('INSERT INTO quizeey_private', plan)
        self.assertEqual((self.source / 'new-service-dataset.json').read_bytes(), self.raw)

    def test_changed_archives_fail_before_sql_is_prepared(self):
        (self.source / 'new-service-dataset.json').write_bytes(self.raw + b' ')
        with self.assertRaisesRegex(ValueError, 'integrity mismatch'):
            self.prepare()
        self.assertFalse((self.source / 'restored-comments-202610').exists())

    @unittest.skipUnless(os.environ.get('QUIZEEY_LOCAL_FORUM_DATABASE_URL') == 'postgresql://quizeey_server@127.0.0.1:55432/quizeey_fixture', 'Explicit isolated local fixture required')
    def test_restore_replay_and_public_rls_in_a_rolled_back_local_transaction(self):
        target, sql, _, _ = self.prepare()
        lines = sql.read_text(encoding='utf-8').splitlines()
        inserts = '\n'.join(line for line in lines if line.startswith('INSERT INTO'))
        ids = ','.join("'" + post['id'] + "'::uuid" for post in target['posts'])
        topics = ','.join("'" + topic['id'] + "'::uuid" for topic in target['topics'])
        count = f"select json_build_object('posts',(select count(*) from public.quizeey_posts where id in ({ids})),'topics',(select count(*) from public.quizeey_topics where id in ({topics})));"
        transaction = 'BEGIN;\n' + inserts + '\nSET LOCAL ROLE anon;\n' + count + '\nRESET ROLE;\n' + inserts + '\nSET LOCAL ROLE authenticated;\n' + count + '\nROLLBACK;'
        results = [json.loads(line) for line in restore_comments.local_query(transaction).splitlines() if line.startswith('{')]
        self.assertEqual(results, [{'posts': 2183, 'topics': 630}] * 2)
        remaining = restore_comments.local_query(f'select count(*) from public.quizeey_posts where id in ({ids});').strip()
        self.assertEqual(remaining, '0')


if __name__ == '__main__':
    unittest.main()
