"""Deterministic private PostgreSQL archive plan from the VERIFIED source schema.

Source strings remain in raw_rows; timestamps become the same instant at UTC.
Never assigns natural-key choices to an arbitrary question or enables publication.
"""
from collections import defaultdict
from datetime import datetime, timezone
import re

from audit import TABLES, digest


def definitions(schema):
    if schema.get('schemaVerified') is not True: raise ValueError('Verified source schema required')
    grouped = defaultdict(list)
    for column in schema['columns']:
        if column['TABLE_NAME'] not in TABLES or not re.fullmatch(r'[a-z_]+',column['COLUMN_NAME']):
            raise ValueError('Unexpected source column')
        grouped[column['TABLE_NAME']].append(column)
    if set(grouped) != set(TABLES): raise ValueError('All six source tables required')
    return {table: sorted(columns, key=lambda c: int(c['ORDINAL_POSITION'])) for table,columns in grouped.items()}


def postgres_type(source_type):
    if re.fullmatch(r'bigint\(\d+\)', source_type): return 'bigint'
    if re.fullmatch(r'int\(\d+\)', source_type): return 'integer'
    if re.fullmatch(r'varchar\(\d+\)', source_type): return 'text'
    if source_type == 'timestamp': return 'timestamptz'
    raise ValueError('Unsupported verified source type')


def archive_sql(schema):
    lines = ['-- PRIVATE VERIFIED ARCHIVE; NOT PUBLIC SERVING ETL.', 'BEGIN;', "SET LOCAL TIME ZONE 'UTC';"]
    for table, columns in definitions(schema).items():
        names = [c['COLUMN_NAME'] for c in columns]
        definition = ','.join('"'+c['COLUMN_NAME']+'" '+postgres_type(c['COLUMN_TYPE']) for c in columns)
        quoted = ','.join('"'+name+'"' for name in names)
        updates = ','.join('"'+name+'"=excluded."'+name+'"' for name in names if name != TABLES[table])
        # DDL type bounds/nullability enforce validated limits. Source PK remains
        # primary identity; no choice->question join, deduplication or reassignment.
        lines.append('INSERT INTO quizeey_legacy.'+table+' ('+quoted+') SELECT '+','.join('r."'+name+'"' for name in names)+
                     ' FROM quizeey_import.raw_rows s CROSS JOIN LATERAL jsonb_to_record(s.payload) AS r('+definition+
                     ") WHERE s.source_table='"+table+"' ON CONFLICT ("+TABLES[table]+') DO UPDATE SET '+updates+';')
        identity = next((c for c in columns if c.get('EXTRA') == 'auto_increment'), None)
        if identity:
            match = re.search(r'\bAUTO_INCREMENT=(\d+)\b', schema['ddl'][table])
            if not match: raise ValueError('Verified source sequence watermark required')
            next_source = int(match[1])
            if not 1 <= next_source <= 9223372036854775807: raise ValueError('Invalid source sequence')
            key = identity['COLUMN_NAME']
            lines.append("SELECT setval(pg_get_serial_sequence('quizeey_legacy."+table+"','"+key+"'),greatest("+
                         str(next_source)+',coalesce((SELECT max('+key+')+1 FROM quizeey_legacy.'+table+'),1)),false);')
    lines.append('COMMIT;')
    return '\n'.join(lines)+'\n'


def semantic_rows(table, rows, schema):
    columns = definitions(schema)[table]
    converted = []
    for source in rows:
        row = dict(source)
        if set(row) != {c['COLUMN_NAME'] for c in columns}: raise ValueError('Archive columns changed')
        for column in columns:
            name = column['COLUMN_NAME']; value = row[name]
            if value is None: continue
            if column['COLUMN_TYPE'].startswith('bigint('): row[name] = str(value)
            elif column['COLUMN_TYPE'] == 'timestamp':
                stamp = datetime.fromisoformat(value)
                if stamp.tzinfo is None: stamp = stamp.replace(tzinfo=timezone.utc)
                row[name] = stamp.astimezone(timezone.utc).isoformat(timespec='microseconds')
        converted.append(row)
    return sorted(converted, key=lambda row: str(row[TABLES[table]]))


def semantic_hash(table, rows, schema):
    return digest(semantic_rows(table, rows, schema))
