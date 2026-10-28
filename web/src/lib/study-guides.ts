import type { Metadata, MetadataRoute } from 'next';

type GuideSection = { heading: string; paragraphs: string[]; steps?: string[] };
export type StudyGuide = {
  slug: string;
  title: string;
  description: string;
  introduction: string;
  exams: { path: string; focus: string }[];
  sections: GuideSection[];
  resources: { title: string; url: string }[];
};

export const studyGuides: StudyGuide[] = [
  {
    slug: 'aws-azure-certification-practice',
    title: 'AWS and Azure Certification Practice: A Study Plan for Beginners',
    description: 'Choose AWS Cloud Practitioner or Azure AZ-900 practice, review cloud concepts, and turn wrong answers into a focused study plan with worked explanations.',
    introduction: 'Cloud certification preparation is easier to organize when you separate shared ideas from provider-specific services. Use this guide to choose a practice set, understand your mistakes and connect each answer to an official learning resource.',
    exams: [
      { path: '/en/aws-certified-cloud-practitioner', focus: 'Cloud concepts, security, AWS services and billing. Start here when studying foundational AWS terminology.' },
      { path: '/en/az-900', focus: 'Azure cloud concepts, architecture, services, management and governance. Practice choosing a service for a stated requirement.' },
      { path: '/en/aws-certified-developer-associate', focus: 'Development-focused AWS practice for learners moving beyond cloud fundamentals.' },
    ],
    sections: [
      { heading: 'Choose the exam before choosing the questions', paragraphs: [
        'AWS Certified Cloud Practitioner covers foundational AWS knowledge. Microsoft Azure Fundamentals focuses on cloud concepts and Azure services, management and governance. Read the current official exam overview for the credential you intend to take; similar cloud terms do not make the two exams interchangeable.',
        'For each study session, stay with one provider. Make a short glossary for compute, storage, networking, identity and costs. Write what a service does before memorizing its name. For example, distinguish object storage from a virtual machine disk by the type of data and access pattern in the question.',
      ] },
      { heading: 'Use a practice set as a learning loop', paragraphs: [
        'Try a small batch without checking the answers first. A correct guess needs review too: if you cannot explain why the other choices are weaker, add the concept to your review list. The goal is to recognize the requirement, not a familiar sentence.',
      ], steps: [
        'Choose one English practice set and answer a few questions at a time.',
        'Check the answer and read the explanation, including questions you guessed correctly.',
        'Write one sentence connecting the requirement to the service or cloud concept.',
        'Open the reference to check unfamiliar terminology in the official documentation.',
        'Revisit the missed questions later and explain the answer without looking at the choices.',
      ] },
      { heading: 'Turn mistakes into a focused revision plan', paragraphs: [
        'Group missed questions by concept: responsibility boundaries, availability, service selection, identity or pricing. If several errors share a category, pause the quiz and review that category before taking another batch. A higher repeated-question score can reflect memory; use your written explanation to judge whether your understanding improved.',
        'Use the answer explanations to review the reasoning behind each choice. These short drills do not simulate a complete exam or predict a result. Use the official objectives and learning materials to check complete coverage.',
      ] },
    ],
    resources: [
      { title: 'AWS Certified Cloud Practitioner: official overview and preparation', url: 'https://aws.amazon.com/certification/certified-cloud-practitioner/' },
      { title: 'Microsoft Certified: Azure Fundamentals', url: 'https://learn.microsoft.com/en-us/credentials/certifications/azure-fundamentals/' },
    ],
  },
  {
    slug: 'sat-ged-practice-study-plan',
    title: 'SAT and GED Practice: Choose Your Subject and Review Mistakes',
    description: 'Find free SAT Math, SAT Reading and Writing, and U.S. GED subject practice with answer explanations. Build a study plan around the skills you need to improve.',
    introduction: 'Start with your educational goal, then choose the appropriate exam and subject. SAT and GED preparation can share skills such as algebra and reading evidence, but they serve different purposes and have different official requirements. These practice links keep each subject separate.',
    exams: [
      { path: '/en/sat-math', focus: 'Algebra, nonlinear equations, data analysis, geometry and trigonometry with worked calculations.' },
      { path: '/en/sat-reading-writing', focus: 'Evidence, vocabulary in context, transitions, sentence structure and English conventions.' },
      { path: '/en/ged-math', focus: 'U.S. GED Mathematical Reasoning: basic calculations, algebra, graphs and geometry.' },
      { path: '/en/ged-language-arts', focus: 'U.S. GED RLA: reading comprehension, arguments, grammar and editing.' },
      { path: '/en/ged-science', focus: 'Scientific evidence, experiments, charts and quantitative reasoning.' },
      { path: '/en/ged-social-studies', focus: 'U.S. government, history, economics, geography and source interpretation.' },
    ],
    sections: [
      { heading: 'Keep your exam and subject in view', paragraphs: [
        'The SAT includes Reading and Writing and Math. GED preparation covers four subjects: Mathematical Reasoning, Reasoning Through Language Arts, Science and Social Studies. Use the official subject guides below to check what your chosen examination assesses.',
        'The GED links here are for U.S. study. They do not represent Canada’s current high-school equivalency program. Confirm the credential and local requirements with your education authority before organizing your preparation.',
      ] },
      { heading: 'Review the reasoning, not just the answer letter', paragraphs: [
        'For a math mistake, identify the first step that went wrong. Was it translating the words into an equation, choosing a formula, handling a negative sign or calculating? Redo that step with a different number. An explanation is most useful when you can reproduce the method on a new problem.',
        'For reading and science, point to the sentence, chart entry or experimental detail that supports your answer. Separate what the text states from what seems plausible. In editing questions, name the rule being tested, such as agreement, punctuation or logical transitions.',
      ], steps: [
        'Begin with a short batch in the subject you need to study.',
        'Read every answer explanation and mark unfamiliar skills.',
        'Keep a mistake log with the skill, the cause of the error and a corrected example.',
        'Review that skill before trying another batch; revisit earlier mistakes after a break.',
      ] },
      { heading: 'Add official format practice to skill practice', paragraphs: [
        'These multiple-choice exercises include concise explanations and help you practice individual skills. Adaptive testing and score calculation are not included. GED Language Arts practice here does not assess an extended-response essay.',
        'Once you understand a topic, use the official preparation resources to become familiar with the actual test experience. Keep a separate list of skills that a short question set has not covered, so a strong practice percentage does not hide a gap in your preparation.',
      ] },
    ],
    resources: [
      { title: 'College Board: what is on the SAT', url: 'https://satsuite.collegeboard.org/sat/whats-on-the-test' },
      { title: 'GED Testing Service: test subjects', url: 'https://www.ged.com/about-test/test-subjects.html' },
    ],
  },
  {
    slug: 'servsafe-foodsafe-practice',
    title: 'Food Safety Practice: ServSafe Food Handler, Manager and FOODSAFE',
    description: 'Choose U.S. ServSafe Food Handler or Manager practice, or BC FOODSAFE Level 1. Review food safety scenarios with answers, explanations and a practical study plan.',
    introduction: 'Food safety preparation works best when the questions match your role and location. Use U.S. ServSafe practice for the relevant U.S. program, or FOODSAFE Level 1 practice for British Columbia. Then organize your review around the decisions you make while handling food.',
    exams: [
      { path: '/en/servsafe-food-handler', focus: 'U.S. food handler practice: hygiene, contamination prevention, allergens, time and temperature, and sanitation.' },
      { path: '/en/servsafe-food-protection-manager', focus: 'U.S. manager practice: foodborne hazards, employee health, storage, preparation, HACCP, facilities and sanitation.' },
      { path: '/en/foodsafe-level-1', focus: 'British Columbia, Canada: food handling, contamination prevention, sanitation, time and temperature, and worker safety.' },
    ],
    sections: [
      { heading: 'Match your program and responsibility', paragraphs: [
        'ServSafe Food Handler covers basic safe food handling for employees. ServSafe Manager is a separate program for foodservice management responsibilities. FOODSAFE Level 1 is a British Columbia food handling, sanitation and worker safety course. Select the practice set that matches the program you are studying.',
        'A practice quiz does not issue a food handler credential or establish which training your workplace accepts. Check your employer’s and local authority’s requirements, then use your current course materials as the main source. Do not assume the U.S. and BC programs use identical rules or temperature guidance.',
      ], steps: [
        'Choose the U.S. handler, U.S. manager or BC FOODSAFE practice set.',
        'Answer a short batch, then read the explanation for every answer you were unsure about.',
        'Label the mistake: personal hygiene, contamination, allergens, time and temperature, cleaning, or management.',
        'Review that topic in your current training material before trying another batch.',
      ] },
      { heading: 'Read a scenario as a sequence of decisions', paragraphs: [
        'For each question, identify the food or surface involved, the possible hazard and the action being considered. An answer can sound familiar while addressing the wrong hazard. Explain why your chosen action fits the situation, then compare your reasoning with the worked explanation.',
        'For time and temperature questions, keep the location, unit and process visible in your notes. A number without its context is easy to apply incorrectly. For cleaning and sanitation, identify which step the scenario asks about before choosing a product or procedure. For manager questions, consider the control or monitoring decision in addition to an individual worker’s action.',
      ] },
      { heading: 'Use explanations to build a revision checklist', paragraphs: [
        'After a batch, write one corrected rule for each missed topic and an example of when it applies. Revisit those notes before the next session. If the same category keeps causing errors, review that lesson before repeating the quiz; remembering the answer letter is not the same as understanding the decision.',
        'Use the concise explanations and linked references to review the reasoning behind each answer. Follow your current course and official guidance for complete requirements.',
      ] },
    ],
    resources: [
      { title: 'ServSafe: Food Handler program', url: 'https://www.servsafe.com/ServSafe-Food-Handler' },
      { title: 'ServSafe: Manager program', url: 'https://www.servsafe.com/ServSafe-Manager' },
      { title: 'FOODSAFE: Level 1 course', url: 'https://www.foodsafe.ca/courses/level-1.html' },
    ],
  },
];

export const studyGuideIndex = {
  title: 'Free Exam Practice and Study Guides in English',
  description: 'Choose an English study guide for AWS and Azure certifications, SAT and GED subjects, or ServSafe and BC FOODSAFE. Practice with answers and explanations.',
};
export const studyGuidePath = (slug?: string) => '/en/study-guides' + (slug ? '/' + slug : '');
export const findStudyGuide = (slug: string) => studyGuides.find(guide => guide.slug === slug);
export const isStudyGuidePath = (path: string) => path === studyGuidePath() || studyGuides.some(guide => path === studyGuidePath(guide.slug));

export function studyGuideMetadata(origin: string, publicProduction: boolean, guide?: StudyGuide): Metadata {
  const copy = guide ?? studyGuideIndex;
  const url = origin + studyGuidePath(guide?.slug);
  return {
    title: { absolute: `${copy.title} | Quizeey` }, description: copy.description,
    robots: { index: publicProduction, follow: publicProduction },
    ...(publicProduction ? { alternates: { canonical: url, languages: { en: url, 'en-US': url, 'en-CA': url } } } : {}),
    openGraph: { title: copy.title, description: copy.description, siteName: 'Quizeey', type: 'website', locale: 'en_US', alternateLocale: ['en_CA'], ...(publicProduction ? { url } : {}) },
    twitter: { card: 'summary', title: copy.title, description: copy.description },
  };
}

export function studyGuideSitemap(origin: string): MetadataRoute.Sitemap {
  return [undefined, ...studyGuides].map(guide => {
    const url = origin + studyGuidePath(guide?.slug);
    return { url, alternates: { languages: { en: url, 'en-US': url, 'en-CA': url } } };
  });
}
