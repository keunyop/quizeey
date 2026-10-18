"""Package schema-only SQL for review. Does not connect, apply or upload anything."""
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
BASE = ['202610160002_native_forum.sql', '202610160003_guest_private_preview.sql',
        '202610160004_admin_moderation.sql', '202610160006_exam_content.sql',
        '20261016233418_private_rpc_boundary.sql']


def main():
    paths = [ROOT/'supabase/migrations'/name for name in BASE]
    migrations = [{'file': p.name, 'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in paths]
    guard = """-- REVIEW CANDIDATE ONLY. Requires explicit cloud schema approval.
-- Exact target: Supabase tfkhnrbshvyfmrzxqfmq; no source/derived content or Auth changes.
begin;
set local lock_timeout='5s';
set local statement_timeout='60s';
select pg_advisory_xact_lock(hashtextextended('quizeey_schema_preview_candidate_v1',0));
do $$ begin
  if current_user<>'postgres' or current_setting('server_version_num')<>'170011'
    or (select rolsuper from pg_roles where rolname=current_user) then
    raise exception 'Wrong migration role/version';
  end if;
  if to_regnamespace('quizeey_private') is not null or to_regnamespace('quizeey_content') is not null
    or exists(select 1 from pg_class c join pg_namespace n on c.relnamespace=n.oid where n.nspname='public' and c.relname like 'quizeey_%')
    or exists(select 1 from pg_proc p join pg_namespace n on p.pronamespace=n.oid where n.nspname='public' and p.proname like 'quizeey_%') then
    raise exception 'Target is not the verified empty application schema';
  end if;
end $$;
"""
    pieces = [guard]
    for path in paths:
        source = path.read_text(encoding='utf-8')
        # Only transaction delimiters on standalone lines; never touch function bodies.
        source = re.sub(r'(?mi)^[ \t]*(?:begin|commit);[ \t]*\r?$', '', source)
        pieces.append('-- Source: '+path.name+'\n'+source.strip()+'\n')
    pieces.append("""do $$ begin
  if exists(select 1 from pg_proc p join pg_namespace n on p.pronamespace=n.oid
    where n.nspname='public' and p.proname like 'quizeey_%' and p.prosecdef) then
    raise exception 'Exposed SECURITY DEFINER remains';
  end if;
  if (select count(*) from pg_class c join pg_namespace n on c.relnamespace=n.oid where c.relkind='r'
    and (n.nspname in ('quizeey_private','quizeey_content') or (n.nspname='public' and c.relname like 'quizeey_%')))<>15 then
    raise exception 'Unexpected application table inventory';
  end if;
end $$;
notify pgrst, 'reload schema';
commit;
""")
    output = ROOT/'docs/modernization/hosted-schema-candidate.sql'
    output.write_text('\n'.join(pieces), encoding='utf-8', newline='\n')
    manifest = {'recordedAt': '2026-10-16', 'status': 'prepared-not-approved-not-applied',
        'target': {'supabaseProjectId': 'tfkhnrbshvyfmrzxqfmq', 'organizationId': 'ffwqtsvqdnhmpnfqnjuq',
                   'region': 'us-west-2', 'postgresVersion': '17.11',
                   'vercelTeamId': 'team_VSzA796D92aso5IuzUIiOdnb', 'vercelProjectId': 'prj_0SVBqfgurtvZErmpMJl01BJkUKOd'},
        'applyMigrationName': 'quizeey_schema_preview_candidate_v1', 'sourceMigrations': migrations,
        'schemaBundle': {'file': output.name, 'sha256': hashlib.sha256(output.read_bytes()).hexdigest()},
        'expected': {'applicationTables': 15, 'applicationRows': 0, 'publicInvokerFunctions': 10,
                     'publicDefinerFunctions': 0, 'privateDefinerFunctions': 11},
        'excludedMigrations': ['202610160001_raw_staging.sql', '202610160005_legacy_archive.sql'],
        'authProposal': {'method': 'PATCH', 'path': '/v1/projects/tfkhnrbshvyfmrzxqfmq/config/auth',
                         'before': {'disable_signup': False}, 'after': {'disable_signup': True},
                         'rollback': {'disable_signup': False}, 'adminUsersCreated': 0},
        'cloudMutations': 0, 'sourceContentReadOrUploaded': 0, 'newResourcesCreated': 0}
    rollback = output.parent/'hosted-schema-close-access.sql'
    manifest['containmentRollback'] = {'file': rollback.name, 'sha256': hashlib.sha256(rollback.read_bytes()).hexdigest(),
                                       'preservesSchemasAndData': True}
    postflight = output.parent/'hosted-schema-postflight.sql'
    manifest['readOnlyPostflight'] = {'file': postflight.name, 'sha256': hashlib.sha256(postflight.read_bytes()).hexdigest()}
    (output.parent/'hosted-change-manifest.json').write_text(json.dumps(manifest, indent=2)+'\n', encoding='utf-8', newline='\n')
    print(json.dumps({'bundle': output.name, 'sha256': manifest['schemaBundle']['sha256'], 'applied': False}))


if __name__ == '__main__':
    main()
