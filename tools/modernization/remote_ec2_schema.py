"""Read schema metadata through the running app's existing local DB credentials.

Uses helpers from remote_ec2_runtime.py, streamed together. No remote files or secret output.
"""
import xml.etree.ElementTree as ET
import yaml

TABLES=['test','version','question','example','explanation','question_stats']


def aggregate_queries():
    result=[]
    primary={'test':'test_id','version':'ver_id','question':'quest_id','example':'exmp_id','explanation':'expl_id','question_stats':'quest_id'}
    for table in TABLES:
        result.append((table+'_counts','SELECT COUNT(*) AS rows,MIN(`'+primary[table]+'`) AS min_id,MAX(`'+primary[table]+'`) AS max_id FROM `'+table+'`;'))
    result.extend([
        ('catalog','SELECT SUM(test_nm IS NOT NULL) AS korean_catalog_rows,SUM(test_nm_eng IS NOT NULL) AS english_catalog_rows,COUNT(DISTINCT url) AS distinct_urls FROM test;'),
        ('question_flags','SELECT multi_answer_yn AS flag,COUNT(*) AS rows FROM question GROUP BY multi_answer_yn;'),
        ('choice_flags','SELECT answer_yn AS flag,COUNT(*) AS rows FROM example GROUP BY answer_yn;'),
        ('counters','SELECT SUM(correct) AS correct_total,SUM(in_correct) AS incorrect_total,SUM(correct<0 OR in_correct<0) AS invalid_negative_rows FROM question_stats;'),
        ('content_shapes',"SELECT SUM(quest_txt LIKE '%<img%') AS with_images,SUM(quest_txt LIKE '%<table%') AS with_tables,SUM(quest_txt LIKE '%<code%' OR quest_txt LIKE '%<pre%') AS with_code,MAX(CHAR_LENGTH(explanation)) AS longest_explanation FROM question;"),
        ('author_bounds','SELECT MAX(CHAR_LENGTH(user_nm)) AS max_display_name_length,SUM(user_nm IS NULL OR TRIM(user_nm)=\'\') AS anonymous_rows FROM explanation;'),
    ])
    for table,keys in [('version','test_id,ver_nbr'),('question','test_id,ver_nbr,quest_nbr'),('example','test_id,ver_nbr,quest_nbr,exmp_nbr')]:
        result.append((table+'_composite_duplicates','SELECT COUNT(*) AS duplicate_groups,COALESCE(SUM(n-1),0) AS extra_rows FROM (SELECT COUNT(*) AS n FROM `'+table+'` GROUP BY '+keys+' HAVING COUNT(*)>1) d;'))
    result.append(('question_choice_relations',"SELECT SUM(question_count=0) AS orphan_choice_groups,SUM(question_count>1) AS ambiguous_question_groups,SUM(question_count=1 AND choice_count=0) AS questions_without_choices,SUM(question_count=1 AND (correct_count=0 OR (multi_flag='N' AND correct_count<>1) OR (multi_flag='Y' AND correct_count<2))) AS invalid_correct_sets FROM (SELECT test_id,ver_nbr,quest_nbr,SUM(kind='q') AS question_count,SUM(kind='e') AS choice_count,SUM(kind='e' AND flag='Y') AS correct_count,MAX(CASE WHEN kind='q' THEN flag ELSE NULL END) AS multi_flag FROM (SELECT test_id,ver_nbr,quest_nbr,'q' AS kind,multi_answer_yn AS flag FROM question UNION ALL SELECT test_id,ver_nbr,quest_nbr,'e' AS kind,answer_yn AS flag FROM example) u GROUP BY test_id,ver_nbr,quest_nbr) g;"))
    return result


def scalar(value):
    return isinstance(value,type(u'')) or isinstance(value,str)


def mysql_query(credentials,sql):
    binary='/usr/bin/mysql' if os.path.isfile('/usr/bin/mysql') else '/bin/mysql'
    command=[binary,'--no-defaults','--protocol=TCP','--host=127.0.0.1','--port=3306','--user='+credentials['username'],'--database=quizeey','--connect-timeout=5','--default-character-set=utf8mb4','--xml']
    environment=dict(os.environ);environment['MYSQL_PWD']=credentials['password']
    process=subprocess.Popen(command,stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=subprocess.PIPE,env=environment)
    output,errors=process.communicate(sql.encode('utf-8'))
    if process.returncode:
        match=re.search(r'ERROR\s+(\d+)',text(errors))
        return {'status':'unavailable','errorCode':int(match.group(1)) if match else None}
    if len(output)>2000000:return {'status':'bound_exceeded'}
    raw=re.sub(br'<\?xml[^>]+\?>',b'',output)
    root=ET.fromstring(b'<audit>'+raw+b'</audit>')
    sets=[]
    for result in root.findall('resultset'):
        rows=[]
        for row in result.findall('row'):
            rows.append({field.attrib['name']:field.text if field.attrib.get('{http://www.w3.org/2001/XMLSchema-instance}nil')!='true' else None for field in row.findall('field')})
        sets.append(rows)
    return {'status':'ok','sets':sets}


def main():
    report={'scope':'Actual local DB schema metadata only; no source rows or credential output','credentialsPrinted':False,'mutations':0}
    instance=metadata()
    if instance.get('instance-id')!=EXPECTED:report['status']='instance_mismatch';print(json.dumps(report));return
    report['instanceId']=EXPECTED
    candidates=[]
    for pid in [item for item in os.listdir('/proc') if item.isdigit()]:
        try:
            if text(read('/proc/'+pid+'/comm',256)).strip()!='java':continue
            args=[text(item) for item in read('/proc/'+pid+'/cmdline').split(b'\0') if item]
            if '-jar' not in args:continue
            jar=os.path.realpath(os.path.join(os.readlink('/proc/'+pid+'/cwd'),args[args.index('-jar')+1]))
            if os.path.basename(jar).startswith('questionbank-'):candidates.append((pid,args,jar))
        except (IOError,OSError):continue
    if len(candidates)!=1:report['status']='ambiguous_app';print(json.dumps(report));return
    pid,args,jar=candidates[0]
    profiles=[arg.split('=',1)[1] for arg in args if arg.startswith(('-Dspring.profiles.active=','--spring.profiles.active='))]
    if profiles!=['prod']:report['status']='unexpected_profile';print(json.dumps(report));return
    with zipfile.ZipFile(jar) as archive:
        raw=archive.read('BOOT-INF/classes/application.yml')
        app_class=archive.read('BOOT-INF/classes/com/questionbank/webservice/Application.class')
    production_config='/home/ec2-user/app/config/real-application.yml'
    if production_config.encode('ascii') not in app_class:report['status']='production_config_not_referenced';print(json.dumps(report));return
    documents=list(yaml.safe_load_all(raw))+list(yaml.safe_load_all(read(production_config,262144)))
    report['productionConfigPath']=production_config
    selected={};document_info=[]
    for document in documents:
        if not isinstance(document,dict):continue
        spring=document.get('spring',{})
        if not isinstance(spring,dict):continue
        profile=spring.get('profiles')
        datasource=spring.get('datasource',{})
        if not isinstance(datasource,dict):continue
        info={'profile':profile if isinstance(profile,str) else 'base','datasourceFields':sorted(datasource.keys()),'hasPlaceholder':any('${' in str(value) for value in datasource.values())}
        document_info.append(info)
        if profile is None or isinstance(profile,dict) or profile=='prod':selected.update(datasource)
    report['configurationDocuments']=document_info
    report['selectedDatasourceFields']=sorted(selected.keys())
    if not all(scalar(selected.get(field)) and selected[field] and '${' not in selected[field] for field in ['username','password']):
        report['status']='datasource_credentials_unresolved';print(json.dumps(report));return
    credentials={'username':selected['username'],'password':selected['password']}
    if globals().get('AUDIT_MODE')=='aggregates':
        queries=aggregate_queries()
        guard="SET SESSION max_execution_time=3000; SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ; SET SESSION TRANSACTION READ ONLY; START TRANSACTION WITH CONSISTENT SNAPSHOT; SELECT UTC_TIMESTAMP(6) AS observed_utc,@@session.tx_read_only AS session_read_only;"
        result=mysql_query(credentials,guard+'\n'+'\n'.join(query for label,query in queries)+'\nROLLBACK;')
        credentials.clear()
        if result['status']!='ok':report.update(status='aggregate_unavailable',connection=result);print(json.dumps(report));return
        report['scope']='Bounded counts/flag distributions/duplicate and correctness aggregates only; no original row content or author names'
        report['snapshotContext']=result['sets'][0]
        report['aggregates']={label:result['sets'][index+1] for index,(label,query) in enumerate(queries)}
        report['status']='verified_live_aggregates'
        print(json.dumps(report,sort_keys=True));return
    first=mysql_query(credentials,"SELECT VERSION() AS server_version,DATABASE() AS source_database,@@hostname AS server_hostname,@@character_set_database AS database_charset,@@collation_database AS database_collation,@@time_zone AS session_timezone,@@system_time_zone AS system_timezone; SELECT TABLE_NAME,ENGINE,TABLE_COLLATION,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE() ORDER BY TABLE_NAME;")
    if first['status']!='ok':report.update(status='local_db_unavailable',connection=first);print(json.dumps(report));return
    report['server']=first['sets'][0];report['tables']=first['sets'][1]
    existing={row['TABLE_NAME'] for row in report['tables']}
    names=','.join("'"+name+"'" for name in TABLES)
    queries=["SELECT TABLE_NAME,COLUMN_NAME,ORDINAL_POSITION,COLUMN_TYPE,IS_NULLABLE,COLUMN_DEFAULT,EXTRA,CHARACTER_SET_NAME,COLLATION_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME IN ("+names+") ORDER BY TABLE_NAME,ORDINAL_POSITION;","SELECT TABLE_NAME,INDEX_NAME,NON_UNIQUE,SEQ_IN_INDEX,COLUMN_NAME FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME IN ("+names+") ORDER BY TABLE_NAME,INDEX_NAME,SEQ_IN_INDEX;","SELECT TABLE_NAME,CONSTRAINT_NAME,COLUMN_NAME,REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME IN ("+names+") ORDER BY TABLE_NAME,CONSTRAINT_NAME,ORDINAL_POSITION;"]
    present=[name for name in TABLES if name in existing]
    queries.extend('SHOW CREATE TABLE `'+name+'`;' for name in present)
    result=mysql_query(credentials,'\n'.join(queries))
    credentials.clear()
    if result['status']!='ok':report.update(status='metadata_unavailable',metadataResult=result);print(json.dumps(report));return
    report['columns']=result['sets'][0];report['indexes']=result['sets'][1];report['constraints']=result['sets'][2]
    report['ddl']={name:result['sets'][index+3][0].get('Create Table') for index,name in enumerate(present)}
    report['missingExpectedTables']=[name for name in TABLES if name not in existing]
    report['status']='verified_live_schema'
    report['readOnlyEnforcement']='Fixed SELECT/SHOW query allowlist; no writes issued. No full data snapshot claimed.'
    print(json.dumps(report,sort_keys=True))


if __name__=='__main__':main()
