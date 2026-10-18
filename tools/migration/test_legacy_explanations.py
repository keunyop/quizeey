import copy
import unittest
from legacy_explanations import plaintext, transform, sql_plan


def fixture():
    return {'question': [{'quest_id': '900000001', 'test_id': '5'}], 'explanation': [
        {'expl_id': '920000001', 'quest_id': '900000001', 'user_nm': ' Synthetic ',
         'explanation': "<p>Owner's <CTRL> and <T extends Number></p><script>hidden()</script>",
         'created_date': None, 'modified_date': '2026-10-16 19:00:00'},
        {'expl_id': '920000002', 'quest_id': '900000001', 'user_nm': '', 'explanation': 'Second',
         'created_date': '2026-10-15 19:00:00', 'modified_date': '2026-10-16 19:00:00'}]}


class LegacyExplanationTests(unittest.TestCase):
    def test_original_context_ids_and_deterministic_pending_posts(self):
        target, mapping = transform(fixture())
        self.assertEqual(len(target['topics']), 1)
        self.assertEqual(len(target['posts']), 2)
        self.assertEqual(target, transform(fixture())[0])
        topic = target['topics'][0]
        self.assertEqual((topic['exam_id'], topic['question_id'], topic['source_thread_id']),
                         ('5', '900000001', 'mysql:question:900000001'))
        self.assertEqual(topic['approved_post_count'], 0)
        self.assertTrue(all(row['visibility'] == 'pending' for row in target['posts']))
        self.assertEqual(target['posts'][0]['display_name'], ' Synthetic ')
        self.assertEqual(target['posts'][1]['display_name'], '')
        self.assertTrue(mapping[0]['createdAtFromModifiedFallback'])
        self.assertFalse(mapping[1]['createdAtFromModifiedFallback'])
        self.assertTrue(all(not row['guestOwnershipInferred'] for row in mapping))
        plan = sql_plan(target)
        self.assertIn("Owner''s <CTRL> and <T extends Number>", plan)
        self.assertEqual(plan.count('DO NOTHING'), 2)
        self.assertNotIn('post_owners', plan)

    def test_plain_text_is_preserved_including_literal_markup_and_whitespace(self):
        value = ' <p><CTRL> &amp; <T extends Number></p><script>literal text</script>\n '
        self.assertEqual(plaintext(value), value)
        self.assertEqual(plaintext('   '), '   ')
        self.assertEqual(plaintext(''), '')

    def test_duplicates_orphans_oversized_fields_and_invalid_times_block(self):
        changes = [lambda d: d['explanation'].append(copy.deepcopy(d['explanation'][0])),
                   lambda d: d['explanation'][0].update(quest_id='999999'),
                   lambda d: d['explanation'][0].update(user_nm='x' * 81),
                   lambda d: d['explanation'][0].update(explanation='x' * 4001),
                   lambda d: d['explanation'][0].update(modified_date='not a date')]
        for change in changes:
            with self.subTest(change=change):
                data = fixture()
                change(data)
                with self.assertRaises(ValueError):
                    transform(data)


if __name__ == '__main__':
    unittest.main()
