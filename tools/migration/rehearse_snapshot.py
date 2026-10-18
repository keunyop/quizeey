"""Rehearse an approved, owner-private snapshot on a NEW local PostgreSQL cluster.

Never connects to an existing server or publishes source rows. SQL, database files,
logs and backups inherit the snapshot directory's owner-only ACL. Port 55434 is
reserved for this rehearsal and is deliberately different from the web fixture.
"""
import argparse
from collections import Counter
import hashlib
import json
import os
from pathlib import Path
import secrets
import shutil
import socket
import subprocess
import time
import uuid

from audit import TABLES, audit, can_stage_losslessly, digest
from source_contract import validate_contract
from typed_archive import archive_sql, definitions, semantic_hash

ROOT = Path(__file__).resolve().parents[2]
PORT = 55434
ROLE = 'quizeey_rehearsal'
HIDDEN = subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0


def verified_rows(path, expected):
    """Read private psql output and independently check each payload and source ID."""
    data = {table: [] for table in TABLES}
    seen = set()
    with path.open(encoding='utf-8') as stream:
        for line in stream:
            row = json.loads(line)
            table, source_id, sha, payload = row
            if table not in TABLES or (table, source_id) in seen:
                raise ValueError('Unexpected or duplicate raw row')
            seen.add((table, source_id))
            if str(payload.get(TABLES[table])) != source_id or digest(payload) != sha:
                raise ValueError('Raw payload or identity changed')
            data[table].append(payload)
    report, _ = audit(data)
    for key in ['tables', 'questionsByExamVersion', 'correctChoiceSets',
                'unresolvedCorrectChoiceQuestionIds', 'errors', 'columnAliases']:
        if digest(report[key]) != digest(expected[key]):
            raise ValueError('Reconciliation changed: ' + key)
    return len(seen)


def verified_archive_rows(path, original, schema):
    data = {table: [] for table in TABLES}
    with path.open(encoding='utf-8') as stream:
        for line in stream:
            table, row = json.loads(line)
            if table not in data: raise ValueError('Unexpected archive table')
            data[table].append(row)
    summaries = {}
    for table in TABLES:
        expected = semantic_hash(table, original[table], schema)
        actual = semantic_hash(table, data[table], schema)
        if expected != actual: raise ValueError('Archive UTC/value reconciliation changed: ' + table)
        summaries[table] = {'rows': len(data[table]), 'utcSemanticSha256': actual}
    return summaries


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('snapshot', type=Path, help='Owner-private .modernization/exports/source-* directory')
    args = parser.parse_args()
    source = args.snapshot.resolve()
    safe_root = (ROOT / '.modernization/exports').resolve()
    if not source.is_relative_to(safe_root) or not source.is_dir():
        parser.error('Only a private source snapshot under .modernization/exports is allowed')
    # Windows DACL must be protected and must grant access to the current owner only.
    if os.name == 'nt':
        script = ('$a=Get-Acl -LiteralPath $env:QUIZEEY_SOURCE_ACL_PATH; $s=[System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value; '
                  '$o=$a.GetOwner([System.Security.Principal.SecurityIdentifier]).Value; '
                  'if(-not $a.AreAccessRulesProtected -or $o -ne $s){exit 3}; '
                  'foreach($r in $a.GetAccessRules($true,$true,[System.Security.Principal.SecurityIdentifier]))'
                  '{if($r.IdentityReference.Value -ne $s){exit 4}}')
        acl = subprocess.run(['powershell.exe', '-NoProfile', '-Command', script],
                             capture_output=True, creationflags=HIDDEN,
                             env={**os.environ, 'QUIZEEY_SOURCE_ACL_PATH': str(source)})
        if acl.returncode: raise RuntimeError('Owner-only source directory ACL required')
    elif source.stat().st_mode & 0o077:
        raise RuntimeError('Owner-only source directory permissions required')
    evidence = json.loads((source / 'snapshot-evidence.json').read_text(encoding='utf-8'))
    if evidence.get('status') != 'consistent_read_only_snapshot' or not evidence.get('sessionReadOnly'):
        raise RuntimeError('Verified READ ONLY source snapshot required')
    report = json.loads((source / 'rehearsal/reconciliation.json').read_text(encoding='utf-8'))
    for filename, hash_key in [('snapshot.ndjson', 'snapshotSha256'), ('normalized.json', 'normalizedSha256')]:
        with (source / filename).open('rb') as stream:
            if hashlib.file_digest(stream, 'sha256').hexdigest() != evidence[hash_key]:
                raise RuntimeError('Source snapshot hash changed')
    original = json.loads((source / 'normalized.json').read_text(encoding='utf-8'))
    current, _ = audit(original)
    if digest(current) != digest(report): raise RuntimeError('Audit report changed')
    schema = json.loads((ROOT / 'tools/migration/verified_schema.json').read_text(encoding='utf-8'))
    if validate_contract(original, schema): raise RuntimeError('Verified source type contract failed')
    if not can_stage_losslessly(report): raise RuntimeError('Lossless staging validation failed')
    expected_count = sum(item['rows'] for item in report['tables'].values())
    if {t: item['rows'] for t, item in report['tables'].items()} != evidence['tables']:
        raise RuntimeError('Source snapshot counts changed')
    binary = Path(shutil.which('psql') or '').parent
    suffix = '.exe' if os.name == 'nt' else ''
    for name in ['initdb', 'pg_ctl', 'psql', 'pg_dump', 'pg_restore']:
        if not (binary / (name + suffix)).is_file(): raise RuntimeError('PostgreSQL tools required')
    with socket.socket() as sock:
        if sock.connect_ex(('127.0.0.1', PORT)) == 0: raise RuntimeError('Rehearsal port occupied; refusing to connect')
    destination = source / ('postgres-' + uuid.uuid4().hex[:10])
    destination.mkdir(mode=0o700)
    password = secrets.token_urlsafe(40)
    environment = {**os.environ, 'LC_ALL': 'C', 'PGCLIENTENCODING': 'UTF8', 'PGPASSWORD': password}
    # Clear libpq variables which could silently change connection targets/options.
    for key in list(environment):
        if key.startswith('PG') and key not in ['PGCLIENTENCODING', 'PGPASSWORD']: del environment[key]
    index = 0

    def run(name, *arguments, input=None, expect_failure=False):
        nonlocal index
        index += 1
        output = destination / ('command-%02d.stdout' % index)
        error = destination / ('command-%02d.stderr' % index)
        with output.open('wb') as out, error.open('wb') as err:
            result = subprocess.run([str(binary / (name + suffix)), *map(str, arguments)],
                                    input=input, encoding='utf-8', stdout=out, stderr=err,
                                    creationflags=HIDDEN, env=environment, timeout=180)
        if (result.returncode == 0) == expect_failure:
            raise RuntimeError('Private rehearsal command failed: ' + name + '; inspect private logs')
        if expect_failure and '42501' not in error.read_text(encoding='utf-8', errors='replace'):
            raise RuntimeError('Expected insufficient privilege SQLSTATE')
        return output

    common = ['-X', '-h', '127.0.0.1', '-p', str(PORT), '-U', ROLE, '-v', 'ON_ERROR_STOP=1']
    password_file = destination / 'init-password.tmp'
    password_file.write_text(password, encoding='utf-8')
    started = time.monotonic()
    try:
        run('initdb', '-D', destination / 'data', '--username=' + ROLE, '--locale=C', '--encoding=UTF8',
            '--auth=scram-sha-256', '--pwfile=' + str(password_file))
    finally:
        password_file.unlink(missing_ok=True)
    summary = None
    try:
        run('pg_ctl', '-D', destination / 'data', '-l', destination / 'server.log',
            '-o', '-h 127.0.0.1 -p ' + str(PORT), '-w', 'start')
        run('psql', *common, '-d', 'postgres', input='CREATE ROLE anon; CREATE ROLE authenticated; CREATE ROLE service_role BYPASSRLS; CREATE DATABASE quizeey_archive;')
        for name in ['202610160001_raw_staging.sql', '202610160005_legacy_archive.sql']:
            run('psql', *common, '-d', 'quizeey_archive', '-f', ROOT / 'supabase/migrations' / name)
        plan = source / 'rehearsal/raw-staging.sql'
        query = "SELECT json_build_array(source_table,source_id,source_sha256,payload)::text FROM quizeey_import.raw_rows ORDER BY source_table,source_id;"
        typed_plan = archive_sql(schema)
        (destination / 'typed-archive.sql').write_text(typed_plan, encoding='utf-8')
        typed_query = '\n'.join("SELECT json_build_array('"+table+"',to_jsonb(t)) FROM quizeey_legacy."+table+' t ORDER BY '+key+';' for table,key in TABLES.items())
        stages = []
        for attempt in [1, 2]:
            run('psql', *common, '-d', 'quizeey_archive', '-f', plan)
            output = run('psql', *common, '-d', 'quizeey_archive', '-At', input=query)
            count = verified_rows(output, report)
            if count != expected_count: raise RuntimeError('Imported row count changed')
            run('psql', *common, '-d', 'quizeey_archive', input=typed_plan)
            output = run('psql', *common, '-d', 'quizeey_archive', '-At', input=typed_query)
            typed_summary = verified_archive_rows(output, original, schema)
            # Probe consumes one unused LOCAL sequence value; PostgreSQL sequence
            # increments do not roll back. No source server is contacted.
            for table, columns in definitions(schema).items():
                identity = next((c for c in columns if c.get('EXTRA') == 'auto_increment'), None)
                if identity:
                    key = identity['COLUMN_NAME']
                    check = "DO $$ BEGIN IF nextval(pg_get_serial_sequence('quizeey_legacy."+table+"','"+key+"')) <= (SELECT coalesce(max("+key+"),0) FROM quizeey_legacy."+table+") THEN RAISE EXCEPTION 'sequence below source IDs'; END IF; END $$;"
                    run('psql', *common, '-d', 'quizeey_archive', input=check)
            stages.append({'stage': 'import_' + str(attempt), 'rows': count, 'allPayloadHashesMatch': True,
                           'examVersionHashesMatch': True, 'correctChoiceSetsMatch': True,
                           'typedArchiveUtcValuesMatch': True, 'identitySequencesAboveSourceIds': True})
            print('Private rehearsal: import %d, %d rows verified' % (attempt, count), flush=True)
        for role in ['anon', 'authenticated', 'service_role']:
            for table in ['quizeey_import.raw_rows', 'quizeey_legacy.question']:
                run('psql', *common, '-v', 'VERBOSITY=sqlstate', '-d', 'quizeey_archive', input='SET ROLE ' + role + '; SELECT * FROM '+table+' LIMIT 1;', expect_failure=True)
        run('pg_dump', '-h', '127.0.0.1', '-p', str(PORT), '-U', ROLE, '-Fc', '-f', destination / 'archive.dump', 'quizeey_archive')
        run('psql', *common, '-d', 'postgres', input='CREATE DATABASE quizeey_archive_restore;')
        run('pg_restore', '-h', '127.0.0.1', '-p', str(PORT), '-U', ROLE, '-d', 'quizeey_archive_restore',
            '--exit-on-error', destination / 'archive.dump')
        output = run('psql', *common, '-d', 'quizeey_archive_restore', '-At', input=query)
        if verified_rows(output, report) != expected_count: raise RuntimeError('Restored count changed')
        output = run('psql', *common, '-d', 'quizeey_archive_restore', '-At', input=typed_query)
        if verified_archive_rows(output, original, schema) != typed_summary: raise RuntimeError('Restored typed archive changed')
        stages.append({'stage': 'backup_restore', 'rows': expected_count, 'allPayloadHashesMatch': True,
                       'examVersionHashesMatch': True, 'correctChoiceSetsMatch': True, 'typedArchiveUtcValuesMatch': True})
        for role in ['anon', 'authenticated', 'service_role']:
            for table in ['quizeey_import.raw_rows', 'quizeey_legacy.question']:
                run('psql', *common, '-v', 'VERBOSITY=sqlstate', '-d', 'quizeey_archive_restore', input='SET ROLE ' + role + '; SELECT * FROM '+table+' LIMIT 1;', expect_failure=True)
        summary = {'status': 'private_raw_and_typed_rehearsal_pass', 'sourceSnapshotSha256': evidence['snapshotSha256'],
                   'sourceTables': report['tables'], 'stages': stages, 'postgresVersion': run('psql', '--version').read_text().strip(),
                   'typedArchive': typed_summary,
                   'sourceIssues': dict(Counter(e['issue'] for e in report['errors'])),
                   'unresolvedQuestionIds': len(report['unresolvedCorrectChoiceQuestionIds']),
                   'anonymousAndAuthenticatedDenied': True, 'serviceRoleDenied': True, 'publicServingEnabled': False,
                   'publicationStatus': report['status'], 'sourceMutations': 0, 'externalUploads': 0,
                   'privatePath': destination.relative_to(ROOT).as_posix(),
                   'scope': 'Local raw JSONB and typed private archive preservation/restore; not public serving ETL, Supabase RLS proof, or whole-instance recovery'}
    finally:
        if (destination / 'data/postmaster.pid').exists():
            run('pg_ctl', '-D', destination / 'data', '-m', 'fast', '-w', 'stop')
    if summary is not None:
        summary['elapsedSeconds'] = round(time.monotonic() - started, 3)
        summary['localServerStopped'] = not (destination / 'data/postmaster.pid').exists()
        (destination / 'rehearsal-evidence.json').write_text(json.dumps(summary, indent=2) + '\n', encoding='utf-8')
        (ROOT / 'docs/modernization/source-rehearsal-evidence.json').write_text(json.dumps(summary, indent=2) + '\n', encoding='utf-8')
        print('Original snapshot raw/typed replay and restore verified; local server stopped. Publication remains blocked.')


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        # Never emit database stderr, exception text or source row contents.
        raise SystemExit('Private snapshot rehearsal failed (' + type(error).__name__ + '); inspect owner-private logs.')
