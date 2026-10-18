"""Prepare a PRIVATE, unapproved publication candidate plan; never publish/repair.

Structural eligibility is not content approval, language/rights review, or launch
authorization. Every original row remains in the approved raw/typed archive.
"""
import argparse
from collections import Counter, defaultdict
import hashlib
import json
from pathlib import Path

from audit import ROOT, TABLES, audit, can_stage_losslessly, digest


def candidate_plan(data):
    report, rows = audit(data)
    if not can_stage_losslessly(report): raise ValueError('Source cannot be preserved losslessly')
    reasons = defaultdict(set)
    question_keys = defaultdict(list)
    for row in rows['question']:
        question_keys[tuple(str(row[k]) for k in ['test_id','ver_nbr','quest_nbr'])].append(row['quest_id'])
    examples = {r['exmp_id']:r for r in rows['example']}
    for error in report['errors']:
        table, issue = error['table'], error['issue']
        if table == 'question':
            if 'id' in error: reasons[error['id']].add(issue)
            elif 'key' in error:
                for id_ in question_keys[tuple(error['key'])]: reasons[id_].add(issue)
        elif table == 'example':
            key = (tuple(error['key'][:3]) if 'key' in error else
                   tuple(str(examples[error['id']][k]) for k in ['test_id','ver_nbr','quest_nbr']))
            for id_ in question_keys.get(key,[]): reasons[id_].add('choice_' + issue)
        elif table == 'version' and 'key' in error:
            for key, ids in question_keys.items():
                if key[:2] == tuple(error['key']):
                    for id_ in ids: reasons[id_].add('version_' + issue)
        elif table == 'question_stats' and error.get('id') in {r['quest_id'] for r in rows['question']}:
            reasons[error['id']].add('counter_' + issue)
    eligible = {r['quest_id'] for r in rows['question']} - set(reasons)
    eligible_keys = {key for key, ids in question_keys.items() if len(ids)==1 and ids[0] in eligible}
    test_ids = {r['test_id'] for r in rows['test']}
    version_counts = Counter((r['test_id'],r['ver_nbr']) for r in rows['version'])
    candidates = {
        'test': rows['test'],
        'version': [r for r in rows['version'] if r['test_id'] in test_ids and version_counts[(r['test_id'],r['ver_nbr'])]==1],
        'question': [r for r in rows['question'] if r['quest_id'] in eligible],
        'example': [r for r in rows['example'] if tuple(str(r[k]) for k in ['test_id','ver_nbr','quest_nbr']) in eligible_keys],
        'explanation': [r for r in rows['explanation'] if r['quest_id'] in eligible],
        'question_stats': [r for r in rows['question_stats'] if r['quest_id'] in eligible],
    }
    checked, _ = audit(candidates)
    if checked['errors']: raise ValueError('Candidate subset still has unresolved structural errors')
    reasons = {id_:sorted(values) for id_,values in sorted(reasons.items())}
    by_exam = Counter(r['test_id'] for r in candidates['question'])
    plan = {'schema':1, 'status':'proposal_only', 'publicationAllowed':False, 'ownerPolicyApproved':False,
            'sourceQuestionCount': len(rows['question']), 'structurallyEligibleQuestions':len(eligible),
            'reviewPendingQuestions':len(reasons), 'reasonCountsOverlapping':dict(Counter(reason for values in reasons.values() for reason in values)),
            'examCountWithCandidates':len(by_exam), 'tables':checked['tables'],
            'retainedSourceCounts':{table:len(items) for table,items in rows.items()},
            'candidateSubsetCounts':{table:len(items) for table,items in candidates.items()},
            'excludedFromCandidateCounts':{table:len(rows[table])-len(candidates[table]) for table in TABLES},
            'candidateReconciliationStatus':checked['status'], 'candidateReconciliationSha256':digest(checked),
            'originalRowsDeleted':0, 'originalIdsReassigned':0,
            'policyProposal':'Keep all original raw/typed rows; withhold unresolved questions from practice/grading; preserve original-ID review/unavailable responses. No production routing policy is approved.',
            'remainingGates':['Owner exception policy','Source HTML preservation/security','Locale and content rights','Legacy catalog/route conflicts','Hosted account/security','Launch and final delta approval']}
    plan['reviewQuestionIdSetSha256']=digest(sorted(reasons))
    return plan, {'questionReasons':reasons,'eligibleQuestionIds':sorted(eligible),'eligibleQuestionsByExam':dict(by_exam)}, candidates


def apply_new_service_deletion(data, approved_count, approved_id_hash):
    plan, details, candidates=candidate_plan(data)
    ids=set(details['questionReasons'])
    if len(ids)!=approved_count or digest(sorted(ids))!=approved_id_hash:
        raise ValueError('Deletion set differs from the reviewed owner-approved set')
    removed_keys={tuple(str(r[k]) for k in ['test_id','ver_nbr','quest_nbr']) for r in data['question'] if r['quest_id'] in ids}
    retained_keys={tuple(str(r[k]) for k in ['test_id','ver_nbr','quest_nbr']) for r in candidates['question']}
    if removed_keys & retained_keys:raise ValueError('Choice key would affect a retained question')
    tied_counts={'question':len(ids),
                 'example':sum(tuple(str(r[k]) for k in ['test_id','ver_nbr','quest_nbr']) in removed_keys for r in data['example']),
                 'explanation':sum(r['quest_id'] in ids for r in data['explanation']),
                 'question_stats':sum(r['quest_id'] in ids for r in data['question_stats'])}
    plan.update(status='owner_approved_new_service_exclusion',ownerPolicyApproved=True,
                deletionScope='New service migration dataset only; source MySQL and original backups retained',
                removedQuestionsFromNewDataset=len(ids),reviewPendingQuestions=0,reviewedIssueQuestions=len(ids),relatedRowsExcluded=tied_counts,
                unrelatedUnlinkedRowsPreservedPrivately={table:plan['excludedFromCandidateCounts'][table]-tied_counts.get(table,0) for table in TABLES},
                policyProposal='Owner confirmed deletion from new service migration dataset; no review placeholders. Original archive unchanged.',
                remainingGates=[gate for gate in plan['remainingGates'] if gate!='Owner exception policy'])
    return plan,details,candidates


def main():
    parser=argparse.ArgumentParser();parser.add_argument('snapshot',type=Path)
    parser.add_argument('--approved-delete-count',type=int)
    parser.add_argument('--approved-question-set-sha256')
    args=parser.parse_args()
    if (args.approved_delete_count is None)!=(args.approved_question_set_sha256 is None):parser.error('Both reviewed deletion guards are required')
    source=args.snapshot.resolve()
    if not source.is_relative_to((ROOT/'.modernization/exports').resolve()):parser.error('Private approved snapshot directory required')
    evidence=json.loads((source/'snapshot-evidence.json').read_text(encoding='utf-8'))
    with (source/'normalized.json').open('rb') as stream:
        if hashlib.file_digest(stream,'sha256').hexdigest()!=evidence['normalizedSha256']:raise ValueError('Snapshot hash changed')
    data=json.loads((source/'normalized.json').read_text(encoding='utf-8'))
    if args.approved_delete_count is None:
        plan, details, candidates=candidate_plan(data)
    else:
        plan, details, candidates=apply_new_service_deletion(data,args.approved_delete_count,args.approved_question_set_sha256)
        payload=json.dumps(candidates,ensure_ascii=False,separators=(',',':')).encode('utf-8')
        (source/'new-service-dataset.json').write_bytes(payload)
        plan['newServiceDatasetSha256']=hashlib.sha256(payload).hexdigest()
        (source/'new-service-deleted-question-ids.json').write_text(json.dumps(sorted(details['questionReasons']),indent=2)+'\n',encoding='utf-8')
    plan['sourceSnapshotSha256']=evidence['snapshotSha256']
    (source/'publication-candidate-plan.json').write_text(json.dumps({**plan,**details},indent=2)+'\n',encoding='utf-8')
    (ROOT/'docs/modernization/publication-candidate-evidence.json').write_text(json.dumps(plan,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(plan,indent=2))


if __name__=='__main__':
    try:main()
    except Exception as error:raise SystemExit('Private candidate plan failed ('+type(error).__name__+'); source content not printed.')
