"""Audit normalized OFFLINE exports and emit replayable private raw staging SQL.

No database connection or production credentials. Live DDL is required before final ETL.
"""
import argparse
import hashlib
import json
import re
from collections import Counter,defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TABLES = {"test": "test_id", "version": "ver_id", "question": "quest_id",
          "example": "exmp_id", "explanation": "expl_id", "question_stats": "quest_id"}


def canonical(value): return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":"))
def digest(value): return hashlib.sha256(canonical(value).encode("utf-8")).hexdigest()
def identifier(value):
    raw = str(value)
    if isinstance(value, bool) or not re.fullmatch(r"[1-9]\d{0,18}", raw) or int(raw) > 9223372036854775807:
        raise ValueError("Invalid source identifier")
    return raw


def can_stage_losslessly(report):
    blockers={'missing_table','missing_primary_key','invalid_identifier','duplicate_primary_key','postgres_unrepresentable_text'}
    return not any(error['issue'] in blockers for error in report['errors'])


def audit(data):
    errors = []
    tables = {}
    aliases = []
    for table, key in TABLES.items():
        rows = data.get(table)
        if not isinstance(rows, list):
            errors.append({"table": table, "issue": "missing_table"})
            rows = []
        normalized = []
        for row in rows:
            if not isinstance(row, dict) or key not in row:
                errors.append({"table": table, "issue": "missing_primary_key"})
                continue
            try:
                item={k: identifier(v) if k.endswith("_id") and v is not None else v for k, v in row.items()}
                item[key]=identifier(item[key])
                for column,value in item.items():
                    if isinstance(value,str) and any(c=='\0' or 0xd800<=ord(c)<=0xdfff for c in value):
                        errors.append({'table':table,'id':item[key],'column':column,'issue':'postgres_unrepresentable_text'})
                normalized.append(item)
            except ValueError:
                errors.append({"table": table, "issue": "invalid_identifier"})
        tables[table] = sorted(normalized, key=lambda r: r[key])
        duplicates = [id_ for id_, count in Counter(row[key] for row in normalized).items() if count > 1]
        for id_ in duplicates: errors.append({"table": table, "id": id_, "issue": "duplicate_primary_key"})

    tests = {r["test_id"] for r in tables["test"]}
    def composite(row, keys): return tuple(str(row.get(key)) for key in keys)
    version_keys = ("test_id", "ver_nbr")
    question_keys = (*version_keys, "quest_nbr")
    for table, keys in [("version", version_keys), ("question", question_keys), ("example", (*question_keys, "exmp_nbr"))]:
        for key, count in Counter(composite(row, keys) for row in tables[table]).items():
            if count > 1: errors.append({"table": table, "key": key, "issue": "duplicate_composite"})
        for row in tables[table]:
            if row.get("test_id") not in tests: errors.append({"table": table, "issue": "orphan_test", "id": row[TABLES[table]]})
    versions = {composite(r, version_keys) for r in tables["version"]}
    question_map=defaultdict(list)
    for row in tables['question']:question_map[composite(row,question_keys)].append(row)
    question_ids = {r["quest_id"] for r in tables["question"]}
    for row in tables["question"]:
        if composite(row, version_keys) not in versions: errors.append({"table": "question", "id": row["quest_id"], "issue": "orphan_version"})
    correct_sets = {r["quest_id"]: [] for r in tables["question"]}
    unresolved_ids={row['quest_id'] for parents in question_map.values() if len(parents)>1 for row in parents}
    def flag(row,table,current,historical):
        # Retain original column names in staging and source hashes. Resolve only for validation.
        if current in row and historical in row and row[current] != row[historical]:
            errors.append({'table':table,'id':row[TABLES[table]],'issue':'conflicting_flag_columns'})
        if historical in row:
            aliases.append({'table':table,'sourceColumn':historical,'canonicalColumn':current})
        value=row[current] if current in row else row.get(historical,'')
        return str(value).upper()
    for row in tables["example"]:
        parents = question_map.get(composite(row, question_keys),[])
        if not parents: errors.append({"table": "example", "id": row["exmp_id"], "issue": "orphan_question"})
        if len(parents)>1:errors.append({'table':'example','id':row['exmp_id'],'issue':'ambiguous_question'})
        answer = flag(row,'example','answer_yn','answer')
        if answer not in {"Y", "N"}: errors.append({"table": "example", "id": row["exmp_id"], "issue": "unknown_answer_flag"})
        if len(parents)==1 and answer == "Y": correct_sets[parents[0]["quest_id"]].append(row["exmp_id"])
    for row in tables["question"]:
        correct = correct_sets[row["quest_id"]]
        multi = flag(row,'question','multi_answer_yn','is_multi_answer')
        if row['quest_id'] in unresolved_ids:continue
        if not correct or multi not in {"Y", "N"} or (multi == "N" and len(correct) != 1) or (multi == "Y" and len(correct) < 2):
            errors.append({"table": "question", "id": row["quest_id"], "issue": "correct_set_mismatch"})
    for table in ["explanation", "question_stats"]:
        for row in tables[table]:
            if row.get("quest_id") not in question_ids: errors.append({"table": table, "id": row[TABLES[table]], "issue": "orphan_question"})
    for row in tables["question_stats"]:
        if any(type(row.get(key)) is not int or row[key] < 0 for key in ["correct", "in_correct"]):
            errors.append({"table": "question_stats", "id": row["quest_id"], "issue": "invalid_counter"})
    summaries = {name: {"rows": len(rows), "sha256": digest(rows)} for name, rows in tables.items()}
    groups = Counter((r.get("test_id"), r.get("ver_nbr")) for r in tables["question"])
    question_groups=defaultdict(list);example_groups=defaultdict(list);counters_by_question=defaultdict(list)
    for row in tables['question']:question_groups[(row.get('test_id'),row.get('ver_nbr'))].append(row)
    for row in tables['example']:example_groups[(row.get('test_id'),row.get('ver_nbr'))].append(row)
    for row in tables['question_stats']:counters_by_question[row.get('quest_id')].append(row)
    resolved_sets={id_:None if id_ in unresolved_ids else sorted(values) for id_,values in correct_sets.items()}
    group_summaries=[]
    for key,count in sorted(groups.items(),key=lambda item:str(item[0])):
        questions=question_groups[key]
        ids={row['quest_id'] for row in questions}
        examples=example_groups[key]
        counters=sorted([row for id_ in ids for row in counters_by_question[id_]],key=lambda row:row['quest_id'])
        group_summaries.append({'testId':key[0],'version':key[1],'count':count,'questionSha256':digest(questions),'choiceCount':len(examples),'choiceSha256':digest(examples),'counterCount':len(counters),'counterSha256':digest(counters),'correctChoiceSetSha256':digest({id_:resolved_sets[id_] for id_ in sorted(ids)})})
    report = {"schema": 3, "tables": summaries, "questionsByExamVersion": group_summaries,
              'columnAliases':sorted({canonical(alias):alias for alias in aliases}.values(),key=canonical),
              "correctChoiceSets": dict(sorted(resolved_sets.items())), 'unresolvedCorrectChoiceQuestionIds':sorted(unresolved_ids),'errors': errors,
              "status": "pass" if not errors else "blocked", "liveSchemaVerified": False}
    return report, tables


def staging_sql(tables):
    def quote(value): return "'" + value.replace("'", "''") + "'"
    lines = ["-- OFFLINE RAW STAGING ONLY; NOT FINAL PRODUCTION ETL.", "BEGIN;", "SET LOCAL standard_conforming_strings = on;"]
    for table, rows in sorted(tables.items()):
        # Bound statements while avoiding a network round trip for every source row.
        for offset in range(0,len(rows),500):
            batch=[]
            for row in rows[offset:offset+500]:
                values = [table, row[TABLES[table]], digest(row), canonical(row)]
                batch.append('(' + ','.join(quote(v) for v in values) + ')')
            lines.append("INSERT INTO quizeey_import.raw_rows(source_table,source_id,source_sha256,payload) VALUES " + ',\n'.join(batch) + " ON CONFLICT (source_table,source_id) DO UPDATE SET source_sha256=excluded.source_sha256,payload=excluded.payload WHERE raw_rows.source_sha256 IS DISTINCT FROM excluded.source_sha256;")
    lines.append("COMMIT;")
    return "\n".join(lines) + "\n"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("input", type=Path)
    parser.add_argument("--output-dir", type=Path, default=ROOT / ".modernization/migration")
    parser.add_argument('--allow-raw-relational-errors',action='store_true',help='Preserve identifiable rows in private raw staging despite unresolved relationships; publication remains blocked')
    args = parser.parse_args()
    destination = args.output_dir.resolve()
    safe_root = (ROOT / ".modernization").resolve()
    if not destination.is_relative_to(safe_root): parser.error("Outputs with source content must stay in ignored .modernization/")
    if args.input.stat().st_size > 100_000_000: parser.error("Use bounded export partitions under 100 MB")
    report, tables = audit(json.loads(args.input.read_text(encoding="utf-8-sig")))
    destination.mkdir(parents=True, exist_ok=True)
    (destination / "reconciliation.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    if report["errors"] and not (args.allow_raw_relational_errors and can_stage_losslessly(report)):
        raise SystemExit("Reconciliation blocked; inspect private report. No SQL emitted.")
    (destination / "raw-staging.sql").write_text(staging_sql(tables), encoding="utf-8")
    print('Private raw staging SQL emitted; no DB connection made. '+('Publication BLOCKED by unresolved data issues.' if report['errors'] else 'Offline reconciliation passed.'))


if __name__ == "__main__": main()
