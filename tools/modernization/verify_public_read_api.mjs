// Real read-only legacy API checks on the new origin before public DNS changes.
import https from 'node:https';
import fs from 'node:fs';
import {fileURLToPath} from 'node:url';
const live=process.argv.includes('--live');
const address=live?null:'216.150.1.1';
const checks=[];
async function read(endpoint,payload){
 const body=JSON.stringify(payload);
 return new Promise((resolve,reject)=>{
  const req=https.request({hostname:'quizeey.com',servername:'quizeey.com',path:'/'+endpoint,method:'POST',
   ...(address?{lookup:(_host,options,callback)=>options.all?callback(null,[{address,family:4}]):callback(null,address,4)}:{}),
   headers:{'Content-Type':'application/json','Content-Length':Buffer.byteLength(body),'User-Agent':'QuizeeyReadOnlyCutoverCheck/1.0'}},res=>{
   const chunks=[];let size=0;
   res.on('data',chunk=>{size+=chunk.length;if(size>1500000)req.destroy(new Error('Response limit'));else chunks.push(chunk);});
   res.on('end',()=>{try{resolve({status:res.statusCode,data:JSON.parse(Buffer.concat(chunks).toString('utf8'))});}catch{reject(new Error('Unexpected JSON response'));}});
  });req.on('error',reject);req.setTimeout(20000,()=>req.destroy(new Error('Read timeout')));req.end(body);
 });
}
function check(name,condition,status){checks.push({name,status,passed:!!condition});if(!condition)throw new Error('Read verification failed: '+name);}
try{
 const catalog=await read('tests',{languageCd:'kr'});
 check('Korean catalog',catalog.status===200&&Array.isArray(catalog.data)&&catalog.data.length>100,catalog.status);
 const exam=catalog.data.find(exam=>exam.url==='industrial-engineer-electric-work');
 check('Existing exam identity',!!exam,catalog.status);
 const versions=await read('versions',{testId:exam.testId});
 check('Exam versions',versions.status===200&&Array.isArray(versions.data)&&versions.data.length>0,versions.status);
 const question=await read('question',{testId:exam.testId,verNbr:versions.data[0].verNbr});
 check('Question and choices',question.status===200&&question.data.testId===exam.testId&&Array.isArray(question.data.examples)&&question.data.examples.length>1&&question.data.examples.some(c=>c.answer===true),question.status);
 const stats=await read('questionStats',{questId:question.data.questId});
 check('Legacy statistics',stats.status===200&&Number.isInteger(stats.data.correct)&&Number.isInteger(stats.data.inCorrect),stats.status);
 const posts=await read('explanations',{questId:question.data.questId});
 check('User posts remain deferred',posts.status===200&&Array.isArray(posts.data)&&posts.data.length===0,posts.status);
 const invalid=await read('question',{testId:'invalid'});
 check('Invalid ID rejected',invalid.status===400,invalid.status);
 const unknown=await read('explanations',{questId:2147483647});
 check('Unknown question rejected',unknown.status===404,unknown.status);
}catch(error){checks.push({name:'Completion',passed:false,error:error.code??error.message});}
const report={checkedAt:new Date().toISOString(),status:checks.every(c=>c.passed)?'passed':'needs-attention',
 scope:live?'Actual public DNS production Supabase-backed read endpoints; no DNS override, content emitted, write endpoints or Google requests.':'Real production Supabase-backed legacy read endpoints over verified canonical HTTPS directed to new Vercel origin. No content, author names, answers or identifiers emitted; no write endpoints, Google requests or DNS changes.',checks};
fs.writeFileSync(fileURLToPath(new URL('../../docs/modernization/'+(live?'live-public-read-api-evidence.json':'public-read-api-evidence.json'),import.meta.url)),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report));
if(report.status!=='passed')process.exitCode=1;
