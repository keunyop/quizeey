import { blogPost, subnetPost, cloudPost, roadSignsPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function SubnetArticle() {
  return <>
    <p className={styles.lead}>To solve an IPv4 subnetting question, find the address block containing the host. Its first address is the network address; its last is the broadcast address. For the ordinary LAN subnets below, the usable host range is everything between them. Start with <strong>192.0.2.150/26: network .128, broadcast .191, usable hosts .129–.190</strong>.</p>
    <p>These original exercises are for networking students and Network+ learners. They are not official exam questions. Write your answer before opening each solution; a calculator result alone will not show where your reasoning went wrong.</p>
    <section aria-labelledby="subnet-method"><h2 id="subnet-method">Four steps for a /26 subnet</h2>
      <p>An IPv4 address has 32 bits. A /26 prefix uses 26 for the network and leaves 6 for hosts: 2<sup>6</sup> = 64 addresses per block. The mask is 255.255.255.192.</p>
      <ol className={styles.studySteps}>
        <li><strong>1. Find the block size.</strong><p>In the last octet, 256 − 192 = 64. The blocks start at 0, 64, 128 and 192.</p></li>
        <li><strong>2. Locate the host.</strong><p>150 is between 128 and 191, so the network is 192.0.2.128/26. Do not round 150 to the nearest boundary; find the boundary at or below it.</p></li>
        <li><strong>3. Stop before the next block.</strong><p>The next network starts at .192. One address earlier, 192.0.2.191, is this subnet’s broadcast address.</p></li>
        <li><strong>4. Remove the endpoints.</strong><p>The usable range is 192.0.2.129–192.0.2.190: 64 − 2 = 62 addresses. A gateway normally uses one of these addresses too.</p></li>
      </ol>
      <figure className={styles.figure}><div className={styles.comparison}>
        <div className={styles.countCard}><code>192.0.2.128</code><strong>Start</strong><span>Network address</span></div>
        <div className={styles.countCard}><code>192.0.2.129–190</code><strong>62</strong><span>Usable addresses</span></div>
        <div className={styles.countCard}><code>192.0.2.191</code><strong>End</strong><span>Broadcast address</span></div>
      </div><figcaption>A /26 contains 64 addresses, not 64 usable host addresses.</figcaption></figure>
    </section>
    <section aria-labelledby="subnet-table"><h2 id="subnet-table">A small reference table</h2>
      <div className={styles.tableWrap} role="region" aria-label="Subnet reference table" tabIndex={0}><table className={styles.table}><caption>Ordinary IPv4 LAN subnets within a /24</caption><thead><tr><th scope="col">Prefix</th><th scope="col">Mask</th><th scope="col">Addresses</th><th scope="col">Usable</th></tr></thead><tbody>
        {[[25, '255.255.255.128', 128, 126], [26, '255.255.255.192', 64, 62], [27, '255.255.255.224', 32, 30], [28, '255.255.255.240', 16, 14], [29, '255.255.255.248', 8, 6], [30, '255.255.255.252', 4, 2]].map(([prefix, mask, total, usable]) => <tr key={prefix}><th scope="row">/{prefix}</th><td><code>{mask}</code></td><td>{total}</td><td>{usable}</td></tr>)}
      </tbody></table></div>
      <p>The “subtract two” rule is for conventional broadcast subnets. A /31 can use both addresses on a point-to-point link; a /32 identifies one address. Do not apply this table to IPv6.</p>
    </section>
    <section className={styles.quiz} aria-labelledby="subnet-exercises"><h2 id="subnet-exercises">Try three subnetting questions</h2>
      <h3>1. Which block contains 198.51.100.77/27?</h3><p>Find the network, broadcast and usable host range.</p>
      <details><summary>Show answer 1</summary><p><strong>Network: 198.51.100.64/27. Broadcast: 198.51.100.95. Usable: .65–.94.</strong> A /27 has 32 addresses. The boundaries are .0, .32, .64, .96 and so on; 77 lies in the .64–.95 block. There are 30 usable addresses.</p></details>
      <h3>2. Are 203.0.113.62/27 and 203.0.113.65/27 in the same subnet?</h3>
      <details><summary>Show answer 2</summary><p><strong>No.</strong> .62 belongs to 203.0.113.32/27, whose broadcast is .63. Address .65 belongs to 203.0.113.64/27, whose broadcast is .95. Matching the first three octets is not enough: the prefix determines the boundary.</p></details>
      <h3>3. What changes for 172.16.35.10/20?</h3><p>The mask is 255.255.240.0. Work in the third octet this time.</p>
      <details><summary>Show answer 3</summary><p><strong>Network: 172.16.32.0/20. Broadcast: 172.16.47.255. Usable: 172.16.32.1–172.16.47.254.</strong> The third-octet block size is 256 − 240 = 16. Value 35 is in the 32–47 block, and the entire fourth octet varies. Twelve host bits give 4,096 total addresses and 4,094 conventional usable addresses.</p></details>
    </section>
    <section aria-labelledby="subnet-review"><h2 id="subnet-review">Use the mistake to choose your next step</h2>
      <ul><li><strong>Right block, wrong host count:</strong> distinguish total addresses from usable addresses.</li><li><strong>Off by one:</strong> the next network starts after the broadcast, not at it.</li><li><strong>A /20 treated like a /27:</strong> find the octet where the mask changes before counting blocks.</li><li><strong>Correct guess:</strong> explain the boundary without looking at the choices, then change the host address and try again.</li></ul>
      <p>Keep a three-column note: “my answer / correct boundary / rule I missed”. For broader study planning, see <a href="/en/study-guides/current-certification-exam-versions">current certification versions and practice sets</a>.</p>
    </section>
    <aside className={styles.cta} aria-labelledby="subnet-practice"><h2 id="subnet-practice">Check the method in Network+ practice</h2>
      <p>Quizeey’s N10-009 set contains 12 original English questions, including an IPv4 subnet calculation, with answer explanations. It is a short topic drill, not a full exam simulation or a complete subnetting question bank.</p>
      <ExamLink href={subnetPost.practicePath}>Practise Network+ questions →</ExamLink>
      <p>Answer first, read the explanation and return to the step you missed. Add hands-on network labs and the official objectives to your preparation.</p>
    </aside>
    <section className={styles.sources} aria-labelledby="subnet-sources"><h2 id="subnet-sources">Check the underlying rules</h2>
      <p><a href="https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13788-3.html">Cisco: IPv4 addressing, subnetting and special subnets</a> · <a href="https://www.rfc-editor.org/rfc/rfc3021.html">RFC 3021: /31 point-to-point links</a> · <a href="https://assets.ctfassets.net/82ripq7fjls2/113XqW3JHT7AlIU33M63I0/af42da2af7383a38f318bad10aa9afbd/Network_Plus_N10-009_Exam_Objectives.pdf">CompTIA Network+ N10-009 objectives</a></p>
      <p>The 192.0.2.0/24, 198.51.100.0/24 and 203.0.113.0/24 examples use <a href="https://datatracker.ietf.org/doc/html/rfc5737">documentation address ranges</a>. The /20 example uses private address space.</p>
      <p>Moving on to cloud concepts? Try <a href={cloudPost.path}>shared responsibility practice</a>.</p>
      <p>Studying for Ontario G1 as well? Use the answer-first approach in our <a href={roadSignsPost.path}>road sign shapes and colours practice</a>.</p>
      <p>Also studying SQL in Korean? Read our <a href={blogPost.path} lang="ko">SQLD CBT 공부법</a> for a worked review exercise.</p>
    </section>
  </>;
}
