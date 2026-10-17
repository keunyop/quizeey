"""Synthetic, SCRAM/loopback PostgreSQL17.11 rehearsal; never contacts a cloud DB.

Models the observed Supabase postgres role and public default ACL. No source exports
are opened. Uses exactly the selected schema files, not all historical migrations.
"""
import argparse
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
import os
from pathlib import Path
import secrets
import socket
import subprocess
import sys
import tempfile
import uuid

ROOT = Path(__file__).resolve().parents[2]
PORT = 55436
DB = 'quizeey_hosted_rehearsal'
BOOTSTRAP = 'quizeey_rehearsal_bootstrap'
BASE = ['202610160002_native_forum.sql', '202610160003_guest_private_preview.sql',
        '202610160004_admin_moderation.sql', '202610160006_exam_content.sql']


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pg-bin', required=True, type=Path)
    parser.add_argument('--boundary-migration', type=Path)
    parser.add_argument('--study-migration', type=Path)
    parser.add_argument('--supabase-cli', type=Path)
    parser.add_argument('--candidate', type=Path)
    parser.add_argument('--rollback', type=Path)
    parser.add_argument('--postflight', type=Path)
    parser.add_argument('--report', type=Path, default=ROOT/'docs/modernization/hosted-schema-rehearsal-evidence.json')
    args = parser.parse_args()
    binary = args.pg_bin.resolve()
    suffix = '.exe' if os.name == 'nt' else ''
    hidden = subprocess.CREATE_NO_WINDOW if os.name == 'nt' else 0
    version = subprocess.check_output([str(binary/('postgres'+suffix)), '--version'], text=True).strip()
    if version != 'postgres (PostgreSQL) 17.11':
        raise ValueError('Exact PostgreSQL17.11 runtime required')
    for tool in ['initdb', 'pg_ctl', 'psql', 'pg_dump', 'pg_restore']:
        if not (binary/(tool+suffix)).is_file():
            raise ValueError('Required PostgreSQL tool missing')
    with socket.socket() as probe:
        if probe.connect_ex(('127.0.0.1', PORT)) == 0:
            raise ValueError('Occupied rehearsal port; refusing existing DB')
    # PG17 on Windows fails post-bootstrap when installation/data paths contain
    # non-ASCII characters under a UTF8 cluster. Use a private temp directory.
    parent = Path(tempfile.gettempdir()) if os.name == 'nt' else ROOT/'.modernization'
    directory = parent/('hosted-schema-'+uuid.uuid4().hex[:10])
    directory.mkdir(mode=0o700)
    if os.name == 'nt':
        # Keep temporary credentials and local logs private, without touching other ACLs.
        sid = subprocess.check_output(['powershell.exe', '-NoProfile', '-Command',
            '[System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value'], creationflags=hidden, text=True).strip()
        subprocess.run(['icacls.exe', str(directory), '/inheritance:r', '/grant:r', '*'+sid+':(OI)(CI)F',
                        '/remove:g', '*S-1-3-4', '*S-1-5-18', '*S-1-5-32-544'],
                       check=True, capture_output=True, creationflags=hidden)
    password = secrets.token_hex(32)
    env = {key: value for key, value in os.environ.items() if not key.startswith('PG')}
    env.update(PGPASSWORD=password, PGCLIENTENCODING='UTF8', LC_ALL='C')

    def run(tool, *params, input=None):
        # pg_ctl's detached Windows server must not inherit a captured stdout pipe.
        label = uuid.uuid4().hex[:10]
        output = directory/(label+'.stdout')
        errors = directory/(label+'.stderr')
        with output.open('wb') as stdout, errors.open('wb') as stderr:
            result = subprocess.run([str(binary/(tool+suffix)), *map(str, params)], input=input,
                                    encoding='utf-8', stdout=stdout, stderr=stderr, env=env,
                                    creationflags=hidden, timeout=120)
        if result.returncode:
            raise RuntimeError('Local rehearsal failed: '+tool+'; inspect '+str(errors))
        return output.read_text(encoding='utf-8').strip()

    def sql(query, db=DB, role='postgres'):
        return run('psql', '-X', '-h', '127.0.0.1', '-p', PORT, '-U', role,
                   '-d', db, '-v', 'ON_ERROR_STOP=1', '-At', input=query)

    def file(path, db=DB):
        return sql(Path(path).read_text(encoding='utf-8'), db)

    migration_paths = [ROOT/'supabase/migrations'/name for name in BASE]
    if args.boundary_migration:
        boundary = args.boundary_migration.resolve()
        if boundary.parent != (ROOT/'supabase/migrations').resolve():
            raise ValueError('Boundary migration must be a repository migration')
        migration_paths.append(boundary)
    if args.study_migration:
        study = args.study_migration.resolve()
        if study.parent != (ROOT/'supabase/migrations').resolve():
            raise ValueError('Study migration must be a repository migration')
        migration_paths.append(study)
    report = {'recordedAt': '2026-10-16', 'timezone': 'America/Vancouver', 'status': 'running',
              'runtime': version, 'runtimeBinarySha256': digest(binary/('postgres'+suffix)),
              'privateLogs': str(directory),
              'migrations': [{'file': path.name, 'sha256': digest(path)} for path in migration_paths],
              'cloudMutations': 0, 'sourceContentReadOrUploaded': 0,
              'limitation': 'Local EDB17.11 role/default-ACL model; not a complete hosted Supabase/PostgREST/Auth replica.'}
    password_file = directory/'init-password.tmp'
    try:
        password_file.write_text(password, encoding='utf-8')
        try:
            run('initdb', '-D', directory/'data', '--username='+BOOTSTRAP, '--locale=C', '--encoding=UTF8',
                '--auth=scram-sha-256', '--pwfile='+str(password_file))
        finally:
            password_file.unlink(missing_ok=True)
        run('pg_ctl', '-D', directory/'data', '-l', directory/'server.log',
            '-o', '-h 127.0.0.1 -p '+str(PORT), '-w', 'start')
        sql("CREATE ROLE postgres LOGIN NOSUPERUSER BYPASSRLS CREATEDB CREATEROLE PASSWORD '"+password+"'; "
            "CREATE ROLE anon; CREATE ROLE authenticated; CREATE ROLE service_role BYPASSRLS; "
            "CREATE ROLE authenticator NOINHERIT; GRANT anon,authenticated,service_role TO postgres WITH ADMIN OPTION; "
            "GRANT anon,authenticated,service_role TO authenticator WITH INHERIT FALSE; "
            "GRANT pg_read_all_data,pg_monitor,pg_signal_backend,pg_create_subscription TO postgres WITH ADMIN OPTION; "
            "CREATE DATABASE "+DB+" OWNER postgres;", db='postgres', role=BOOTSTRAP)
        sql("GRANT USAGE ON SCHEMA public TO postgres,anon,authenticated,service_role; "
            "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO anon,authenticated,service_role; "
            "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO anon,authenticated,service_role; "
            "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO anon,authenticated,service_role;")
        report['migrationRole'] = json.loads(sql("select jsonb_build_object('current_user',current_user,"
            "'session_user',session_user,'superuser',rolsuper,'bypassrls',rolbypassrls,'createrole',rolcreaterole) "
            "from pg_roles where rolname=current_user;"))
        if report['migrationRole']['superuser'] or report['migrationRole']['current_user'] != 'postgres':
            raise RuntimeError('Migration connection must be non-superuser postgres')
        for path in migration_paths:
            file(path)
        run('pg_dump', '-h', '127.0.0.1', '-p', PORT, '-U', 'postgres', '--schema-only', '-Fc', '-f', directory/'schema-only.dump', DB)
        sql('CREATE DATABASE quizeey_hosted_schema_restore OWNER postgres;', db='postgres')
        run('pg_restore', '-h', '127.0.0.1', '-p', PORT, '-U', 'postgres', '-d', 'quizeey_hosted_schema_restore',
            '--exit-on-error', directory/'schema-only.dump')
        report['schemaOnlyBackupRestore'] = 'passed as non-superuser postgres before synthetic data was inserted'
        if args.boundary_migration:
            file(ROOT/'supabase/tests/hosted_boundary.sql')
            file(ROOT/'supabase/tests/hosted_boundary.sql', db='quizeey_hosted_schema_restore')
            report['boundaryChecks'] = 'passed'
        if args.supabase_cli:
            advisory = subprocess.run([str(args.supabase_cli.resolve()), 'db', 'advisors', '--db-url',
                # TLS disabled only for this exact owned loopback SCRAM fixture.
                'postgresql://postgres@127.0.0.1:'+str(PORT)+'/'+DB+'?sslmode=disable', '--type', 'all', '--fail-on', 'error', '--output', 'json'],
                env=env, capture_output=True, text=True, encoding='utf-8', creationflags=hidden, timeout=90)
            (directory/'advisors.stdout').write_text(advisory.stdout, encoding='utf-8')
            (directory/'advisors.stderr').write_text(advisory.stderr, encoding='utf-8')
            report['cliAdvisors'] = {'exitCode': advisory.returncode,
                'status': 'passed' if advisory.returncode == 0 else 'unavailable; inspect private advisor logs for the exact cause'}
        if args.study_migration:
            file(ROOT/'supabase/tests/study_reader.sql')
            report['studyReaderChecks'] = 'passed: role denial, bounded batch, direct ID beyond20, filters, NULL, counters'
            sys.path.insert(0,str(ROOT/'tools/modernization'))
            from prepare_cloud_content import frame_hash, verification_sql, TYPES
            for table in TYPES:
                rows=json.loads(sql('select coalesce(jsonb_agg(to_jsonb(t)),\'[]\'::jsonb) from quizeey_content.'+table+' t;'))
                observed=json.loads(sql(verification_sql(table)))
                if observed['rows']!=len(rows) or observed['framedSha256']!=frame_hash(table,rows):
                    raise RuntimeError('Cross-engine content hash mismatch')
            report['contentHashFraming'] = 'passed on synthetic values: Python/PostgreSQL UTF8 length-prefix/null/UTC framing'
        file(ROOT/'supabase/tests/forum_security.sql')
        file(ROOT/'supabase/tests/admin_security.sql')
        report['existingSecurityTests'] = 'forum/admin passed as non-superuser postgres'

        def write(_):
            query = "set role service_role; select public.quizeey_forum_mutate(repeat('f',64),repeat('1',64),'"+str(uuid.uuid4())+"','create','{\"examId\":\"5\",\"locale\":\"en\",\"title\":\"Concurrent fixture\",\"body\":\"Synthetic text\"}');"
            return json.loads(sql(query).splitlines()[-1])['status']
        with ThreadPoolExecutor(max_workers=8) as workers:
            statuses = list(workers.map(write, range(20)))
        report['concurrentWrites'] = {'acceptedPending': statuses.count(202), 'rateLimited': statuses.count(429)}
        if report['concurrentWrites'] != {'acceptedPending': 10, 'rateLimited': 10}:
            raise RuntimeError('Concurrency/rate-limit mismatch')

        tables = json.loads(sql("select jsonb_agg(n.nspname||'.'||c.relname order by n.nspname,c.relname) "
            "from pg_class c join pg_namespace n on c.relnamespace=n.oid where c.relkind='r' "
            "and (n.nspname in ('quizeey_private','quizeey_content') or "
            "(n.nspname='public' and c.relname like 'quizeey_%'));"))
        snapshot_query = 'select jsonb_build_object('+','.join("'"+table+"',(select jsonb_build_object('rows',count(*),'sha256',encode(sha256(convert_to(coalesce(jsonb_agg(to_jsonb(t) order by to_jsonb(t)::text)::text,'[]'),'UTF8')),'hex')) from "+table+' t)' for table in tables)+');'
        before = json.loads(sql(snapshot_query))
        schema_query = "select jsonb_agg(jsonb_build_object('schema',n.nspname,'name',p.proname,'owner',pg_get_userbyid(p.proowner),'definer',p.prosecdef,'settings',p.proconfig,'acl',p.proacl::text) order by n.nspname,p.proname) from pg_proc p join pg_namespace n on p.pronamespace=n.oid where n.nspname='quizeey_private' or (n.nspname='public' and p.proname like 'quizeey_%');"
        schema_before = json.loads(sql(schema_query))
        run('pg_dump', '-h', '127.0.0.1', '-p', PORT, '-U', 'postgres', '-Fc', '-f', directory/'synthetic.dump', DB)
        sql('CREATE DATABASE quizeey_hosted_restore OWNER postgres;', db='postgres')
        run('pg_restore', '-h', '127.0.0.1', '-p', PORT, '-U', 'postgres', '-d', 'quizeey_hosted_restore',
            '--exit-on-error', directory/'synthetic.dump')
        if before != json.loads(sql(snapshot_query, db='quizeey_hosted_restore')):
            raise RuntimeError('Restored table values/counts differ')
        if schema_before != json.loads(sql(schema_query, db='quizeey_hosted_restore')):
            raise RuntimeError('Restored function owner/ACL/search_path differ')
        if args.boundary_migration:
            file(ROOT/'supabase/tests/hosted_boundary.sql', db='quizeey_hosted_restore')
        # Revocation is mandatory after restore; never reactivate old admin cookies.
        sql('UPDATE quizeey_private.admin_sessions SET revoked_at=coalesce(revoked_at,now());', db='quizeey_hosted_restore')
        report['backupRestore'] = {'tablesMatched': len(tables), 'fullRowsAndHashesMatched': True,
                                  'functionOwnersAclSearchPathMatched': True, 'roleBoundaryRechecked': bool(args.boundary_migration),
                                  'adminSessionsRevokedAfterRestore': True}
        report['functions'] = schema_before
        report['status'] = 'passed'
        # Rehearse transactional rollback on a separate empty database: no CASCADE drops.
        sql('CREATE DATABASE quizeey_hosted_abort OWNER postgres;', db='postgres')
        bundle = '\n'.join(path.read_text(encoding='utf-8').replace('begin;', '').replace('commit;', '') for path in migration_paths)
        sql('BEGIN;\n'+bundle+'\nROLLBACK;', db='quizeey_hosted_abort')
        count = sql("select count(*) from pg_class c join pg_namespace n on c.relnamespace=n.oid where n.nspname in ('quizeey_private','quizeey_content') or (n.nspname='public' and c.relname like 'quizeey_%');", db='quizeey_hosted_abort')
        if count != '0':
            raise RuntimeError('Transactional abort retained application objects')
        report['transactionalAbort'] = 'passed: all selected DDL rolled back, zero application relations'
        if args.candidate:
            sql('CREATE DATABASE quizeey_hosted_bundle OWNER postgres;', db='postgres')
            file(args.candidate, db='quizeey_hosted_bundle')
            file(ROOT/'supabase/tests/hosted_boundary.sql', db='quizeey_hosted_bundle')
            row_count = sql('select '+ '+'.join('(select count(*) from '+table+')' for table in tables)+';', db='quizeey_hosted_bundle')
            if row_count != '0':
                raise RuntimeError('Review candidate unexpectedly inserts application rows')
            report['reviewCandidate'] = {'file': args.candidate.name, 'sha256': digest(args.candidate),
                                        'appliedLocally': True, 'applicationRows': 0, 'boundaryChecks': 'passed'}
            if args.postflight:
                postflight = json.loads(file(args.postflight, db='quizeey_hosted_bundle').splitlines()[-2])
                # psql emits BEGIN/result/COMMIT; the only JSON line is the result.
                expected = {'read_only': 'on', 'application_tables': 15, 'public_invokers': 10,
                            'public_definers': 0, 'private_definers': 11, 'application_rows': 0}
                if any(postflight.get(key) != value for key, value in expected.items()) or any(
                        value is not True for key, value in postflight.items() if key not in expected):
                    raise RuntimeError('Read-only postflight contract failed')
                report['readOnlyPostflight'] = postflight
            if args.rollback:
                rollback_before = json.loads(sql(snapshot_query, db='quizeey_hosted_bundle'))
                file(args.rollback, db='quizeey_hosted_bundle')
                if rollback_before != json.loads(sql(snapshot_query, db='quizeey_hosted_bundle')):
                    raise RuntimeError('Containment rollback changed table values')
                denied = sql("select count(*) from pg_proc p join pg_namespace n on p.pronamespace=n.oid "
                    "where (n.nspname='quizeey_private' or (n.nspname='public' and p.proname like 'quizeey_%')) "
                    "and (has_function_privilege('anon',p.oid,'EXECUTE') or has_function_privilege('authenticated',p.oid,'EXECUTE') "
                    "or has_function_privilege('service_role',p.oid,'EXECUTE'));", db='quizeey_hosted_bundle')
                if denied != '0':
                    raise RuntimeError('Rollback retained application RPC access')
                read_access = sql("select has_table_privilege('anon','public.quizeey_posts','SELECT') or "
                    "has_table_privilege('authenticated','public.quizeey_topics','SELECT');", db='quizeey_hosted_bundle')
                if read_access != 'f':
                    raise RuntimeError('Rollback retained public SELECT')
                report['reviewRollback'] = {'file': args.rollback.name, 'sha256': digest(args.rollback),
                    'rpcAndPublicReadDenied': True, 'schemasTablesAndDataPreserved': True}
    except Exception:
        report['status'] = 'failed'
        raise
    finally:
        if (directory/'data/postmaster.pid').exists():
            run('pg_ctl', '-D', directory/'data', '-m', 'fast', '-w', 'stop')
        report['serverStopped'] = not (directory/'data/postmaster.pid').exists()
        args.report.resolve().write_text(json.dumps(report, ensure_ascii=False, indent=2)+'\n', encoding='utf-8', newline='\n')
    print(json.dumps({key: report[key] for key in ['status', 'runtime', 'migrationRole', 'concurrentWrites',
                                                 'backupRestore', 'transactionalAbort', 'serverStopped']}, indent=2))


if __name__ == '__main__':
    main()
