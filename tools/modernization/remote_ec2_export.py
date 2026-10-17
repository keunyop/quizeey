"""Stream one consistent READ ONLY snapshot of the six known source tables.

Prepended schema/runtime helpers are definitions only. Credentials stay in process memory.
"""
import sys
EXPORT_MODE=None


def emit(value):
    if hasattr(sys.stdout,'buffer'):sys.stdout.buffer.write(value)
    else:sys.stdout.write(value)


def main():
    if EXPORT_MODE not in ['original','anonymized-authors']:raise RuntimeError('Explicit owner-approved export mode required')
    instance=metadata()
    if instance.get('instance-id')!=EXPECTED:raise RuntimeError('Unexpected instance')
    config='/home/ec2-user/app/config/real-application.yml'
    datasource={}
    for document in yaml.safe_load_all(read(config,262144)):
        spring=document.get('spring',{}) if isinstance(document,dict) else {}
        if spring.get('profiles')=='prod' and isinstance(spring.get('datasource'),dict):datasource.update(spring['datasource'])
    if not all(scalar(datasource.get(key)) and datasource[key] and '${' not in datasource[key] for key in ['username','password']):raise RuntimeError('Unresolved source configuration')
    meta=mysql_query(datasource,"SELECT TABLE_NAME,ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE(); SELECT TABLE_NAME,COLUMN_NAME,DATA_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() ORDER BY TABLE_NAME,ORDINAL_POSITION;")
    if meta['status']!='ok':raise RuntimeError('Source metadata unavailable')
    engines={row['TABLE_NAME']:row['ENGINE'] for row in meta['sets'][0]}
    if any(engines.get(table)!='InnoDB' for table in TABLES):raise RuntimeError('A consistent InnoDB snapshot is required')
    columns={table:[] for table in TABLES}
    for row in meta['sets'][1]:
        if row['TABLE_NAME'] in columns:
            name=row['COLUMN_NAME']
            if not re.match(r'^[a-z][a-z0-9_]{0,63}$',name):raise RuntimeError('Unexpected source column')
            columns[row['TABLE_NAME']].append((name,row['DATA_TYPE']))
    primary={'test':'test_id','version':'ver_id','question':'quest_id','example':'exmp_id','explanation':'expl_id','question_stats':'quest_id'}
    queries=["SET NAMES utf8mb4; SET SESSION time_zone='+00:00'; SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ; SET SESSION TRANSACTION READ ONLY; START TRANSACTION WITH CONSISTENT SNAPSHOT;", "SELECT JSON_OBJECT('kind','snapshot_start','database',DATABASE(),'serverVersion',VERSION(),'snapshotUtc',UTC_TIMESTAMP(6),'sessionTimezone',@@session.time_zone,'readOnly',@@session.tx_read_only);"]
    for table in TABLES:
        values=[]
        for name,datatype in columns[table]:
            value='`'+name+'`'
            if name.endswith('_id') or datatype in ['timestamp','datetime','date','decimal','bigint']:value='CAST('+value+' AS CHAR)'
            values.extend(["'"+name+"'",value])
        queries.extend(["SELECT JSON_OBJECT('kind','table_start','table','"+table+"','expectedRows',COUNT(*)) FROM `"+table+"`;", "SELECT JSON_OBJECT('kind','row','table','"+table+"','payload',JSON_OBJECT("+','.join(values)+")) FROM `"+table+'` ORDER BY `'+primary[table]+'`;'])
    queries.extend(["SELECT JSON_OBJECT('kind','snapshot_end','status','complete','completedUtc',UTC_TIMESTAMP(6));",'ROLLBACK;'])
    binary='/usr/bin/mysql' if os.path.isfile('/usr/bin/mysql') else '/bin/mysql'
    command=[binary,'--no-defaults','--protocol=TCP','--host=127.0.0.1','--port=3306','--user='+datasource['username'],'--database=quizeey','--connect-timeout=5','--default-character-set=utf8mb4','--batch','--raw','--skip-column-names','--quick']
    environment=dict(os.environ);environment['MYSQL_PWD']=datasource['password']
    process=subprocess.Popen(command,stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=subprocess.PIPE,env=environment)
    try:
        process.stdin.write('\n'.join(queries).encode('utf-8'));process.stdin.close()
        emitted=0
        for line in iter(process.stdout.readline,b''):
            emitted+=len(line)
            if emitted>100000000:raise RuntimeError('Snapshot byte bound exceeded')
            item=json.loads(line)
            if item.get('kind')=='table_start' and item.get('expectedRows',0)>200000:raise RuntimeError('Table row bound exceeded')
            if EXPORT_MODE=='anonymized-authors' and item.get('kind')=='row' and item.get('table')=='explanation':
                item['payload']['user_nm']=None
                line=(json.dumps(item,ensure_ascii=False)+'\n').encode('utf-8')
            emit(line)
        errors=process.stderr.read(65536)
        if process.wait()!=0:raise RuntimeError('Read-only snapshot unavailable')
    finally:
        if process.poll() is None:process.terminate();process.wait()
        datasource.clear()


if __name__=='__main__':main()
