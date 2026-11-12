import { ccnaPost, subnetPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function CcnaSubnetArticle() {
  return <>
    <p className={styles.lead}>IPv4 주소와 프리픽스로 같은 네트워크인지 판단할 수 있으면 게이트웨이 주소나 마스크를 잘못 입력한 경우도 찾기 쉽습니다. <strong>주소 블록 찾기 → 네트워크·브로드캐스트 표시 → 호스트와 게이트웨이 범위 대조</strong> 순서로 연습해 보세요. 예제는 직접 만든 학습 자료이며 Cisco의 실제 시험 문항이 아닙니다.</p>
    <section aria-labelledby="ccna-version"><h2 id="ccna-version">먼저 응시할 시험 버전을 확인하세요</h2>
      <p>Cisco의 <a href="https://learningcontent.cisco.com/documents/marketing/exam-topics/200-301-CCNA-v1.1.pdf">200-301 CCNA v1.1 공식 범위</a>에는 <strong>1.6 IPv4 주소 지정과 서브네팅 설정·검증</strong>이 포함됩니다. <a href="https://blogs.cisco.com/learning/stay-on-track-get-certified-before-the-ccna-refresh">Cisco의 시험 일정 안내</a>에 따르면 v1.1의 마지막 응시일은 <strong>2027년 2월 2일</strong>, v2.0의 첫 응시일은 <strong>2027년 2월 3일</strong>입니다. <a href="https://learningcontent.cisco.com/documents/marketing/exam-topics/200-301_CCNA_v2.0_Exam_Topics_PDF.pdf">v2.0 공식 범위</a>는 <strong>1.3 IPv4 주소 설정·할당·서브네팅 문제 해결(공인·사설 주소)</strong>을 포함합니다.</p>
      <p>아래 계산은 두 버전의 IPv4 학습에 쓸 수 있습니다. 실제 응시 버전의 전체 범위는 공식 자료에서 다시 확인하세요. 한국어는 이 글의 설명 언어이며, <a href="https://www.cisco.com/site/us/en/learn/training-certifications/exams/ccna.html" target="_blank" rel="noopener noreferrer">Cisco가 안내하는 시험 언어</a>는 영어와 일본어입니다.</p>
    </section>
    <section aria-labelledby="ccna-26"><h2 id="ccna-26">예제 1: 203.0.113.142/26의 주소 블록</h2>
      <p><code>/26</code>은 32비트 IPv4 주소에서 네트워크에 26비트, 호스트에 6비트를 씁니다. 마스크는 <code>255.255.255.192</code>입니다. 마지막 옥텟의 블록 크기는 <code>256 − 192 = 64</code>이므로 시작점은 <code>0, 64, 128, 192</code>입니다. <code>142</code>는 <code>128~191</code> 블록에 있습니다.</p>
      <div className={styles.tableWrap} tabIndex={0} role="region" aria-label="26비트 서브넷 계산 표"><table className={styles.table}>
        <caption>203.0.113.142/26 주소 범위</caption>
        <thead><tr><th scope="col">항목</th><th scope="col">결과</th><th scope="col">확인 방법</th></tr></thead>
        <tbody>
          <tr><th scope="row">네트워크 주소</th><td><code>203.0.113.128/26</code></td><td>142보다 작거나 같은 블록 시작점 128</td></tr>
          <tr><th scope="row">브로드캐스트 주소</th><td><code>203.0.113.191</code></td><td>다음 블록 시작점 192의 바로 앞</td></tr>
          <tr><th scope="row">일반 LAN의 사용 가능 주소</th><td><code>203.0.113.129</code>~<code>203.0.113.190</code></td><td>양 끝의 네트워크·브로드캐스트 주소 제외</td></tr>
          <tr><th scope="row">주소 개수</th><td>전체 64개, 일반적으로 사용 가능 62개</td><td><code>2^6 = 64</code>에서 양 끝 2개 제외</td></tr>
        </tbody>
      </table></div>
      <p><strong>설정 점검:</strong> 호스트가 <code>203.0.113.142/26</code>이고 기본 게이트웨이가 <code>203.0.113.129</code>라면 같은 <code>/26</code>에 있습니다. 게이트웨이를 <code>203.0.113.65</code>로 입력했다면 이는 <code>203.0.113.64/26</code>에 속합니다. 호스트 주소·마스크·게이트웨이 값과 장비의 실제 구성을 함께 확인해야 합니다. 이 계산만으로 케이블, VLAN, 라우팅 등 다른 원인을 배제할 수는 없습니다.</p>
      <p><code>142</code>를 가까운 시작점으로 반올림하지 말고 <strong>현재 주소 이하의 시작점</strong>을 찾으세요. 62개의 사용 가능 주소에는 게이트웨이에 배정한 주소도 포함됩니다. 다른 장비에 배정할 때는 그 주소를 빼야 합니다.</p>
    </section>
    <section aria-labelledby="ccna-23"><h2 id="ccna-23">예제 2: /23은 마지막 옥텟만 보면 틀립니다</h2>
      <p>사설 주소 <code>10.20.35.10/23</code>의 마스크는 <code>255.255.254.0</code>입니다. 블록은 마지막이 아닌 <strong>세 번째 옥텟</strong>에서 바뀝니다. <code>256 − 254 = 2</code>이므로 블록은 <code>… 32~33, 34~35, 36~37 …</code>입니다. <code>35</code>는 <code>34~35</code> 블록에 들어갑니다.</p>
      <ul><li>네트워크: <code>10.20.34.0/23</code></li><li>브로드캐스트: <code>10.20.35.255</code></li><li>일반적인 사용 가능 호스트: <code>10.20.34.1</code>~<code>10.20.35.254</code></li><li>호스트 비트 9개 → 전체 <code>2^9 = 512</code>개, 일반적으로 사용 가능 510개</li></ul>
      <p><code>10.20.34.200</code>과 <code>10.20.35.10</code>은 이 <code>/23</code>에서 같은 네트워크입니다. 한쪽 장비의 마스크가 <code>/24</code>라면 같은 주소 쌍을 서로 다르게 판단할 수 있습니다. 연결 문제에서는 <strong>두 장비의 IP와 마스크를 각각</strong> 확인하세요.</p>
    </section>
    <section className={styles.quiz} aria-labelledby="ccna-check"><h2 id="ccna-check">답을 펼치기 전에 직접 풀어 보세요</h2>
      <ol><li><code>198.51.100.173/28</code>의 네트워크 주소, 브로드캐스트 주소, 일반적인 사용 가능 호스트 범위는 무엇인가요?</li><li>같은 호스트의 기본 게이트웨이가 <code>198.51.100.177</code>이라면 같은 <code>/28</code> 블록에 있나요?</li></ol>
      <details><summary>정답과 해설 보기</summary><p><code>/28</code>의 마스크는 <code>255.255.255.240</code>, 블록 크기는 16입니다. <code>173</code>은 <code>160~175</code> 블록에 있으므로 네트워크는 <strong>198.51.100.160/28</strong>, 브로드캐스트는 <strong>198.51.100.175</strong>, 일반적인 호스트 범위는 <strong>198.51.100.161~198.51.100.174</strong>입니다. <code>177</code>은 다음 <code>176~191</code> 블록에 있어 같은 <code>/28</code>에 있지 않습니다. 주소 숫자가 가깝다는 사실은 서브넷 판정에 영향을 주지 않습니다.</p></details>
      <p>틀렸다면 ‘내가 고른 시작점 / 실제 시작점 / 블록 크기를 구한 옥텟’을 한 줄로 적고 새 주소로 다시 계산해 보세요.</p>
    </section>
    <aside className={styles.cta} aria-labelledby="ccna-practice"><h2 id="ccna-practice">계산을 연습문제에 적용해 보세요</h2>
      <p>2026-10 영어 자체 제작 23문항 세트에서 주소·마스크 관련 문항을 찾아 먼저 계산하고 답과 해설을 대조하세요. 아래 링크는 해당 회차 문제풀이로 이동하며 주제별 필터는 없습니다. 이 세트는 Cisco의 공식 기출문제가 아닙니다.</p>
      <ExamLink href={ccnaPost.practicePath}>CCNA 2026-10 연습문제 풀기 →</ExamLink>
    </aside>
    <section className={styles.sources} aria-labelledby="ccna-sources"><h2 id="ccna-sources">근거와 적용 범위</h2>
      <p><a href="https://learningcontent.cisco.com/documents/marketing/exam-topics/200-301-CCNA-v1.1.pdf">Cisco CCNA v1.1 시험 범위</a> · <a href="https://learningcontent.cisco.com/documents/marketing/exam-topics/200-301_CCNA_v2.0_Exam_Topics_PDF.pdf">Cisco CCNA v2.0 시험 범위</a> · <a href="https://blogs.cisco.com/learning/stay-on-track-get-certified-before-the-ccna-refresh">Cisco 버전 전환 일정</a></p>
      <p><a href="https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13788-3.html">Cisco IP 주소와 서브넷 설명</a> · <a href="https://www.rfc-editor.org/rfc/rfc5737">RFC 5737: 문서 예제용 주소</a> · <a href="https://www.rfc-editor.org/rfc/rfc1918">RFC 1918: 사설 주소</a></p>
      <p><code>203.0.113.0/24</code>와 <code>198.51.100.0/24</code>는 문서 예제용 주소이고 <code>10.0.0.0/8</code>은 사설 주소입니다. 일반적인 브로드캐스트 LAN의 호스트 수를 설명했으며, <code>/31</code> 지점 간 링크와 <code>/32</code> 단일 주소에는 양 끝 주소 두 개를 제외하는 규칙을 그대로 적용하지 않습니다.</p>
      <p>영어로 기본 계산을 다시 읽고 싶다면 <a href={subnetPost.path} lang="en">IPv4 subnetting worked examples</a>를 참고하세요. 이 글은 게이트웨이와 마스크 점검에, 영어 글은 주소 계산 자체에 집중합니다.</p>
    </section>
  </>;
}
