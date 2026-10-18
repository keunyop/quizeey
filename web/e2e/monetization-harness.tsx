// Synthetic browser harness. Not an application route or part of deployment packaging.
import {StrictMode} from 'react';
import {createRoot} from 'react-dom/client';
import {Monetization,AdSlot} from '../src/components/Monetization';
import {Practice} from '../src/components/Practice';
import {questions} from '../src/lib/fixtures';
createRoot(document.getElementById('root')!).render(<StrictMode><Monetization enabled measurementId="G-TESTONLY123" cmpScriptUrl="https://fundingchoicesmessages.google.com/i/pub-8362228066874729?ers=1" pagePath="/sqlp-developer" locale="ko"><main className="container study-container"><Practice questions={questions.filter(q=>q.testId==='5'&&q.version===1)} locale="ko" testId="5" contentVersion="synthetic-ad-test"/><AdSlot kind="display" locale="ko"/></main></Monetization></StrictMode>);
