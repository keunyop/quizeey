// Synthetic browser harness. Not an application route or part of deployment packaging.
import {StrictMode} from 'react';
import {createRoot} from 'react-dom/client';
import {Monetization,AdSlot} from '../src/components/Monetization';
import {Practice} from '../src/components/Practice';
import {questions} from '../src/lib/fixtures';
import {ExamSearch} from '../src/components/ExamSearch';
import {legacy} from '../src/lib/contracts';

const catalog=window.location.pathname==='/';
const short=window.location.search==='?short';
const routes=legacy.routes.filter(route=>route.testId&&route.locale==='ko'&&!route.path.startsWith('/kr/'));
createRoot(document.getElementById('root')!).render(<StrictMode>
  <Monetization enabled measurementId="G-TESTONLY123" cmpScriptUrl="https://fundingchoicesmessages.google.com/i/pub-8362228066874729?ers=1" pagePath={window.location.pathname} locale="ko">
    <main className={`container ${catalog?'home-container':'study-container'}`}>
      {catalog?<ExamSearch routes={short?routes.slice(0,6):routes} locale="ko" popularity={{}}/>:<>
        <Practice questions={questions.filter(q=>q.testId==='5'&&q.version===1)} locale="ko" testId="5" contentVersion="synthetic-ad-test"/>
        <AdSlot kind="display" locale="ko"/>
      </>}
    </main>
  </Monetization>
</StrictMode>);
