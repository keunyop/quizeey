"use client";
import type { Locale } from '@/lib/contracts';
import { versionDisplayName } from '@/lib/version-label';

export function PracticeSettings({ locale, versions, version, testId, count }: {
  locale: Locale; versions: { id: string; number: number; name: string }[]; version: number; testId?: string; count: number;
}) {
  return <form className="version-form" method="get">
    {testId && <input type="hidden" name="testId" value={testId} />}
    {count !== 20 && <input type="hidden" name="count" value={count} />}
    <label htmlFor="version">{locale === 'ko' ? '시험 회차' : 'Exam set'}</label>
    <select id="version" name="verNbr" defaultValue={version} onChange={event => event.currentTarget.form?.requestSubmit()}>
      <option value="0">{locale === 'ko' ? '전체' : 'All'}</option>
      {versions.map(item => <option key={item.id} value={item.number}>{versionDisplayName(item.name, item.number, locale)}</option>)}
    </select>
  </form>;
}
