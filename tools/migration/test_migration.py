import copy
import unittest
import json
import tempfile
from pathlib import Path
from audit import ROOT, TABLES, audit, staging_sql,can_stage_losslessly
from audit import digest
from rehearse_snapshot import verified_rows
from source_contract import validate_contract, inspect_markup, relationship_review, review_html
from typed_archive import archive_sql, semantic_hash
from publication_plan import candidate_plan, apply_new_service_deletion
from content_etl import transform, sql_plan, summaries
from rehearse_content import verify as verify_content
from disqus_import import normalize


def fixture():
    return {
        "test": [{"test_id": "5", "test_nm": "Synthetic SQL"}],
        "version": [{"ver_id": "700000001", "test_id": "5", "ver_nbr": 1}],
        "question": [{"quest_id": "900000001", "test_id": "5", "ver_nbr": 1, "quest_nbr": 1, "multi_answer_yn": "Y", "quest_txt": "Synthetic owner's SQL"}],
        "example": [{"exmp_id": str(910000000+i), "test_id": "5", "ver_nbr": 1, "quest_nbr": 1, "exmp_nbr": i, "answer_yn": "Y"} for i in [1, 2]],
        "explanation": [{"expl_id": "920000001", "quest_id": "900000001", "user_nm": "", "explanation": "Synthetic"}],
        "question_stats": [{"quest_id": "900000001", "correct": 2, "in_correct": 1}],
    }


def full_fixture():
    schema=json.loads((ROOT/'tools/migration/verified_schema.json').read_text(encoding='utf-8'))
    data=fixture()
    for table,rows in data.items():
        for row in rows:
            for column in schema['columns']:
                if column['TABLE_NAME']!=table or column['COLUMN_NAME'] in row:continue
                kind=column['COLUMN_TYPE']
                row[column['COLUMN_NAME']]=(None if column['IS_NULLABLE']=='YES' else '1' if kind.startswith('bigint(')
                                           else 1 if kind.startswith('int(') else '2026-10-16 19:00:00' if kind=='timestamp' else 'Synthetic')
    return data,schema


class MigrationTests(unittest.TestCase):
    def test_relational_content_etl_maps_unique_parent_ids_and_preserves_values(self):
        data,schema=full_fixture();target=transform(data,schema)
        self.assertEqual(target['questions'][0]['question_id'],'900000001')
        self.assertEqual(target['questions'][0]['version_id'],'700000001')
        self.assertEqual(target['choices'][0]['question_id'],'900000001')
        self.assertTrue(target['questions'][0]['multiple_answers'])
        self.assertEqual(target['legacy_counters'][0]['correct'],2)
        self.assertTrue(target['questions'][0]['created_at'].endswith('+00:00'))
        self.assertIsNone(target['questions'][0]['reference'])
        plan=sql_plan(target,schema)
        self.assertIn('jsonb_to_recordset',plan);self.assertIn("owner''s SQL",plan)
        self.assertEqual(plan.count('SELECT setval('),4)
        duplicate=copy.deepcopy(data['question'][0]);duplicate['quest_id']='900000002';data['question'].append(duplicate)
        with self.assertRaises(ValueError):transform(data,schema)

    def test_relational_target_reconciliation_rejects_reassigned_choices(self):
        data,schema=full_fixture();target=transform(data,schema)
        lines=[json.dumps([table,row]) for table,rows in target.items() for row in rows]
        with tempfile.TemporaryDirectory() as folder:
            file=Path(folder)/'target.ndjson';file.write_text('\n'.join(lines),encoding='utf-8')
            self.assertEqual(verify_content(file,target),summaries(target))
            changed=copy.deepcopy(target);changed['choices'][0]['question_id']='999'
            file.write_text('\n'.join(json.dumps([table,row]) for table,rows in changed.items() for row in rows),encoding='utf-8')
            with self.assertRaises(ValueError):verify_content(file,target)

    def test_approved_new_service_deletion_is_exact_and_preserves_unrelated_archive_rows(self):
        data=fixture();data['example'].append({**data['example'][0],'exmp_id':'910000003'})
        data['question_stats'].append({'quest_id':'999','correct':1,'in_correct':0})
        before=digest(data);plan,details,_=candidate_plan(data)
        approved,_,subset=apply_new_service_deletion(data,1,plan['reviewQuestionIdSetSha256'])
        self.assertEqual(approved['removedQuestionsFromNewDataset'],1)
        self.assertEqual(approved['relatedRowsExcluded'],{'question':1,'example':3,'explanation':1,'question_stats':1})
        self.assertEqual(approved['unrelatedUnlinkedRowsPreservedPrivately']['question_stats'],1)
        self.assertEqual(subset['question'],[]);self.assertEqual(digest(data),before)
        self.assertTrue(approved['ownerPolicyApproved']);self.assertFalse(approved['publicationAllowed'])
        for count,sha in [(2,plan['reviewQuestionIdSetSha256']),(1,'0'*64)]:
            with self.assertRaises(ValueError):apply_new_service_deletion(data,count,sha)

    def test_candidate_plan_holds_only_affected_questions_without_deleting_source(self):
        data=fixture()
        source=copy.deepcopy(data)
        plan,details,subset=candidate_plan(data)
        self.assertEqual(plan['structurallyEligibleQuestions'],1)
        self.assertFalse(plan['publicationAllowed']);self.assertFalse(plan['ownerPolicyApproved'])
        duplicate=copy.deepcopy(data['question'][0]);duplicate['quest_id']='900000002';data['question'].append(duplicate)
        good=copy.deepcopy(data['question'][0]);good['quest_id']='900000003';good['quest_nbr']=2;data['question'].append(good)
        for index in [1,2]:
            choice=copy.deepcopy(data['example'][index-1]);choice['exmp_id']=str(910000002+index);choice['quest_nbr']=2;data['example'].append(choice)
        plan,details,subset=candidate_plan(data)
        self.assertEqual(plan['reviewPendingQuestions'],2)
        self.assertEqual(details['eligibleQuestionIds'],['900000003'])
        self.assertEqual(audit(subset)[0]['errors'],[])
        self.assertEqual(plan['originalRowsDeleted'],0);self.assertEqual(len(data['question']),3)
        self.assertEqual(data['test'],source['test'])

    def test_choice_number_conflict_holds_question_and_orphan_children_remain_archived(self):
        data=fixture()
        duplicate=copy.deepcopy(data['example'][0]);duplicate['exmp_id']='910000003';data['example'].append(duplicate)
        data['question_stats'].append({'quest_id':'999','correct':1,'in_correct':0})
        plan,details,_=candidate_plan(data)
        self.assertEqual(plan['reviewPendingQuestions'],1)
        self.assertIn('choice_duplicate_composite',details['questionReasons']['900000001'])
        self.assertEqual(plan['retainedSourceCounts']['question_stats'],2)
        self.assertEqual(plan['excludedFromCandidateCounts']['question_stats'],2)

    def test_relationship_review_keeps_duplicate_ids_and_shared_source_choice_candidates(self):
        data=fixture()
        data['question'][0]['explanation']=None;data['question'][0]['reference']=None
        for row in data['example']:row['exmp_txt']='Synthetic choice'
        duplicate=copy.deepcopy(data['question'][0]);duplicate['quest_id']='900000002';data['question'].append(duplicate)
        summary,review=relationship_review(data)
        self.assertEqual(summary['identicalQuestionContentGroups'],1)
        self.assertEqual(review['questionGroups'][0]['questionIds'],['900000001','900000002'])
        self.assertEqual(review['questionGroups'][0]['sourceSharedChoiceIds'],['910000001','910000002'])
        self.assertFalse(summary['publicationAllowed'])
        duplicate['quest_txt']='Different question'
        summary,_=relationship_review(data)
        self.assertEqual(summary['differingQuestionContentGroups'],1)
        duplicate['quest_txt']='<script>bad()</script><img src="https://private.test/a">'
        page=review_html(data,review)
        self.assertNotIn('<script>',page);self.assertNotIn('<img',page)
        self.assertIn('&lt;script&gt;',page)
        self.assertIn("default-src 'none'",page)

    def test_typed_archive_preserves_original_ids_and_utc_instant_without_guessing_links(self):
        schema=json.loads((ROOT/'tools/migration/verified_schema.json').read_text(encoding='utf-8'))
        rows=[{}]
        for column in schema['columns']:
            if column['TABLE_NAME'] != 'question':continue
            kind=column['COLUMN_TYPE']
            rows[0][column['COLUMN_NAME']]=('9007199254740993' if kind.startswith('bigint(') else 1 if kind.startswith('int(')
                                         else '2020-01-01 00:00:00' if kind=='timestamp' else '한글')
        restored=copy.deepcopy(rows)
        restored[0]['quest_id']=9007199254740993
        restored[0]['test_id']=9007199254740993
        restored[0]['created_date']='2019-12-31T16:00:00-08:00'
        restored[0]['modified_date']='2020-01-01T00:00:00+00:00'
        self.assertEqual(semantic_hash('question',rows,schema),semantic_hash('question',restored,schema))
        restored[0]['created_date']='2020-01-01T00:00:01+00:00'
        self.assertNotEqual(semantic_hash('question',rows,schema),semantic_hash('question',restored,schema))
        plan=archive_sql(schema)
        self.assertIn("SET LOCAL TIME ZONE 'UTC'",plan)
        self.assertEqual(plan.count('INSERT INTO quizeey_legacy.'),6)
        self.assertEqual(plan.count('SELECT setval('),5)
        self.assertNotIn('quest_nbr=',plan)
        self.assertIn('ON CONFLICT (quest_id)',plan)
        schema['schemaVerified']=False
        with self.assertRaises(ValueError):archive_sql(schema)

    def test_actual_schema_width_null_integer_and_timestamp_contract(self):
        schema=json.loads((ROOT/'tools/migration/verified_schema.json').read_text(encoding='utf-8'))
        data={table:[{}] for table in TABLES}
        for column in schema['columns']:
            kind=column['COLUMN_TYPE']
            value=('1' if kind.startswith('bigint(') else 1 if kind.startswith('int(')
                   else '2026-10-16 19:13:19.000000' if kind=='timestamp' else 'x')
            data[column['TABLE_NAME']][0][column['COLUMN_NAME']]=value
        data['question'][0]['explanation']='한'*4000
        data['question'][0]['reference']='r'*1000
        data['test'][0]['test_nm']=None
        data['explanation'][0]['created_date']=None
        self.assertEqual(validate_contract(data,schema),[])
        data['question'][0]['reference']='r'*1001
        data['example'][0]['created_date']='0000-00-00 00:00:00'
        data['example'][0]['exmp_nbr']=True
        data['version'][0]['ver_nm']=None
        data['test'][0]['unexpected']='x'
        self.assertEqual({e['issue'] for e in validate_contract(data,schema)},
                         {'text_width_exceeded','invalid_source_timestamp','invalid_integer','unexpected_null','column_set_mismatch'})

    def test_private_asset_inventory_counts_active_markup_without_fetching(self):
        data=fixture()
        data['question'][0]['quest_txt']='<private-placeholder><img src="/asset.png?private=value" onerror="bad()"><script>bad()</script><a href="javascript:bad()">x</a><p style="background:url(/paper.png)">한글</p>'
        summary,references=inspect_markup(data)
        self.assertEqual(summary['referenceOccurrences'],3)
        self.assertEqual(summary['markupRiskOccurrences'],{'event_attribute':1,'active_tag_script':1,'active_url_scheme':1})
        self.assertEqual(summary['externalFetches'],0)
        self.assertNotIn('private=value',json.dumps(summary))
        self.assertNotIn('private-placeholder',json.dumps(summary))
        self.assertTrue(any(r['value']=='/asset.png?private=value' for r in references))

    def test_postgres_roundtrip_checks_payload_identity_and_full_reconciliation(self):
        data=fixture()
        data['question'][0]['quest_txt']='한글 "SQL" \\ path\nsecond line'
        report,tables=audit(data)
        encoded=[json.dumps([table,str(row[key]),digest(row),row],ensure_ascii=False)
                 for table,key in TABLES.items() for row in tables[table]]
        with tempfile.TemporaryDirectory() as folder:
            path=Path(folder)/'raw.ndjson'
            path.write_text('\n'.join(encoded)+'\n',encoding='utf-8')
            # Reports are persisted JSON; composite tuples become lists on disk.
            self.assertEqual(verified_rows(path,json.loads(json.dumps(report))),7)
            corrupt=json.loads(encoded[0]);corrupt[1]='999'
            path.write_text(json.dumps(corrupt)+'\n'+'\n'.join(encoded[1:]),encoding='utf-8')
            with self.assertRaises(ValueError):verified_rows(path,report)
            path.write_text('\n'.join(encoded[:-1]),encoding='utf-8')
            with self.assertRaises(ValueError):verified_rows(path,report)
            corrupt=json.loads(encoded[0]);corrupt[3]['test_nm']='Changed'
            path.write_text(json.dumps(corrupt)+'\n'+'\n'.join(encoded[1:]),encoding='utf-8')
            with self.assertRaises(ValueError):verified_rows(path,report)

    def test_idempotent_plan_and_hashes(self):
        data = fixture()
        report, tables = audit(data)
        repeated, rows = audit(copy.deepcopy(data))
        self.assertEqual(report, repeated)
        self.assertEqual(staging_sql(tables), staging_sql(rows))
        self.assertEqual(report["errors"], [])
        self.assertIn("owner''s SQL", staging_sql(tables))
        self.assertEqual(report["correctChoiceSets"]["900000001"], ["910000001", "910000002"])

    def test_orphan_duplicate_and_wrong_answer_set(self):
        data = fixture()
        data["version"].append(copy.deepcopy(data["version"][0]))
        data["question"][0]["multi_answer_yn"] = "N"
        data["example"][0]["quest_nbr"] = 99
        data["explanation"][0]["quest_id"] = "999"
        report, _ = audit(data)
        issues = {e["issue"] for e in report["errors"]}
        self.assertTrue({"duplicate_primary_key", "duplicate_composite", "orphan_question"}.issubset(issues))

    def test_counter_and_bigint_validation(self):
        data = fixture()
        data["question_stats"][0]["correct"] = -1
        data["test"][0]["test_id"] = "9223372036854775808"
        report, _ = audit(data)
        self.assertTrue(any(e["issue"] == "invalid_identifier" for e in report["errors"]))
        self.assertTrue(any(e["issue"] == "invalid_counter" for e in report["errors"]))

    def test_changed_rows_change_hashes(self):
        data = fixture()
        before, _ = audit(data)
        data["example"][0]["answer_yn"] = "N"
        after, _ = audit(data)
        self.assertNotEqual(before["tables"]["example"]["sha256"], after["tables"]["example"]["sha256"])
        self.assertTrue(any(e["issue"] == "correct_set_mismatch" for e in after["errors"]))

    def test_supplied_ddl_flags_are_validated_without_rewriting_raw_columns(self):
        data=fixture()
        data['question'][0]['is_multi_answer']=data['question'][0].pop('multi_answer_yn')
        for row in data['example']: row['answer']=row.pop('answer_yn')
        report,rows=audit(data)
        self.assertEqual(report['errors'],[])
        self.assertEqual(len(report['columnAliases']),2)
        self.assertIn('answer',rows['example'][0]);self.assertNotIn('answer_yn',rows['example'][0])
        data['example'][0]['answer_yn']='N'
        report,_=audit(data)
        self.assertIn('conflicting_flag_columns',{e['issue'] for e in report['errors']})

    def test_group_reconciliation_detects_changed_counters_and_choices(self):
        data=fixture();before,_=audit(data)
        data['question_stats'][0]['correct']+=1
        after,_=audit(data)
        self.assertNotEqual(before['questionsByExamVersion'][0]['counterSha256'],after['questionsByExamVersion'][0]['counterSha256'])
        self.assertEqual(before['questionsByExamVersion'][0]['questionSha256'],after['questionsByExamVersion'][0]['questionSha256'])
        data['example'][0]['answer_yn']='N';changed,_=audit(data)
        self.assertNotEqual(after['questionsByExamVersion'][0]['correctChoiceSetSha256'],changed['questionsByExamVersion'][0]['correctChoiceSetSha256'])

    def test_duplicate_question_composite_never_claims_choices_for_one_arbitrary_id(self):
        data=fixture();second=copy.deepcopy(data['question'][0]);second['quest_id']='900000002';data['question'].append(second)
        report,rows=audit(data)
        self.assertEqual(report['unresolvedCorrectChoiceQuestionIds'],['900000001','900000002'])
        self.assertIsNone(report['correctChoiceSets']['900000001']);self.assertIsNone(report['correctChoiceSets']['900000002'])
        self.assertTrue(any(e['issue']=='ambiguous_question' for e in report['errors']))
        self.assertTrue(can_stage_losslessly(report));self.assertEqual(len(rows['question']),2)
        self.assertIn('900000002',staging_sql(rows))

    def test_lossless_raw_mode_blocks_missing_ids_duplicate_primary_keys_and_null_bytes(self):
        for change in ['null_id','duplicate_id','null_byte']:
            data=fixture()
            if change=='null_id':data['question'][0]['quest_id']=None
            elif change=='duplicate_id':data['question'].append(copy.deepcopy(data['question'][0]))
            else:data['question'][0]['quest_txt']='Unrepresentable\0text'
            report,_=audit(data)
            self.assertFalse(can_stage_losslessly(report))


XML = '''<disqus xmlns:dsq="http://disqus.com/disqus-internals"><thread dsq:id="t1"><isPrivate>false</isPrivate></thread>
<post dsq:id="p1"><message><![CDATA[<p>Hello</p><script>bad()</script>]]></message><createdAt>2020-01-01T00:00:00Z</createdAt><isDeleted>false</isDeleted><isSpam>false</isSpam><author><name>A</name><email>private@example.test</email></author><ipAddress>127.0.0.1</ipAddress><thread dsq:id="t1"/></post>
<post dsq:id="p2"><message>Reply</message><isDeleted>false</isDeleted><isSpam>false</isSpam><thread dsq:id="t1"/><parent dsq:id="p1"/></post>
<post dsq:id="p3"><message>Deleted</message><isDeleted>true</isDeleted><thread dsq:id="t1"/></post></disqus>'''
MAP = {"t1": {"testId": "5", "questId": "900000001", "locale": "ko", "allowPublicImport": True}}


class DisqusTests(unittest.TestCase):
    def test_repeatable_relationships_privacy_and_no_claim(self):
        posts, report = normalize(XML, MAP)
        self.assertEqual(normalize(XML, MAP), (posts, report))
        self.assertEqual(len(posts), 2)
        self.assertEqual(posts[1]["parentSourceId"], "p1")
        self.assertEqual(posts[0]["body"], "Hello")
        self.assertEqual(posts[0]["visibility"], "approved")
        self.assertIsNone(posts[0]["guestOwnership"])
        self.assertNotIn("private@example", str(posts))
        self.assertNotIn("ipAddress", str(posts))
        self.assertEqual(report["excludedSourceIds"], ["p3"])

    def test_unknown_visibility_stays_pending(self):
        posts, _ = normalize(XML.replace("<isSpam>false</isSpam>", ""), MAP)
        self.assertTrue(all(p["visibility"] == "pending" for p in posts))

    def test_explicit_mapping_and_parent_are_required(self):
        _, report = normalize(XML, {})
        self.assertTrue(any(e["issue"] == "unmapped_thread" for e in report["errors"]))
        _, report = normalize(XML.replace('parent dsq:id="p1"', 'parent dsq:id="p3"'), MAP)
        self.assertTrue(any(e["issue"] == "missing_or_cross_thread_parent" for e in report["errors"]))

    def test_rejects_entity_expansion(self):
        with self.assertRaises(ValueError): normalize('<!DOCTYPE x [<!ENTITY y "z">]><disqus/>', MAP)

    def test_cyclic_parents_are_not_silently_imported(self):
        xml=XML.replace('<thread dsq:id="t1"/></post>', '<thread dsq:id="t1"/><parent dsq:id="p2"/></post>',1)
        _,report=normalize(xml,MAP)
        self.assertTrue(any(e['issue']=='cyclic_parent' for e in report['errors']))


if __name__ == "__main__": unittest.main()
