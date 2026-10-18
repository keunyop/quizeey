import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { environment } from '../src/lib/environment.ts';

/** Validate the actual production credential without returning or logging content. */
export async function verifyProductionRead(input: Record<string, string | undefined> = process.env, fetcher: typeof fetch = fetch) {
  const env = environment(input);
  if (env.stage !== 'production') return { skipped: true };
  try {
    const response = await fetcher(input.QUIZEEY_SUPABASE_URL! + '/rest/v1/rpc/quizeey_study_page', {
      method: 'POST', headers: { apikey: input.QUIZEEY_SUPABASE_SECRET_KEY!, 'Content-Type': 'application/json' },
      body: JSON.stringify({ p_exam_id: '140', p_version: 0, p_page: 1 }),
      cache: 'no-store', redirect: 'error', signal: AbortSignal.timeout(5000),
    });
    if (!response.ok) throw new Error();
    const bytes = await response.arrayBuffer();
    if (bytes.byteLength > 1500000) throw new Error();
    const data = JSON.parse(new TextDecoder().decode(bytes));
    const tables = data?.tables;
    if (data?.schema !== 1 || !Array.isArray(tables?.exams) || tables.exams.length !== 181 ||
        !Array.isArray(tables?.versions) || !Array.isArray(tables?.questions) || tables.questions.length !== 20 ||
        !Array.isArray(tables?.choices) || tables.choices.length < 20 || tables.choices.length > 2000 ||
        data.pagination?.page !== 1 || !Number.isSafeInteger(data.pagination?.total) || data.pagination.total < 20 ||
        !tables.questions.every((q: {version_id: string}) => tables.versions.some((v: {version_id: string; exam_id: string}) => v.version_id === q.version_id && v.exam_id === '140'))) throw new Error();
    return { productionReadVerified: true, examCount: 181, sampledQuestions: 20, review: env.productionReview };
  } catch { throw new Error('Production content preflight failed (credentials, provider details and content redacted).'); }
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  try { console.log(JSON.stringify(await verifyProductionRead())); }
  catch { console.error('Production configuration/content preflight failed (values redacted).'); process.exitCode = 1; }
}
