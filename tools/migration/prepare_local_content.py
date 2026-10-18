"""Prepare an owner-private read-only app artifact from the approved dataset."""
import argparse
import hashlib
import json
from pathlib import Path
from audit import ROOT, canonical, digest
from content_etl import transform, summaries


def main():
    parser=argparse.ArgumentParser();parser.add_argument('snapshot',type=Path);args=parser.parse_args()
    source=args.snapshot.resolve()
    if not source.is_relative_to((ROOT/'.modernization/exports').resolve()):parser.error('Private approved snapshot required')
    policy=json.loads((source/'publication-candidate-plan.json').read_text(encoding='utf-8'))
    if policy.get('status')!='owner_approved_new_service_exclusion' or not policy.get('ownerPolicyApproved'):raise ValueError('Approved deletion policy required')
    raw=(source/'new-service-dataset.json').read_bytes()
    if hashlib.sha256(raw).hexdigest()!=policy['newServiceDatasetSha256']:raise ValueError('Dataset hash changed')
    data=json.loads(raw)
    deleted=json.loads((source/'new-service-deleted-question-ids.json').read_text(encoding='utf-8'))
    if len(deleted)!=751 or digest(deleted)!=policy['reviewQuestionIdSetSha256']:raise ValueError('Deletion scope changed')
    if set(deleted)&{r['quest_id'] for r in data['question']}:raise ValueError('Removed question remains')
    schema=json.loads((ROOT/'tools/migration/verified_schema.json').read_text(encoding='utf-8'))
    target=transform(data,schema)
    # Include counts only, never source author names or unpublished forum bodies.
    counts={}
    for row in data['explanation']:counts[row['quest_id']]=counts.get(row['quest_id'],0)+1
    payload=canonical({'schema':1,'tables':target,'pendingExplanationCounts':counts}).encode('utf-8')
    (source/'local-content.json').write_bytes(payload)
    manifest={'schema':1,'status':'owner_approved_filtered_local_review',
              'sourceSnapshotSha256':policy['sourceSnapshotSha256'],'newServiceDatasetSha256':policy['newServiceDatasetSha256'],
              'contentSha256':hashlib.sha256(payload).hexdigest(),'deletedQuestionCount':751,
              'deletedQuestionIdSetSha256':policy['reviewQuestionIdSetSha256'],'tables':summaries(target),
              'sourceAuthorNamesIncluded':False,'nativePostBodiesIncluded':False,'hostedUseAllowed':False}
    (source/'local-content-manifest.json').write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf-8')
    (ROOT/'docs/modernization/local-content-artifact-evidence.json').write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf-8')
    print('Owner-private app artifact prepared; no source author names/posts, hosted use disabled.')


if __name__=='__main__':
    try:main()
    except Exception as error:raise SystemExit('Private local content preparation failed ('+type(error).__name__+'); source not printed.')
