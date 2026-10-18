-- Private lossless staging only. Final legacy schema waits for LIVE DDL/reconciliation.
begin;
create schema if not exists quizeey_import;
revoke all on schema quizeey_import from public, anon, authenticated;
create table quizeey_import.raw_rows (
  source_table text not null check (source_table in ('test','version','question','example','explanation','question_stats')),
  source_id text not null,
  source_sha256 text not null check (source_sha256 ~ '^[a-f0-9]{64}$'),
  payload jsonb not null check (jsonb_typeof(payload) = 'object'),
  primary key (source_table, source_id)
);
alter table quizeey_import.raw_rows enable row level security;
alter table quizeey_import.raw_rows force row level security;
revoke all on quizeey_import.raw_rows from public, anon, authenticated;
-- No public policy or service-role auto-grant. Only the explicitly approved import operator.
comment on table quizeey_import.raw_rows is 'Private raw snapshot, not public serving schema. Preserve source hashes and IDs; no guessed relational constraints.';
commit;
