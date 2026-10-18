"""Offline native-forum ETL for approved legacy MySQL explanations.

Source IDs remain namespaced, publication stays pending, and no ownership or
accounts are inferred from display names. Bodies and display names retain their exact source text.
"""
from datetime import datetime, timezone
import re
import uuid
from audit import canonical, digest

KEYS = {'topics': 'source_thread_id', 'posts': 'source_post_id'}
TYPES = {
    'topics': {'id': 'uuid', 'exam_id': 'text', 'question_id': 'text', 'locale': 'text',
               'title': 'text', 'visibility': 'text', 'locked': 'boolean',
               'approved_post_count': 'integer', 'source_thread_id': 'text', 'created_at': 'timestamptz'},
    'posts': {'id': 'uuid', 'topic_id': 'uuid', 'parent_id': 'uuid', 'display_name': 'text',
              'body': 'text', 'visibility': 'text', 'source_post_id': 'text',
              'created_at': 'timestamptz', 'updated_at': 'timestamptz'}
}
# The legacy UI uses innerText for additional explanations (test.js:630),
# unlike question HTML. React TextBody escapes these exact strings as text too.
def plaintext(value):
    if not isinstance(value, str) or '\x00' in value:
        raise ValueError('Invalid legacy post text')
    if len(value) > 4000:
        raise ValueError('Legacy body exceeds native constraint; no truncation allowed')
    value.encode('utf-8', errors='strict')
    return value


def stamp(value):
    if not isinstance(value, str):
        raise ValueError('Missing source timestamp')
    result = datetime.fromisoformat(value)
    if result.tzinfo is None:
        result = result.replace(tzinfo=timezone.utc)
    return result.astimezone(timezone.utc).isoformat(timespec='microseconds')


def identifier(value):
    value = str(value)
    if not re.fullmatch(r'[1-9][0-9]{0,18}', value) or int(value) > 9223372036854775807:
        raise ValueError('Invalid source identifier')
    return value


def stable_id(kind, value):
    return str(uuid.uuid5(uuid.NAMESPACE_URL, 'quizeey:legacy:mysql:' + kind + ':' + value))


def normalize(target):
    result = {}
    for table in KEYS:
        rows = []
        for source in target[table]:
            if set(source) != set(TYPES[table]):
                raise ValueError('Native target columns changed')
            row = dict(source)
            for column, kind in TYPES[table].items():
                if kind == 'timestamptz':
                    row[column] = stamp(row[column])
            rows.append(row)
        result[table] = sorted(rows, key=lambda row: row[KEYS[table]])
    return result


def transform(data):
    questions = {}
    for row in data['question']:
        key = identifier(row['quest_id'])
        if key in questions:
            raise ValueError('Duplicate question ID')
        questions[key] = identifier(row['test_id'])
    topics, posts, mapping, seen = {}, [], [], set()
    for source in data['explanation']:
        id_, question_id = identifier(source['expl_id']), identifier(source['quest_id'])
        if id_ in seen or question_id not in questions:
            raise ValueError('Duplicate explanation ID or missing approved question')
        seen.add(id_)
        name = source['user_nm']
        if name is not None:
            if not isinstance(name, str) or '\x00' in name:
                raise ValueError('Invalid source display name')
            name.encode('utf-8', errors='strict')
            if name is not None and len(name) > 80:
                raise ValueError('Display name exceeds native constraint; no truncation allowed')
        fallback = source['created_date'] is None
        created = stamp(source['modified_date'] if fallback else source['created_date'])
        modified = stamp(source['modified_date'])
        topic_id = stable_id('question', question_id)
        if question_id not in topics:
            topics[question_id] = {'id': topic_id, 'exam_id': questions[question_id], 'question_id': question_id,
                'locale': 'ko', 'title': 'Legacy explanations', 'visibility': 'pending', 'locked': False,
                'approved_post_count': 0, 'source_thread_id': 'mysql:question:' + question_id, 'created_at': created}
        else:
            topics[question_id]['created_at'] = min(topics[question_id]['created_at'], created)
        post = {'id': stable_id('explanation', id_), 'topic_id': topic_id, 'parent_id': None,
                'display_name': name, 'body': plaintext(source['explanation']), 'visibility': 'pending',
                'source_post_id': 'mysql:explanation:' + id_, 'created_at': created, 'updated_at': modified}
        posts.append(post)
        mapping.append({'sourceExplanationId': id_, 'sourceQuestionId': question_id, 'postId': post['id'],
                        'sourceRowSha256': digest(source), 'createdAtFromModifiedFallback': fallback,
                        'bodyNormalized': post['body'] != source['explanation'], 'guestOwnershipInferred': False})
    target = normalize({'topics': list(topics.values()), 'posts': posts})
    return target, sorted(mapping, key=lambda row: row['sourceExplanationId'])


def sql_plan(target):
    lines = ['-- PRIVATE LOCAL REHEARSAL; NOT AUTHORIZATION FOR HOSTED IMPORT.', 'BEGIN;',
             "SET LOCAL TIME ZONE 'UTC';", 'SET LOCAL standard_conforming_strings=on;']
    for table, columns in TYPES.items():
        names = ','.join('"' + name + '"' for name in columns)
        record = ','.join('"' + name + '" ' + kind for name, kind in columns.items())
        for offset in range(0, len(target[table]), 500):
            payload = canonical(target[table][offset:offset + 500]).replace("'", "''")
            # Replays must never reset moderation, ownership or future revisions.
            lines.append('INSERT INTO public.quizeey_' + table + '(' + names + ') SELECT ' + names +
                         " FROM jsonb_to_recordset('" + payload + "'::jsonb) AS r(" + record +
                         ') ON CONFLICT (' + KEYS[table] + ') DO NOTHING;')
    return '\n'.join(lines + ['COMMIT;', ''])


def summaries(target):
    return {table: {'rows': len(rows), 'utcSemanticSha256': digest(rows)} for table, rows in normalize(target).items()}
