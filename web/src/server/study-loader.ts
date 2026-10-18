import 'server-only';
import { createClient } from '@supabase/supabase-js';
import { z } from 'zod';
import { environment } from '@/lib/environment';
import { identifier } from '@/lib/contracts';
import { coreStudyStore, studyStore } from './study-store';

export type StudyContext={examId?:string;questionId?:string;version?:number;random?:boolean;page?:number};
export async function loadStudyStore(context:StudyContext={},input:Record<string,string|undefined>=process.env) {
  const env=environment(input);
  if(env.contentSource!=='supabase')return studyStore();
  try {
    if(context.examId!==undefined)identifier(context.examId);
    if(context.questionId!==undefined)identifier(context.questionId);
    z.number().int().min(0).max(2147483647).parse(context.version??0);
    z.boolean().parse(context.random??false);
    z.number().int().min(1).max(10000).parse(context.page??1);
    const client=createClient(input.QUIZEEY_SUPABASE_URL!,input.QUIZEEY_SUPABASE_SECRET_KEY!,{
      auth:{persistSession:false,autoRefreshToken:false,detectSessionInUrl:false},db:{schema:'public',retry:false},
      global:{fetch:async(url,init)=>{
        const response=await fetch(url,{...init,cache:'no-store',redirect:'error',signal:AbortSignal.timeout(5000)});
        const bytes=await response.arrayBuffer();
        if(bytes.byteLength>1500000)throw new Error();
        return new Response(bytes,{status:response.status,statusText:response.statusText,headers:response.headers});
      }},
    });
    const paged=!!context.examId&&!context.questionId&&!context.random;
    const {data,error}=await (paged?client.rpc('quizeey_study_page',{
      p_exam_id:context.examId,p_version:context.version??0,p_page:context.page??1,
    }):client.rpc('quizeey_study_context',{
      p_exam_id:context.examId??null,p_question_id:context.questionId??null,p_version:context.version??0,p_random:context.random??false,
    }));
    if(error||!data||data.tables?.exams?.length!==181||data.tables?.versions?.length>330||
      data.tables?.questions?.length>20||data.tables?.choices?.length>2000||data.tables?.legacy_counters?.length>20)throw new Error();
    const store=coreStudyStore(data,'supabase:'+env.contentDatasetSha256,'supabase');
    if(paged&&(!data.pagination||data.pagination.page!==(context.page??1)||data.tables.questions.length!==Math.max(0,Math.min(20,data.pagination.total-((context.page??1)-1)*20))))throw new Error();
    if(context.examId&&data.tables.questions.some((q:{version_id:string})=>!data.tables.versions.some((v:{version_id:string;exam_id:string})=>v.version_id===q.version_id&&v.exam_id===context.examId)))throw new Error();
    if(context.questionId&&data.tables.questions.some((q:{question_id:string})=>q.question_id!==context.questionId))throw new Error();
    return store;
  }catch{throw new Error('Study content unavailable');}
}
