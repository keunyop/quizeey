import { cloudPost, subnetPost } from '@/lib/blog';
import { ExamLink } from './ExamLink';
import styles from './blog.module.css';

export function CloudResponsibilityArticle() {
  return <>
    <p className={styles.lead}>For IaaS, PaaS and SaaS questions, identify the exact task before choosing who owns it. In a typical public-cloud setup, the provider runs the physical infrastructure. You still decide who may access your organisation’s data. The useful dividing question is: <strong>are you operating a server, deploying your code to a managed platform, or using a finished application?</strong></p>
    <p>This guide is for cloud beginners and AZ-900 learners. Work through the three original scenarios below, then practise with explanations. They are learning exercises, not official Microsoft exam questions.</p>
    <section aria-labelledby="cloud-models"><h2 id="cloud-models">Start with what the customer operates</h2>
      <div className={styles.tableWrap} role="region" aria-label="Cloud service model comparison" tabIndex={0}><table className={styles.table}>
        <caption>A simplified comparison for public-cloud study scenarios</caption>
        <thead><tr><th scope="col">Model</th><th scope="col">What you use</th><th scope="col">A task you still own</th></tr></thead>
        <tbody>
          <tr><th scope="row">IaaS</th><td>Virtual machines and infrastructure</td><td>Maintain the guest operating system and your software</td></tr>
          <tr><th scope="row">PaaS</th><td>A managed platform for your application</td><td>Maintain your application code and access settings</td></tr>
          <tr><th scope="row">SaaS</th><td>A ready-made hosted application</td><td>Decide which users can access your business data</td></tr>
        </tbody>
      </table></div>
      <p>For Azure examples and a fuller responsibility matrix, see <a href="https://learn.microsoft.com/en-us/azure/security/fundamentals/shared-responsibility">Microsoft’s shared responsibility guidance</a>. The table above is a starting point, not a service contract. “Applications” and “networking” can include tasks on both sides of the boundary.</p>
    </section>
    <section aria-labelledby="cloud-method"><h2 id="cloud-method">A three-step way to read the question</h2>
      <ol className={styles.studySteps}>
        <li><strong>1. Underline the task.</strong><p>“Patch the guest OS” is precise. “Manage security” is too broad. Rewrite a vague task as something a person could actually do.</p></li>
        <li><strong>2. Identify the service model.</strong><p>A customer-managed VM suggests IaaS. Deploying code without operating the server suggests PaaS. Using an existing hosted application suggests SaaS.</p></li>
        <li><strong>3. State the boundary in one sentence.</strong><p>Use: “The provider handles ___, while the customer still handles ___.” If you cannot complete both halves, check the service description before choosing an answer.</p></li>
      </ol>
      <p>The <a href="https://www.ncsc.gov.uk/collection/cloud/understanding-cloud-services/cloud-security-shared-responsibility-model">UK NCSC guidance</a> explains why responsibility varies with the service and its implementation. An acronym helps narrow the answer; it does not describe every configuration option.</p>
    </section>
    <section className={styles.quiz} aria-labelledby="cloud-practice"><h2 id="cloud-practice">Three scenarios: who does the work?</h2>
      <p>Write your answer and one reason before opening each explanation. All organisations and situations below are invented.</p>
      <h3>1. The migrated booking server</h3>
      <p>A small training company moves its booking application onto a public-cloud VM. Its administrator still logs into the VM to install packages. Who normally patches that VM’s guest operating system: the company or the cloud provider?</p>
      <details><summary>Show cloud answer 1</summary><p><strong>The company.</strong> It operates the guest OS in this IaaS example. Running on someone else’s hardware does not mean that software inside the VM is provider-managed. AWS makes this guest-OS distinction explicit in its <a href="https://aws.amazon.com/compliance/shared-responsibility-model/">shared responsibility model</a>; check the chosen service’s terms for any separately managed patching.</p></details>
      <h3>2. The custom booking application</h3>
      <p>Another team deploys its own booking code to a platform that manages the underlying server OS. A developer accidentally removes the application’s permission check. Does the platform’s OS maintenance fix that application bug?</p>
      <details><summary>Show cloud answer 2</summary><p><strong>No.</strong> In this PaaS scenario, the team still owns the code it deploys. The provider’s maintenance of the platform is a different task. The useful clue is “its own booking code”, not simply “hosted in the cloud”.</p></details>
      <h3>3. The finished booking service</h3>
      <p>A third company subscribes to a finished booking application. A staff member changes roles and should no longer see customer bookings. Who decides and configures that user’s business access?</p>
      <details><summary>Show cloud answer 3</summary><p><strong>The customer organisation.</strong> It must keep its users’ permissions appropriate. The SaaS provider operates the hosted software, but cannot infer every staffing change or internal access decision. “The vendor runs the application” does not mean “the vendor owns all our decisions”.</p></details>
    </section>
    <section aria-labelledby="cloud-traps"><h2 id="cloud-traps">Fix the reasoning behind a wrong answer</h2>
      <ul className={styles.studySteps}>
        <li><strong>“It is in the cloud, so the provider does everything.”</strong><p>Name the remaining customer action in the scenario. In question 3, someone must remove access after the role change.</p></li>
        <li><strong>“It is PaaS, so every application task is ours.”</strong><p>Separate your code from the platform running it. Avoid assigning an entire layer to one party when the question names only one task.</p></li>
        <li><strong>“Public cloud means the data is public.”</strong><p>Service models and deployment models answer different questions. Public/private/hybrid describes the deployment; IaaS/PaaS/SaaS describes the service offered. NIST distinguishes these in its <a href="https://csrc.nist.gov/pubs/sp/800/145/final">cloud computing definition</a>.</p></li>
      </ul>
      <p>Make a one-line review note: “I assigned a staffing decision to the provider because I saw SaaS.” Revisit that mistake with a different scenario, rather than memorising an answer letter.</p>
    </section>
    <aside className={styles.cta} aria-labelledby="cloud-cta"><h2 id="cloud-cta">Apply the method to AZ-900 practice</h2><p>Open Quizeey’s English Azure Fundamentals practice, answer a question, and read the explanation. The practice set covers several Azure topics; it is not filtered to only the three scenarios in this article.</p><ExamLink href={cloudPost.practicePath}>Practise AZ-900 questions →</ExamLink><p>Quizeey provides independent practice, not Microsoft exam questions or a guarantee of exam readiness.</p></aside>
    <section className={styles.sources} aria-labelledby="cloud-next"><h2 id="cloud-next">Keep the next session focused</h2><p>Use the <a href="https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-900">official AZ-900 study guide</a> to check the current scope. It includes shared responsibility and cloud service types; this article covers only that part.</p><p>For a broader plan, see our <a href="/en/study-guides/aws-azure-certification-practice">AWS and Azure study guide</a>. If network ranges are your next gap, try our <a href={subnetPost.path}>IPv4 subnetting examples</a>.</p></section>
  </>;
}
