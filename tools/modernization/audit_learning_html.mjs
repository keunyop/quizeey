// Read approved local source only; never fetch or print source text/author names.
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { createRequire } from 'node:module';
import { fileURLToPath } from 'node:url';
import { learningHtml, preserveTechnicalTokens } from '../../web/src/lib/content.ts';

const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'../..');
const require=createRequire(path.join(root,'web/package.json'));
const sanitizeHtml=require('sanitize-html');
const sha=(value)=>crypto.createHash('sha256').update(value).digest('hex');
const htmlEscape=(value)=>String(value).replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;');

function main(){
  const source=path.resolve(process.argv[2]??'');
  const relative=path.relative(path.join(root,'.modernization/exports'),source);
  if(!relative||relative.startsWith('..')||path.isAbsolute(relative))throw Error('Private snapshot path required');
  const evidence=JSON.parse(fs.readFileSync(path.join(source,'snapshot-evidence.json'),'utf8'));
  const input=fs.readFileSync(path.join(source,'normalized.json'));
  if(sha(input)!==evidence.normalizedSha256)throw Error('Snapshot changed');
  const data=JSON.parse(input.toString('utf8'));
  const reviews=[];const outputDigest=crypto.createHash('sha256');
  let checked=0,changed=0,visibleTextChanged=0,technicalRestorations=0,unexpectedTextChanges=0,idempotencyFailures=0,activeMarkupFailures=0;
  const fields={question:['quest_txt','explanation','reference'],example:['exmp_txt'],explanation:['explanation']};
  const primary={question:'quest_id',example:'exmp_id',explanation:'expl_id'};
  const text=(html)=>sanitizeHtml(html,{allowedTags:[],allowedAttributes:{}});
  for(const [table,columns] of Object.entries(fields))for(const row of data[table])for(const column of columns){
    const before=row[column];if(typeof before!=='string'||!before)continue;
    const after=learningHtml(before);checked++;outputDigest.update(JSON.stringify([table,row[primary[table]],column,after])+'\n');
    if(before!==after)changed++;
    if(learningHtml(after)!==after)idempotencyFailures++;
    let active=false;
    sanitizeHtml(after,{allowedTags:false,allowedAttributes:false,allowVulnerableTags:true,onOpenTag:(tag,attributes)=>{
      if(['script','style','iframe','object','embed','form','input','select','textarea','svg','math','meta','link'].includes(tag))active=true;
      for(const [key,value] of Object.entries(attributes))if(/^on/i.test(key)||/^(srcdoc|formaction)$/i.test(key)||(/^href$|^src$/i.test(key)&&/^\s*(javascript|vbscript|data):/i.test(value)))active=true;
    }});
    if(active)activeMarkupFailures++;
    if(text(before)!==text(after)){
      visibleTextChanged++;
      const expected=text(preserveTechnicalTokens(before))===text(after);
      if(expected)technicalRestorations++;else unexpectedTextChanges++;
      reviews.push({table,id:row[primary[table]],column,classification:expected?'technical_placeholder_restored':'unexpected_text_change',before,after});
    }
  }
  // Source bodies are escaped in the review document; opening it triggers no I/O.
  const header='<!doctype html><html lang="ko"><meta charset="utf-8"><meta http-equiv="Content-Security-Policy" content="default-src \'none\'; style-src \'unsafe-inline\'; base-uri \'none\'; form-action \'none\'"><meta name="robots" content="noindex,nofollow"><title>Quizeey 본문 정제 검토</title><style>body{font:16px system-ui;max-width:1100px;margin:2rem auto}pre{white-space:pre-wrap;overflow-wrap:anywhere}section{border-top:2px solid #777;padding:1rem}</style><h1>본문 정제 검토</h1><p>기술 표기 복원 등을 포함한 텍스트 차이 후보입니다. 원문·정제 결과 모두 실행하지 않는 문자로 표시합니다. 자동 출판 승인 아님.</p>';
  fs.writeFileSync(path.join(source,'learning-html-review.json'),JSON.stringify(reviews,null,2));
  fs.writeFileSync(path.join(source,'learning-html-review.html'),header+reviews.map(r=>'<section><h2>'+htmlEscape([r.table,r.id,r.column].join(' / '))+'</h2><h3>원문</h3><pre>'+htmlEscape(r.before)+'</pre><h3>정제 결과</h3><pre>'+htmlEscape(r.after)+'</pre></section>').join('')+'</html>');
  const result={status:idempotencyFailures||activeMarkupFailures||unexpectedTextChanges?'blocked':'automated_checks_pass',
    sourceSnapshotSha256:evidence.snapshotSha256,sanitizerSourceSha256:sha(fs.readFileSync(path.join(root,'web/src/lib/content.ts'))),
    textFieldsChecked:checked,normalizedHtmlFields:changed,visibleTextDifferenceCandidates:visibleTextChanged,
    expectedTechnicalRestorationFields:technicalRestorations,unexpectedVisibleTextDifferenceFields:unexpectedTextChanges,
    idempotencyFailures,activeMarkupFailures,sanitizedOutputSha256:outputDigest.digest('hex'),externalRequests:0,
    sourceBodiesPrinted:false,publicationAllowed:false,
    scope:'Full offline sanitizer/security/idempotency and parsed-text comparison; not full browser layout, content rights, or production approval'};
  fs.writeFileSync(path.join(source,'learning-html-evidence.json'),JSON.stringify(result,null,2)+'\n');
  fs.writeFileSync(path.join(root,'docs/modernization/learning-html-evidence.json'),JSON.stringify(result,null,2)+'\n');
  process.stdout.write(JSON.stringify(result,null,2)+'\n');
  if(idempotencyFailures||activeMarkupFailures||unexpectedTextChanges)process.exitCode=1;
}
try{main();}catch(error){process.stderr.write('Private learning HTML audit failed ('+error.constructor.name+'); source content not printed.\n');process.exitCode=1;}
