"""Offline integrity and resume checks; never connect to a hosted database."""
from contextlib import redirect_stdout
from copy import deepcopy
import io
import json
from pathlib import Path
import sys
import tempfile
import unittest
from unittest.mock import patch

import hosted_comments
from legacy_explanations import transform


class HostedCommentsTest(unittest.TestCase):
    def setUp(self):
        self.target = transform({
            'question': [{'quest_id': 123, 'test_id': 5}],
            'explanation': [{'expl_id': 10, 'quest_id': 123, 'user_nm': '작성자',
                'explanation': "한글 ' 원문; V5:value", 'created_date': '2020-01-01T00:00:00',
                'modified_date': '2020-01-02T00:00:00'}],
        })[0]

    def test_hash_preserves_unicode_nulls_and_immutable_values_across_publication(self):
        rows = self.target['posts']
        expected = hosted_comments.framed_hash('posts', rows)
        published = deepcopy(rows)
        published[0]['visibility'] = 'approved'
        published[0]['created_at'] = '2020-01-01T09:00:00+09:00'
        self.assertEqual(hosted_comments.framed_hash('posts', published), expected)
        for field, value in [('body', '다른 원문'), ('display_name', None),
                             ('created_at', '2020-01-01T00:00:01+00:00')]:
            changed = deepcopy(rows)
            changed[0][field] = value
            self.assertNotEqual(hosted_comments.framed_hash('posts', changed), expected)
        blank = deepcopy(rows)
        missing = deepcopy(rows)
        blank[0]['display_name'] = ''
        missing[0]['display_name'] = None
        self.assertNotEqual(hosted_comments.framed_hash('posts', blank),
                            hosted_comments.framed_hash('posts', missing))

    def run_bridge(self, *arguments):
        output = io.StringIO()
        with patch.object(sys, 'argv', ['hosted_comments.py', *arguments]), redirect_stdout(output):
            hosted_comments.main()
        return json.loads(output.getvalue())

    def test_changed_batches_and_unresolved_checkpoints_block_resume(self):
        with tempfile.TemporaryDirectory() as temporary:
            directory = Path(temporary) / 'import'
            with patch.object(hosted_comments, 'DIRECTORY', directory), patch.object(
                    hosted_comments, 'restored_target', return_value=(self.target, None, None,
                        {'sourceSha256': hosted_comments.DATASET})):
                with redirect_stdout(io.StringIO()):
                    hosted_comments.prepare()
                manifest, initial = hosted_comments.load()
                batch = directory / manifest['batches'][0]['file']
                original = batch.read_bytes()
                batch.write_bytes(original + b' ')
                with self.assertRaisesRegex(ValueError, 'Batch changed'):
                    self.run_bridge('--read-index', '0')
                self.assertEqual(hosted_comments.load()[1], initial)
                batch.write_bytes(original)
                self.run_bridge('--read-index', '0')
                with self.assertRaisesRegex(ValueError, 'in-flight batch'):
                    self.run_bridge('--read-index', '1')
                with self.assertRaisesRegex(ValueError, 'Unexpected acknowledgement'):
                    self.run_bridge('--ack-index', '1')
                with self.assertRaisesRegex(ValueError, 'Staging is incomplete'):
                    self.run_bridge('--publish-query')
                self.run_bridge('--ack-index', '0')
                self.run_bridge('--read-index', '1')
                self.run_bridge('--ack-index', '1')
                self.assertEqual(hosted_comments.load()[1]['completed'], [0, 1])


if __name__ == '__main__':
    unittest.main()
