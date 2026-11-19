import { ccnaPost, ccnaTroubleshootingPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function CcnaTroubleshootingArticle() {
  return <>
    <p className={styles.lead}>CCNA 문제에서 두 IPv4 주소의 앞 세 옥텟이 같아도 같은 서브넷이라고 단정할 수 없습니다. <strong>각 장비가 자기 마스크로 상대 주소를 어떻게 판단하는지</strong> 양쪽에서 계산해 보세요. 이 글은 마스크가 다른 한 사례를 끝까지 분석한 뒤, 실제 설정을 점검하는 순서로 연결합니다. 직접 만든 학습 예제이며 Cisco의 공식 기출문제가 아닙니다.</p>

    <section aria-labelledby="mask-scenario"><h2 id="mask-scenario">한 LAN, 서로 다른 마스크: A와 B의 판단은?</h2>
      <p>같은 이더넷 LAN에 연결한 두 장비가 있다고 가정합니다. A의 설정은 <code>198.51.100.70/26</code>, B의 설정은 <code>198.51.100.130/24</code>입니다. 우선 다른 경로나 실제 패킷 전달은 따지지 않고, <strong>각 장비의 주소와 마스크만으로</strong> 상대가 자기 서브넷 안에 있는지 계산하겠습니다.</p>
      <div className={styles.tableWrap} role="region" aria-label="장비별 서브넷 판단 비교 표, 가로로 스크롤 가능" tabIndex={0}>
        <table className={styles.table}>
          <caption>각 장비가 자기 마스크로 계산한 결과</caption>
          <thead><tr><th scope="col">판단하는 장비</th><th scope="col">자기 주소의 블록</th><th scope="col">상대 주소 판단</th></tr></thead>
          <tbody>
            <tr><th scope="row">A: 198.51.100.70/26</th><td><code>198.51.100.64</code>~<code>198.51.100.127</code></td><td>B의 <code>.130</code>은 블록 밖</td></tr>
            <tr><th scope="row">B: 198.51.100.130/24</th><td><code>198.51.100.0</code>~<code>198.51.100.255</code></td><td>A의 <code>.70</code>은 블록 안</td></tr>
          </tbody>
        </table>
      </div>
      <p>A의 <code>/26</code>은 <code>255.255.255.192</code>입니다. 마지막 옥텟의 블록 크기는 <code>256 − 192 = 64</code>이므로 <code>.70</code>은 <code>.64~.127</code>, <code>.130</code>은 <code>.128~.191</code>에 들어갑니다. 반면 B의 <code>/24</code>는 <code>255.255.255.0</code>이어서 두 주소 모두 <code>198.51.100.0/24</code>에 들어갑니다.</p>
      <p>여기서 블록은 네트워크 주소와 브로드캐스트 주소까지 포함합니다. A 블록의 일반적인 호스트 범위는 <code>.65~.126</code>, B 블록은 <code>.1~.254</code>입니다. 예제의 두 장비 주소는 각각 자기 블록에서 사용할 수 있는 주소입니다.</p>
    </section>

    <section aria-labelledby="mask-and"><h2 id="mask-and">확실히 확인하려면 같은 마스크로 두 번 AND</h2>
      <p>한 장비의 판단을 확인할 때는 <strong>자기 IP와 목적지 IP에 그 장비의 마스크를 각각 비트 AND</strong>합니다. 결과가 같으면 그 마스크 기준으로 같은 서브넷입니다. A의 마스크로 자기 주소를 계산한 결과와 B의 마스크로 상대 주소를 계산한 결과를 섞어 비교하지 마세요.</p>
      <pre className={styles.code}><code>{'A의 /26 마스크로 계산\n자기 주소: 198.51.100.70  AND 255.255.255.192 = 198.51.100.64\n상대 주소: 198.51.100.130 AND 255.255.255.192 = 198.51.100.128\n→ 다름: A의 마스크 기준으로 상대는 서브넷 밖\n\nB의 /24 마스크로 계산\n자기 주소: 198.51.100.130 AND 255.255.255.0 = 198.51.100.0\n상대 주소: 198.51.100.70  AND 255.255.255.0 = 198.51.100.0\n→ 같음: B의 마스크 기준으로 상대는 서브넷 안'}</code></pre>
      <p><a href={ccnaPost.path}>CCNA 서브넷 주소 범위 계산 가이드</a>에서 블록 찾기를 복습했다면, 이번에는 같은 주소 쌍을 양쪽 관점에서 계산하는 데 집중해 보세요.</p>
    </section>

    <section aria-labelledby="mask-ping"><h2 id="mask-ping">이 결과만으로 ping 성공을 알 수 없는 이유</h2>
      <p>지금 확인한 사실은 <strong>A와 B의 마스크 기준 판단이 서로 다르다</strong>는 것입니다. “A에서 B로만 ping이 된다”거나 “반드시 양쪽 모두 실패한다”는 결론은 아직 낼 수 없습니다. ping은 요청이 도착하고 응답도 돌아와야 하며, 실제 경로 선택은 라우팅 테이블도 확인해야 합니다.</p>
      <p>일반적인 이더넷 IPv4 전달에서는 같은 링크의 다음 홉에 대한 MAC 주소를 ARP로 알아냅니다. 목적지를 직접 연결된 것으로 취급하는지, 게이트웨이 등 다른 다음 홉을 쓰는지에 따라 ARP로 찾을 대상도 달라집니다. 더 구체적인 경로, 게이트웨이 설정, 프록시 ARP, VLAN, 접근 제어와 방화벽도 결과에 영향을 줄 수 있습니다.</p>
      <p>따라서 주소 계산은 <strong>설정 불일치를 발견하는 근거</strong>이고, 실제 통신 결과는 경로와 관측 자료로 추가 확인할 대상입니다. 실제 패킷을 실행하거나 성공한 것처럼 꾸민 로그는 이 예제에 포함하지 않았습니다.</p>
    </section>

    <section aria-labelledby="mask-checklist"><h2 id="mask-checklist">IPv4 설정을 점검하는 네 단계</h2>
      <ol className={styles.studySteps}>
        <li><strong>01 · 양쪽의 실제 설정을 적습니다</strong><p>사용 중인 인터페이스의 IPv4 주소, 마스크 또는 프리픽스, 기본 게이트웨이와 연결 상태를 확인합니다. 저장한 설정 문서만 보지 말고 실제 적용값과 비교하세요. DHCP로 받은 값인지 수동 입력인지도 기록합니다.</p></li>
        <li><strong>02 · 의도한 주소 계획과 대조합니다</strong><p>각 주소의 네트워크·브로드캐스트·호스트 범위를 계산하고, 두 장비가 원래 같은 IP 서브넷에 있어야 하는지 확인합니다. 일반적인 LAN의 게이트웨이 주소도 호스트에서 직접 도달할 수 있는 올바른 주소인지 점검합니다. 마스크가 다르다는 이유만으로 어느 쪽이 틀렸는지는 알 수 없습니다.</p></li>
        <li><strong>03 · 가는 경로와 돌아오는 경로를 확인합니다</strong><p>양쪽 라우팅 테이블에서 목적지와 응답 목적지에 맞는 경로를 찾습니다. 다음 홉에 대한 ARP 항목, 스위치 포트의 VLAN과 링크 상태를 함께 확인하고, 필요한 경우 ACL·방화벽에서 ICMP 처리를 살펴봅니다.</p></li>
        <li><strong>04 · 한 변경의 결과를 같은 조건에서 비교합니다</strong><p>의도한 주소 계획에 맞춰 잘못된 값을 고친 뒤, 같은 출발지·목적지·인터페이스로 다시 확인합니다. 요청과 응답의 관측 결과를 기록하세요. IP 주소로 통신이 되는지와 DNS 이름이 해석되는지도 구분해야 원인을 좁힐 수 있습니다.</p></li>
      </ol>
    </section>

    <section className={styles.quiz} aria-labelledby="mask-correction"><h2 id="mask-correction">수정하기 전에 한 번 더 생각하기</h2>
      <details><summary>B의 마스크만 /26으로 바꾸면 해결될까요?</summary>
        <p><strong>두 마스크를 같게 만드는 것만으로 같은 서브넷이 되지는 않습니다.</strong> B를 <code>198.51.100.130/26</code>으로 바꾸면 B의 블록은 <code>198.51.100.128~198.51.100.191</code>입니다. A의 <code>198.51.100.64~198.51.100.127</code>과 여전히 다릅니다.</p>
        <p>두 장비를 같은 서브넷에 두려는 계획인지, 서로 다른 서브넷 사이에서 라우팅하려는 계획인지 먼저 확인해야 합니다. 전자라면 계획에 맞는 주소·마스크와 중복 없는 호스트 주소를, 후자라면 올바른 경로와 다음 홉을 확인하세요. 이 정보 없이 특정 설정 하나를 정답으로 고를 수 없습니다.</p>
      </details>
      <p>오답 메모에는 “앞 세 옥텟이 같아서 같은 서브넷으로 봤다 → 각 장비의 마스크로 양쪽 주소를 계산한다”처럼 잘못 사용한 기준과 새 기준을 함께 적어 보세요.</p>
    </section>

    <aside className={styles.cta} aria-labelledby="mask-practice"><h2 id="mask-practice">CCNA IPv4 한국어 원본 5문제로 확인하세요</h2>
      <p>2026년 11월 세트는 게이트웨이 주소, 네트워크 범위, 서로 다른 마스크의 판단, 링크 주소와 겹치지 않는 서브넷 배치를 다룹니다. 이 글과 다른 주소 예제로 계산한 뒤 정답과 해설을 대조해 보세요. Quizeey가 만든 한국어 학습문항이며 Cisco의 공식 기출문제나 한국어 시험 제공을 뜻하지 않습니다.</p>
      <ExamLink href={ccnaTroubleshootingPost.practicePath}>CCNA IPv4 한국어 5문제 풀기 →</ExamLink>
    </aside>

    <section className={styles.sources} aria-labelledby="mask-sources"><h2 id="mask-sources">공식 근거와 적용 범위</h2>
      <p>2026년 11월 19일 확인. <a href="https://learningcontent.cisco.com/documents/marketing/exam-topics/200-301-CCNA-v1.1.pdf">CCNA 200-301 v1.1 공식 범위</a>의 1.6은 IPv4 주소·서브네팅 설정과 검증을, <a href="https://learningcontent.cisco.com/documents/marketing/exam-topics/200-301_CCNA_v2.0_Exam_Topics_PDF.pdf">v2.0 공식 범위</a>의 1.3은 IPv4 주소 설정·할당·서브네팅 문제 해결을 다룹니다. 이 글은 해당 개념의 일부를 연습하며 시험 전체 범위를 다루지는 않습니다.</p>
      <p><a href="https://www.cisco.com/site/us/en/learn/training-certifications/certifications/enterprise/ccna/index.html">Cisco의 버전별 안내</a>에 따르면 v1.1 마지막 응시일은 2027년 2월 2일, v2.0 첫 응시일은 2027년 2월 3일입니다. 한국어는 이 글과 연습문항의 설명 언어입니다. 실제 응시 언어는 예약 전에 <a href="https://www.cisco.com/site/us/en/learn/training-certifications/exams/ccna.html">Cisco 시험 안내</a>와 버전별 안내에서 확인하세요.</p>
      <ul>
        <li><a href="https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13788-3.html">Cisco: IP 주소와 서브넷 이해</a> — 마스크로 네트워크 부분을 구분하는 원리와 서브넷 범위.</li>
        <li><a href="https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/ipaddr_arp/configuration/15-mt/arp-15-mt-book/arp-config-arp.html">Cisco: ARP와 프록시 ARP</a> — 다음 홉의 IP·MAC 대응과 단순 주소 계산만으로 통신을 단정할 수 없는 배경. 이 글은 해당 IOS 버전의 설정 명령을 그대로 적용하는 절차가 아닙니다.</li>
        <li><a href="https://www.rfc-editor.org/rfc/rfc5737">RFC 5737</a> — 예제의 <code>198.51.100.0/24</code>는 문서 예제용 주소입니다.</li>
      </ul>
    </section>
  </>;
}
