// Reviewed against provider documentation on this date. Exam versions and
// practice-set dates are separate: a new set never revives a retired exam.
export const certificationReviewDate = '2026-10-30';
export type Certification = {
  code: string;
  status: 'retired' | 'current';
  note: string;
  source: string;
  replacement?: string;
  related: string[];
};
const microsoft = 'https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/';
const cisco = 'https://www.cisco.com/site/us/en/learn/training-certifications/exams/retired.html';
const comptia = 'https://www.comptia.org/en-us/certifications/';
const msUpdates = 'https://learn.microsoft.com/en-us/credentials/certifications/posts/updates-to-several-azure-and-data-ai-certifications-are-coming-soon';
const serverRetirement = 'https://techcommunity.microsoft.com/blog/skills-hub-blog/mcsa-mcsd-mcse-certifications-retire-with-continued-investment-to-role-based-cer/1489670';

export const certifications: Record<string, Certification> = {
  '166': { code: '200-125', status: 'retired', note: 'CCNA 200-125 retired on February 23, 2020. Continue with CCNA 200-301; the old questions remain available for reference.', source: cisco, replacement: '204', related: ['255'] },
  '168': { code: 'SY0-501', status: 'retired', note: 'SY0-501 is a retired Security+ exam. This archive and its supplemental questions are not a SY0-701 practice set.', source: comptia + 'security/', replacement: '253', related: ['259'] },
  '169': { code: 'AZ-103', status: 'retired', note: 'AZ-103 was replaced by AZ-104. Keep this archive for earlier Azure concepts and use the separate AZ-104 set for administrator practice.', source: msUpdates, replacement: '254', related: ['170'] },
  '172': { code: 'AZ-300', status: 'retired', note: 'AZ-300 is retired. The architect exam path changed through AZ-303/AZ-304; AZ-305 is the current infrastructure design exam, with separate certification prerequisites.', source: microsoft + 'az-305', replacement: '257', related: ['254'] },
  '174': { code: '300-115', status: 'retired', note: 'CCNP SWITCH 300-115 retired on February 23, 2020. ENCOR is part of the newer CCNP Enterprise path, not a one-for-one replacement for this switching exam.', source: cisco, replacement: '208', related: ['204'] },
  '180': { code: '300-101', status: 'retired', note: 'CCNP ROUTE 300-101 retired on February 23, 2020. The CCNP Enterprise path uses a core exam and a concentration exam; review the current requirements.', source: cisco, replacement: '208', related: ['204'] },
  '181': { code: '220-1001', status: 'retired', note: 'A+ Core 1 220-1001 is retired. Use the separate 220-1201 set for current Core 1 study. A+ requires Core 1 and Core 2 from the same exam series.', source: comptia + 'a/', replacement: '256', related: ['238'] },
  '182': { code: 'N10-007', status: 'retired', note: 'Network+ N10-007 is retired. N10-009 practice is available separately; archive questions have not been relabeled as the newer exam.', source: comptia + 'network/', replacement: '255', related: ['204'] },
  '183': { code: '70-740', status: 'retired', note: 'This Windows Server 2016 MCSA exam retired on January 31, 2021. Related Azure administration practice covers a different credential and is not a direct replacement.', source: serverRetirement, related: ['254'] },
  '187': { code: 'AZ-301', status: 'retired', note: 'AZ-301 is retired. Use the current AZ-305 design objectives and check the Azure Solutions Architect Expert prerequisites before choosing your certification path.', source: microsoft + 'az-305', replacement: '257', related: ['254'] },
  '190': { code: 'MS-100', status: 'retired', note: 'MS-100 is retired. Its successor MS-102 is itself scheduled to retire on November 30, 2026. Check Microsoft’s retirement list before booking; related fundamentals practice is not an equivalent exam.', source: 'https://learn.microsoft.com/en-us/credentials/support/retired-certification-exams', related: ['259'] },
  '194': { code: '2V0-21.19', status: 'retired', note: 'Professional VMware vSphere 6.7 retired on June 30, 2021. This page preserves the older version; check Broadcom’s current certification paths rather than treating these questions as current VMware exam preparation.', source: 'https://docs.broadcom.com/doc/vmware-retired-exams-certifications-and-badges', related: ['170'] },
  '195': { code: '70-741', status: 'retired', note: 'This Windows Server 2016 MCSA networking exam retired on January 31, 2021. Related networking practice is foundational study, not an equivalent Microsoft credential.', source: serverRetirement, related: ['255'] },
  '198': { code: 'AZ-500', status: 'retired', note: 'AZ-500 retired on August 31, 2026. Microsoft now offers the SC-500 Cloud and AI Security Engineer path. SC-900 below is related foundational practice, not the SC-500 replacement exam.', source: microsoft + 'az-500', related: ['259', '253'] },
  '205': { code: 'CAS-003', status: 'retired', note: 'CASP+ CAS-003 is retired. Review CompTIA’s SecurityX path for advanced security certification. The linked Security+ set is foundational review, not a SecurityX exam simulation.', source: comptia + 'securityx/', related: ['253'] },
  '253': { code: 'SY0-701', status: 'current', note: 'Original SY0-701 topic drills: security concepts, threats, architecture, operations and risk. These 12 scenarios sample the objectives; they do not simulate performance-based tasks or a full exam.', source: 'https://www.comptia.jp/pdf/CompTIA%20Security%2B%20SY0-701%20Exam%20Objectives.pdf', related: ['259', '255'] },
  '254': { code: 'AZ-104', status: 'current', note: 'Original administrator scenarios covering identity, governance, storage, compute, networking and monitoring. Use the April 17, 2026 objectives and hands-on labs alongside these 12 questions.', source: microsoft + 'az-104', related: ['170', '257'] },
  '255': { code: 'N10-009', status: 'current', note: 'Original Network+ scenarios covering connectivity, implementation, operations, security and troubleshooting. Twelve questions are a focused drill, not complete objective coverage or a performance-based simulation.', source: 'https://www.comptia.jp/pdf/CompTIANetwork%2BN10-009_ExamObjectives%284.0%29.pdf', related: ['204', '253'] },
  '256': { code: '220-1201', status: 'current', note: 'Original A+ Core 1 scenarios covering devices, networking, hardware, virtualization and troubleshooting. A+ also requires the matching Core 2 exam; this 12-question drill does not cover the full certification.', source: 'https://lecbyo.files.cmp.optimizely.com/download/34be017cb73211ef8985a6f347fbf652', related: ['238', '255'] },
  '257': { code: 'AZ-305', status: 'current', note: 'Original Azure infrastructure design scenarios: identity, data storage, business continuity and infrastructure. These 12 questions supplement the official objectives; check the separate certification prerequisites.', source: microsoft + 'az-305', related: ['254', '258'] },
  '258': { code: 'DP-900', status: 'current', note: 'Original data fundamentals scenarios covering relational and non-relational data, transactional and analytical workloads. Twelve topic drills supplement the July 21, 2026 objectives.', source: microsoft + 'dp-900', related: ['170', '257'] },
  '259': { code: 'SC-900', status: 'current', note: 'Original security, compliance and identity fundamentals scenarios. Twelve topic drills supplement the October 21, 2026 objectives; this is a fundamentals exam, not the SC-500 engineering credential.', source: microsoft + 'sc-900', related: ['253', '170'] },
};

export const certificationFor = (id: string | null | undefined) => id ? certifications[id] : undefined;
export const isRetiredExam = (id: string | null | undefined) => certificationFor(id)?.status === 'retired';

// Explicit English taxonomy keeps unrelated Korean categories unchanged.
export const certificationCategories: Record<string, 'cloud' | 'security' | 'networking' | 'data' | 'it-support' | 'business'> = {
  '1': 'cloud', '143': 'cloud', '169': 'cloud', '170': 'cloud', '172': 'cloud', '187': 'cloud', '194': 'cloud', '239': 'cloud', '254': 'cloud', '257': 'cloud',
  '168': 'security', '177': 'security', '198': 'security', '205': 'security', '253': 'security', '259': 'security',
  '166': 'networking', '174': 'networking', '180': 'networking', '182': 'networking', '195': 'networking', '204': 'networking', '208': 'networking', '255': 'networking',
  '181': 'it-support', '183': 'it-support', '190': 'it-support', '238': 'it-support', '256': 'it-support',
  '185': 'business', '196': 'business', '258': 'data',
};
