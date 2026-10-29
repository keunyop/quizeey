import fs from 'node:fs';
import path from 'node:path';
import { createHash } from 'node:crypto';
import { z } from 'zod';
import { identifier } from '@/lib/contracts';
import { environment } from '@/lib/environment';
import { questions as fixtures,fixtureVersion } from '@/lib/fixtures';
import type { Locale } from '@/lib/contracts';
import type { Question } from '@/lib/quiz';

const id=z.string().refine(value=>{try{return identifier(value)===value;}catch{return false;}});
const integer=z.number().int().min(-2147483648).max(2147483647);
const payloadSchema=z.object({schema:z.literal(1),tables:z.object({
  exams:z.array(z.object({exam_id:id,name_ko:z.string().max(500).nullable(),name_en:z.string().max(500).nullable(),legacy_slug:z.string().max(100),priority:integer})),
  versions:z.array(z.object({version_id:id,exam_id:id,number:integer,name:z.string().max(500)})),
  questions:z.array(z.object({question_id:id,version_id:id,number:integer,body:z.string().max(2000),explanation:z.string().max(4000).nullable(),reference:z.string().max(1000).nullable(),multiple_answers:z.boolean()})),
  choices:z.array(z.object({choice_id:id,question_id:id,number:integer,body:z.string().max(1000),correct:z.boolean()})),
  legacy_counters:z.array(z.object({question_id:id,correct:integer.min(0),incorrect:integer.min(0)})),
}),pendingExplanationCounts:z.record(id,z.number().int().min(0)),pagination:z.object({page:z.number().int().min(1).max(10000),total:z.number().int().min(0).max(2147483647)}).optional()});
export type CorePayload=z.infer<typeof payloadSchema>;
export type StudyVersion={id:string;number:number;name:string};
export type StudyExam={id:string;nameKo:string|null;nameEn:string|null;slug:string;priority:number};
type Entry=Omit<Question,'locale'> & {locale?:Locale};

export class StudyStore {
  readonly version:string;
  readonly source:'fixture'|'local-archive'|'supabase';
  readonly exams:StudyExam[];
  private entries=new Map<string,Entry>();
  private byExam=new Map<string,Entry[]>();
  private examVersions=new Map<string,StudyVersion[]>();
  private counters=new Map<string,{correct:number;inCorrect:number}>();
  private pending:Record<string,number>={};
  constructor(source:'fixture'|'local-archive'|'supabase',version:string,exams:StudyExam[],entries:Entry[],versions:Map<string,StudyVersion[]>,counters=new Map<string,{correct:number;inCorrect:number}>(),pending:Record<string,number>={},private hostedPage?:{page:number;total:number}){
    this.source=source;this.version=version;this.exams=exams;this.examVersions=versions;this.counters=counters;this.pending=pending;
    for(const entry of entries){
      if(this.entries.has(entry.id))throw Error('Duplicate study identity');
      this.entries.set(entry.id,entry);
      const group=this.byExam.get(entry.testId)??[];group.push(entry);this.byExam.set(entry.testId,group);
    }
    if(source!=='fixture')for(const group of this.byExam.values())group.sort((a,b)=>b.version-a.version||(a.questionNumber??0)-(b.questionNumber??0)||a.id.localeCompare(b.id));
  }
  hasExam(testId:string){return this.exams.some(exam=>exam.id===testId);}
  hasQuestion(questionId:string){return this.entries.has(questionId);}
  defaultLocale(testId:string):Locale{return this.byExam.get(testId)?.[0]?.locale??'ko';}
  versions(testId:string,locale:Locale){return this.source!=='fixture'||this.available(testId,locale).length?this.examVersions.get(testId)??[]:[];}
  private available(testId:string,locale:Locale,version=0){return (this.byExam.get(testId)??[]).filter(q=>(!q.locale||q.locale===locale)&&(!version||q.version===version));}
  sessionQuestions(testId:string,locale:Locale,version=0):Question[]{
    return this.available(testId,locale,version).map(q=>({...q,locale}));
  }
  pagination(testId:string,locale:Locale,version=0,page=1){
    const total=this.hostedPage?.total??this.available(testId,locale,version).length;
    return {page:this.hostedPage?.page??page,total,pages:Math.max(1,Math.ceil(total/20))};
  }
  questions(testId:string,locale:Locale,version=0,directId?:string,page=1):Question[]{
    if(directId){
      const q=this.entries.get(directId);
      return q&&q.testId===testId&&(!version||q.version===version)&&(!q.locale||q.locale===locale)?[{...q,locale}]:[];
    }
    const start=this.hostedPage?0:(page-1)*20;
    return this.available(testId,locale,version).slice(start,start+20).map(q=>({...q,locale}));
  }
  random(testId:string,locale:Locale,version=0):Question|undefined{
    const list=this.available(testId,locale,version);const q=list[Math.floor(Math.random()*list.length)];return q?{...q,locale}:undefined;
  }
  counter(questionId:string){return this.counters.get(questionId);}
  pendingExplanations(questionId:string){return this.source==='supabase'?this.hasQuestion(questionId):this.pending[questionId]??0;}
}

export function coreStudyStore(input:unknown,version:string,source:'local-archive'|'supabase'='local-archive'){
  const data=payloadSchema.parse(input);const t=data.tables;
  const exams=t.exams.map(r=>({id:r.exam_id,nameKo:r.name_ko,nameEn:r.name_en,slug:r.legacy_slug,priority:r.priority}));
  const examIds=new Set(exams.map(r=>r.id));if(examIds.size!==exams.length)throw Error('Duplicate exam');
  const versionsById=new Map(t.versions.map(r=>[r.version_id,r]));
  if(versionsById.size!==t.versions.length)throw Error('Duplicate version');
  const versions=new Map<string,StudyVersion[]>();const naturalVersions=new Set<string>();
  for(const r of t.versions){
    const key=JSON.stringify([r.exam_id,r.number]);
    if(!examIds.has(r.exam_id)||naturalVersions.has(key))throw Error('Invalid version relation');naturalVersions.add(key);
    const group=versions.get(r.exam_id)??[];group.push({id:r.version_id,number:r.number,name:r.name});versions.set(r.exam_id,group);
  }
  for(const group of versions.values())group.sort((a,b)=>b.name.localeCompare(a.name)||b.number-a.number);
  const questionIds=new Set(t.questions.map(r=>r.question_id));if(questionIds.size!==t.questions.length)throw Error('Duplicate question');
  const choices=new Map<string,Question['choices']>();const choiceIds=new Set<string>();const positions=new Set<string>();
  for(const r of t.choices){
    const key=JSON.stringify([r.question_id,r.number]);
    if(!questionIds.has(r.question_id)||choiceIds.has(r.choice_id)||positions.has(key))throw Error('Invalid choice relation');
    choiceIds.add(r.choice_id);positions.add(key);
    const group=choices.get(r.question_id)??[];group.push({id:r.choice_id,position:r.number,text:r.body,correct:r.correct});choices.set(r.question_id,group);
  }
  const naturalQuestions=new Set<string>();
  const entries:Entry[]=t.questions.map(r=>{
    const v=versionsById.get(r.version_id);const key=JSON.stringify([r.version_id,r.number]);
    if(!v||naturalQuestions.has(key))throw Error('Invalid question relation');naturalQuestions.add(key);
    const group=(choices.get(r.question_id)??[]).sort((a,b)=>a.position-b.position);const correct=group.filter(c=>c.correct).length;
    if(!correct||(!r.multiple_answers&&correct!==1)||(r.multiple_answers&&correct<2))throw Error('Invalid correct choice set');
    return {id:r.question_id,testId:v.exam_id,version:v.number,versionName:v.name,questionNumber:r.number,
      text:r.body,explanation:r.explanation,reference:r.reference,choices:group,preserveOrder:true};
  });
  const counters=new Map<string,{correct:number;inCorrect:number}>();
  for(const r of t.legacy_counters){if(!questionIds.has(r.question_id)||counters.has(r.question_id))throw Error('Invalid counter');counters.set(r.question_id,{correct:r.correct,inCorrect:r.incorrect});}
  for(const questionId of Object.keys(data.pendingExplanationCounts))if(!questionIds.has(questionId))throw Error('Invalid explanation context');
  return new StudyStore(source,version,exams,entries,versions,counters,data.pendingExplanationCounts,data.pagination);
}

const fixtureVersions=new Map<string,StudyVersion[]>();
for(const q of fixtures){const group=fixtureVersions.get(q.testId)??[];if(!group.some(v=>v.number===q.version))group.push({id:String(q.testId==='5'?700000000+q.version:700000003),number:q.version,name:q.versionName});fixtureVersions.set(q.testId,group);}
const fixtureExams=[...new Set(fixtures.map(q=>q.testId))].map(id=>({id,nameKo:null,nameEn:null,slug:'',priority:0}));
const fixtureEntries=fixtures.map(q=>({...q,questionNumber:fixtures.filter(other=>other.testId===q.testId&&other.version===q.version).findIndex(other=>other.id===q.id)+1}));
const fixtureStore=new StudyStore('fixture',fixtureVersion,fixtureExams,fixtureEntries,fixtureVersions);

function inside(root:string,file:string){const relative=path.relative(root,file);return relative!==''&&!relative.startsWith('..'+path.sep)&&relative!=='..'&&!path.isAbsolute(relative);}
export function loadLocalStudyStore(inputFile:string,allowedRoot=path.resolve(process.cwd(),'../.modernization/exports')){
  try{
    if(!path.isAbsolute(inputFile))throw Error();
    // These external, local-review inputs must never enter deployment traces.
    const root=fs.realpathSync(/* turbopackIgnore: true */ allowedRoot);const file=fs.realpathSync(/* turbopackIgnore: true */ inputFile);
    if(!inside(root,file)||path.basename(file)!=='local-content.json')throw Error();
    const manifestFile=fs.realpathSync(/* turbopackIgnore: true */ path.join(path.dirname(file),'local-content-manifest.json'));
    if(!inside(root,manifestFile)||fs.statSync(/* turbopackIgnore: true */ manifestFile).size>1000000||fs.statSync(/* turbopackIgnore: true */ file).size>100000000)throw Error();
    const manifest=JSON.parse(fs.readFileSync(/* turbopackIgnore: true */ manifestFile,'utf8'));
    if(manifest.status!=='owner_approved_filtered_local_review'||manifest.hostedUseAllowed!==false||manifest.deletedQuestionCount!==751||manifest.deletedQuestionIdSetSha256!=='425654b55ad190dce415c853c95908521c6de0ed9e2860101d0ae8ac2730c6fd')throw Error();
    const payload=fs.readFileSync(/* turbopackIgnore: true */ file);const hash=createHash('sha256').update(payload).digest('hex');
    if(hash!==manifest.contentSha256)throw Error();
    return coreStudyStore(JSON.parse(payload.toString('utf8')),'local-archive:'+hash);
  }catch{throw new Error('Private study content unavailable: path, manifest, hash or relations failed validation.');}
}
let archiveCache:{key:string;store:StudyStore}|undefined;
export function studyStore(){
  const env=environment(process.env);if(env.contentSource==='fixture')return fixtureStore;
  if(env.contentSource==='supabase')throw new Error('Hosted study content requires the async bounded loader.');
  const file=env.localContentFile!;
  try{
    const stat=fs.statSync(/* turbopackIgnore: true */ file);const manifest=fs.statSync(/* turbopackIgnore: true */ path.join(path.dirname(file),'local-content-manifest.json'));
    const key=JSON.stringify([file,stat.size,stat.mtimeMs,manifest.mtimeMs]);
    // Cache immutable public study content only, never identity/session/ownership.
    if(archiveCache?.key!==key)archiveCache={key,store:loadLocalStudyStore(file)};
    return archiveCache.store;
  }catch{throw new Error('Private study content is unavailable.');}
}
