import {expect,it} from 'vitest';
import {analyticsLocation,analyticsReferrer} from './google-analytics';
it('retains safe campaign attribution while excluding arbitrary query/fragment data',()=>{
  expect(analyticsLocation('/sqlp-developer?verNbr=1','?email=private@example.com&utm_source=newsletter&utm_medium=email&utm_campaign=fall-2026&name=private')).toBe('https://quizeey.com/sqlp-developer?verNbr=1&utm_source=newsletter&utm_medium=email&utm_campaign=fall-2026');
  expect(analyticsLocation('/en','?utm_campaign=private@example.com')).toBe('https://quizeey.com/en');
  expect(analyticsReferrer('https://example.com/path?email=private@example.com#private')).toBe('https://example.com/path');
  expect(analyticsReferrer('javascript:private')).toBe('');
});
