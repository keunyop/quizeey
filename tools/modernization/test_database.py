"""Create/stop an isolated PostgreSQL cluster in the ignored workspace, never port 5432.

No existing database/service is contacted. Keep the cluster and logs for review.
"""
import os
import shutil
import socket
import subprocess
import sys
import uuid
import json
import tempfile
import argparse
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PORT = "55432"
HIDDEN = subprocess.CREATE_NO_WINDOW if os.name == "nt" else 0
if hasattr(sys.stdout,'reconfigure'): sys.stdout.reconfigure(encoding='utf-8',errors='replace')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--serve', action='store_true', help='Keep the EMPTY fixture server available for local browser tests until interrupted')
    parser.add_argument('--auth-fixture', action='store_true', help='Also serve the isolated Auth HTTP double (requires --serve)')
    args = parser.parse_args()
    if args.auth_fixture and not args.serve: parser.error('--auth-fixture requires --serve')
    binary = Path(shutil.which("psql") or "").parent
    suffix = ".exe" if os.name == "nt" else ""
    for name in ["initdb", "pg_ctl", "psql", "pg_dump", "pg_restore"]:
        if not (binary / (name + suffix)).exists(): raise SystemExit("PostgreSQL server tools required")
    with socket.socket() as sock:
        if sock.connect_ex(("127.0.0.1", int(PORT))) == 0: raise SystemExit("Fixture port is occupied; refusing to connect")
    directory = ROOT / ".modernization" / ("postgres-fixture-" + uuid.uuid4().hex[:10])
    directory.mkdir(parents=True)
    if not directory.resolve().is_relative_to((ROOT / ".modernization").resolve()): raise SystemExit("Invalid fixture path")
    def run(name, *args, input=None):
        # pg_ctl's detached Windows child can inherit pipes. Files avoid waiting for pipe EOF.
        with tempfile.TemporaryFile() as stdout, tempfile.TemporaryFile() as stderr:
            result = subprocess.run([str(binary / (name + suffix)), *map(str, args)], input=input, encoding="utf-8", errors="replace", stdout=stdout, stderr=stderr, creationflags=HIDDEN, env={**os.environ, "LC_ALL": "C", "PGCLIENTENCODING": "UTF8"})
            stdout.seek(0); stderr.seek(0)
            output = stdout.read().decode('utf-8',errors='replace')
            errors = stderr.read().decode('utf-8',errors='replace')
        if result.returncode:
            print(output); print(errors); raise RuntimeError("Isolated PostgreSQL check failed: " + name)
        return output
    common = ["-X", "-h", "127.0.0.1", "-p", PORT, "-U", "quizeey_fixture", "-v", "ON_ERROR_STOP=1"]
    run("initdb", "-D", directory / "data", "--username=quizeey_fixture", "--locale=C", "--encoding=UTF8", "--auth=trust")
    auth_process = None
    auth_log = None
    try:
        run("pg_ctl", "-D", directory / "data", "-l", directory / "server.log", "-o", "-h 127.0.0.1 -p " + PORT, "-w", "start")
        run("psql", *common, "-d", "postgres", input="CREATE ROLE anon; CREATE ROLE authenticated; CREATE ROLE service_role BYPASSRLS; CREATE DATABASE quizeey_fixture;")
        for migration in sorted((ROOT / "supabase/migrations").glob("*.sql")):
            run("psql", *common, "-d", "quizeey_fixture", "-f", migration)
        run("psql", *common, "-d", "quizeey_fixture", input="CREATE ROLE quizeey_server LOGIN; GRANT service_role,anon TO quizeey_server;")
        if not args.serve:
            reader_sql=(ROOT/'supabase/tests/study_reader.sql').read_text(encoding='utf-8')
            output=run('psql',*common,'-d','quizeey_fixture',input='BEGIN;\n'+reader_sql+'\nROLLBACK;')
            (directory/'study-reader-result.txt').write_text(output,encoding='utf-8')
        if args.serve:
            import time
            if args.auth_fixture:
                with socket.socket() as sock:
                    if sock.connect_ex(('127.0.0.1',55433))==0: raise RuntimeError('Auth fixture port is occupied; refusing to connect')
                auth_log=(directory/'auth-fixture.log').open('w',encoding='utf-8')
                auth_process=subprocess.Popen([shutil.which('node'),str(ROOT/'tools/modernization/auth_fixture.mjs')],stdout=auth_log,stderr=auth_log,creationflags=HIDDEN,env={**os.environ,'QUIZEEY_ENV':'local'})
                for _ in range(50):
                    if auth_process.poll() is not None: raise RuntimeError('Auth fixture could not start')
                    with socket.socket() as sock:
                        if sock.connect_ex(('127.0.0.1',55433))==0: break
                    time.sleep(.1)
                else: raise RuntimeError('Auth fixture startup timed out')
                print('Local Auth HTTP double ready: 127.0.0.1:55433 (not a real Supabase account)',flush=True)
            print('Fixture forum ready: 127.0.0.1:55432/quizeey_fixture (local test data only)',flush=True)
            print('Cluster: '+str(directory.relative_to(ROOT)),flush=True)
            try:
                while (directory / 'data/postmaster.pid').exists(): time.sleep(1)
            except KeyboardInterrupt:
                pass
            return
        sys.path.insert(0, str(ROOT / "tools/migration"))
        from audit import audit, staging_sql
        from test_migration import fixture
        report, tables = audit(fixture())
        if report["errors"]: raise RuntimeError("Invalid rehearsal fixture")
        plan = staging_sql(tables)
        run("psql", *common, "-d", "quizeey_fixture", input=plan)
        run("psql", *common, "-d", "quizeey_fixture", input=plan)
        if run("psql", *common, "-d", "quizeey_fixture", "-At", input="select count(*) from quizeey_import.raw_rows;").strip() != "7":
            raise RuntimeError("Raw staging replay duplicated rows")
        output = run("psql", *common, "-d", "quizeey_fixture", "-f", ROOT / "supabase/tests/forum_security.sql")
        (directory / "security-result.txt").write_text(output, encoding="utf-8")
        output = run('psql',*common,'-d','quizeey_fixture','-f',ROOT/'supabase/tests/admin_security.sql')
        (directory/'admin-security-result.txt').write_text(output,encoding='utf-8')
        output = run('psql', *common, '-d', 'quizeey_fixture', '-f', ROOT / 'supabase/tests/forum_paging.sql')
        (directory / 'forum-paging-result.txt').write_text(output, encoding='utf-8')
        output = run('psql', *common, '-d', 'quizeey_fixture', '-f', ROOT / 'supabase/tests/exam_popularity.sql')
        (directory / 'exam-popularity-result.txt').write_text(output, encoding='utf-8')
        output = run('psql', *common, '-d', 'quizeey_fixture', '-f', ROOT / 'supabase/tests/visitor_feedback.sql')
        (directory / 'visitor-feedback-result.txt').write_text(output, encoding='utf-8')
        def parallel_click(_):
            return run('psql', *common, '-d', 'quizeey_fixture', '-At', input="set role service_role; select public.quizeey_exam_click('900003');")
        with ThreadPoolExecutor(max_workers=8) as pool:
            list(pool.map(parallel_click, range(40)))
        clicks = run('psql', *common, '-d', 'quizeey_fixture', '-At', input="select public.quizeey_exam_popularity(array['900003'])->>'900003';").strip()
        if clicks != '40': raise RuntimeError('Concurrent exam clicks lost increments')
        print('Exam popularity: SQL permission/precision checks and 40 concurrent clicks passed.')
        def parallel_write(_):
            query = "select public.quizeey_forum_mutate(repeat('f',64),repeat('1',64),'"+str(uuid.uuid4())+"','create','{\"examId\":\"5\",\"locale\":\"en\",\"title\":\"Concurrent fixture\",\"body\":\"Text\"}');"
            result = run("psql", *common, "-d", "quizeey_fixture", "-At", input=query)
            return json.loads(result)["status"]
        with ThreadPoolExecutor(max_workers=8) as pool:
            statuses = list(pool.map(parallel_write, range(20)))
        if statuses.count(202) != 10 or statuses.count(429) != 10:
            raise RuntimeError("Atomic shared rate-limit concurrency mismatch")
        # Restore into another empty database in this SAME isolated cluster.
        run("pg_dump", "-h", "127.0.0.1", "-p", PORT, "-U", "quizeey_fixture", "-Fc", "-f", directory / "fixture.dump", "quizeey_fixture")
        run("psql", *common, "-d", "postgres", input="CREATE DATABASE quizeey_fixture_restore;")
        run("pg_restore", "-h", "127.0.0.1", "-p", PORT, "-U", "quizeey_fixture", "-d", "quizeey_fixture_restore", "--exit-on-error", directory / "fixture.dump")
        retained = ['public.quizeey_topics','public.quizeey_posts','quizeey_private.guest_capabilities','quizeey_private.post_owners','quizeey_private.post_revisions','quizeey_private.forum_reports','quizeey_private.rate_windows','quizeey_private.mutation_receipts','quizeey_private.moderation_audit','quizeey_private.admin_sessions','quizeey_import.raw_rows','quizeey_private.exam_clicks']
        retained += ['quizeey_private.visitor_submissions','quizeey_private.operator_credentials']
        snapshot = "select jsonb_build_object("+",".join("'"+table+"',(select jsonb_build_object('rows',count(*),'sha256',encode(sha256(convert_to(coalesce(jsonb_agg(to_jsonb(t) order by to_jsonb(t)::text)::text,'[]'),'UTF8')),'hex')) from "+table+" t)" for table in retained)+");"
        before = run("psql", *common, "-d", "quizeey_fixture", "-At", input=snapshot).strip()
        after = run("psql", *common, "-d", "quizeey_fixture_restore", "-At", input=snapshot).strip()
        if before != after: raise RuntimeError("Fixture restore reconciliation mismatch")
        (directory / 'restore-reconciliation.json').write_text(before+'\n',encoding='utf-8')
        print("Isolated PostgreSQL RLS/ownership/moderation/rate checks passed. Fixture backup/restore counts match.")
        print('Concurrent writes: 10 published, 10 rate-limited. Staging replay: 7 rows. Restored tables: '+str(len(retained)))
        print("Private fixture evidence: " + str(directory.relative_to(ROOT)))
    finally:
        if auth_process is not None:
            auth_process.terminate()
            try: auth_process.wait(timeout=5)
            except subprocess.TimeoutExpired: auth_process.kill(); auth_process.wait(timeout=5)
        if auth_log is not None: auth_log.close()
        if (directory / "data/postmaster.pid").exists(): run("pg_ctl", "-D", directory / "data", "-m", "fast", "-w", "stop")


if __name__ == "__main__": main()
