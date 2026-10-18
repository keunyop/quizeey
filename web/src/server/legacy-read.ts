import { NextResponse } from "next/server";
import { z } from "zod";
import { boundedJson } from "./guest-policy";
import { identifier, legacy } from "@/lib/contracts";
import { loadStudyStore,type StudyContext } from './study-loader';
import { learningHtml } from "@/lib/content";

type Endpoint = "question" | "versions" | "tests" | "questionStats" | "explanations";
const headers = { "Cache-Control": "no-store", "X-Robots-Tag": "noindex, nofollow" };
function result(body: unknown, status = 200) { return NextResponse.json(body, { status, headers }); }
function id(value: unknown, required = true) {
  if ((value === undefined || value === null) && !required) return undefined;
  if (typeof value === "number" && !Number.isSafeInteger(value)) throw new Error("Unsafe legacy numeric ID");
  if (typeof value !== "number" && typeof value !== "string") throw new Error("Invalid ID");
  return identifier(String(value));
}
function wire(value: string) {
  const number = Number(value);
  if (!Number.isSafeInteger(number)) throw new Error("Legacy numeric wire ID cannot be represented safely");
  return number;
}
function versionNumber(raw:unknown){
  return raw===undefined||raw===null||raw===''?0:z.number().int().min(0).max(2147483647).parse(
    typeof raw==='string'&&/^(0|[1-9]\d{0,9})$/.test(raw)?Number(raw):raw);
}
export async function legacyRead(request: Request, endpoint: Endpoint) {
  let input: Record<string, unknown>;
  try { input = z.record(z.string(), z.unknown()).parse(await boundedJson(request)); }
  catch { return result({ error: "Invalid legacy request" }, 400); }
  let context:StudyContext;
  try {
    context=endpoint==='tests'?{}:endpoint==='questionStats'||endpoint==='explanations'?{questionId:id(input.questId)!}:
      {examId:id(input.testId)!,...(endpoint==='question'?{questionId:id(input.questId,false),version:versionNumber(input.verNbr),random:input.questId===undefined||input.questId===null}:{})};
    if(endpoint==='tests')z.enum(['kr','en']).parse(input.languageCd);
  } catch{return result({error:'Invalid legacy request'},400);}
  let store:Awaited<ReturnType<typeof loadStudyStore>>;
  try{store=await loadStudyStore(context);}catch{return result({error:'Study content unavailable'},503);}
  try {
    if (endpoint === "tests") {
      const language = z.enum(["kr", "en"]).parse(input.languageCd);
      if(store.source!=='fixture')return result(store.exams.filter(exam=>language==='kr'?exam.nameKo!==null:exam.nameEn!==null).sort((a,b)=>a.priority-b.priority||a.id.localeCompare(b.id)).map(exam=>({testId:wire(exam.id),testNm:language==='en'?exam.nameEn:exam.nameKo,url:exam.slug})));
      const routes = legacy.routes.filter((r) => r.testId && r.locale === (language === "kr" ? "ko" : "en") && !r.path.startsWith("/kr/") && store.questions(r.testId, r.locale as 'ko'|'en').length>0);
      // The live legacy catalog returns a relative slug; consumers add their locale/path prefix.
      return result([...new Map(routes.map((r) => [r.testId, { testId: wire(r.testId!), testNm: r.headings[0] || r.title, url: r.path.replace(/^\/en\//,'/').replace(/^\//,'') }])).values()]);
    }
    if (endpoint === "questionStats" || endpoint === "explanations") {
      const questId = id(input.questId)!;
      if (!store.hasQuestion(questId)) return result({ error: "Unknown question" }, 404);
      // User-authored explanations are privately retained until the owner reopens
      // publication. Built-in question explanations remain in /question.
      if(endpoint==='explanations')return result([]);
      const stats=store.counter(questId);
      return result(stats?{questId:wire(questId),...stats}:{questId:null,correct:0,inCorrect:0});
    }
    const testId = id(input.testId)!;
    if (!(store.source==='fixture'?legacy.routes.some(r=>r.testId===testId):store.hasExam(testId))) return result({ error: "Unknown exam" }, 404);
    const locale = store.defaultLocale(testId);
    if (endpoint === "versions") {
      return result([...store.versions(testId,locale)].sort((a,b)=>b.name.localeCompare(a.name)).map(v=>({verId:wire(v.id),verNm:v.name,verNbr:v.number})));
    }
    const version = versionNumber(input.verNbr);
    const questId = id(input.questId, false);
    const q = questId ? store.questions(testId,locale,version,questId)[0] : store.random(testId,locale,version);
    if (!q) return result({ error: "Unknown question or version" }, 404);
    return result({ questId: wire(q.id), testId: wire(q.testId), verNbr: q.version, verName: q.versionName,
      questNbr:q.questionNumber??1,
      questTxt: learningHtml(q.text), explanation:q.explanation===null?null:learningHtml(q.explanation), reference:q.reference===undefined||q.reference===null?null:learningHtml(q.reference),
      multiAnswer: q.choices.filter((c) => c.correct).length > 1,
      examples: q.choices.map((c) => ({ exmpId: wire(c.id), testId: wire(q.testId), verNbr: q.version,
        questNbr:q.questionNumber??1,
        exmpNbr: c.position, exmpTxt: learningHtml(c.text), answer: c.correct })) });
  } catch { return result({ error: "Invalid legacy request" }, 400); }
}
