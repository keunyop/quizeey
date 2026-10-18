// Build a local, explicit code/sample upload candidate. This script never uploads.
import fs from 'node:fs';
import path from 'node:path';
import { createHash } from 'node:crypto';
import { fileURLToPath } from 'node:url';

const root=fileURLToPath(new URL('../../',import.meta.url));
const args=process.argv.slice(2);
if(args.some(arg=>!['--supabase','--candidate','--production-review','--production-release'].includes(arg)))throw new Error('Unexpected preview packaging argument');
const contentSource=process.argv.includes('--supabase')?'supabase':'fixture';
const productionReview=args.includes('--production-review');
const productionRelease=args.includes('--production-release');
if((productionReview||productionRelease)&&(contentSource!=='supabase'||args.includes('--candidate')||(productionReview&&productionRelease)))throw new Error('Production packaging requires Supabase and its own package');
// Preserve the evidence and payload used for the previously verified deployment.
const candidate=args.includes('--candidate');
const web=path.join(root,'web');
const allowedFiles=['package.json','package-lock.json','tsconfig.json','next-env.d.ts','next.config.ts','postcss.config.mjs','vercel.json',
  'fixtures/legacy-contract.json','fixtures/legacy-pages.json','scripts/preflight-production.ts'];
const names=[...allowedFiles];
for(const directory of ['src','public']) {
  for(const name of fs.readdirSync(path.join(web,directory),{recursive:true})) {
    const relative=path.posix.join(directory,name.replaceAll('\\','/'));
    const file=path.join(web,relative);
    if(fs.lstatSync(file).isSymbolicLink())throw new Error('Upload symlink refused');
    if(!fs.statSync(file).isFile()||/\.(test|spec)\./.test(relative))continue;
    if(!/\.(ts|tsx|css|svg|png|ico|woff2|html|txt)$/.test(relative))throw new Error('Unexpected code/public file type');
    names.push(relative);
  }
}
const files=[];
const inventory=[];
for(const relative of names.sort()) {
  const full=fs.realpathSync(path.join(web,relative));
  if(!full.startsWith(fs.realpathSync(web)+path.sep)||/(^|\/)(\.env|\.modernization|node_modules|\.next|\.git)(\/|\.|$)/.test(relative))throw new Error('Forbidden upload path');
  const bytes=fs.readFileSync(full);
  files.push({file:'web/'+relative,data:bytes.toString('base64'),encoding:'base64'});
  inventory.push({file:'web/'+relative,bytes:bytes.length,sha256:createHash('sha256').update(bytes).digest('hex')});
}
const out=path.join(root,'.modernization',productionRelease?'vercel-production-release':productionReview?'vercel-production-review':candidate?'vercel-preview-candidate':'vercel-preview');
fs.mkdirSync(out,{recursive:true});
const payload=JSON.stringify(files);
fs.writeFileSync(path.join(out,'files.json'),payload);
const manifest={recordedAt:new Date().toISOString(),status:'prepared-not-uploaded',
  teamId:'team_VSzA796D92aso5IuzUIiOdnb',projectId:'prj_0SVBqfgurtvZErmpMJl01BJkUKOd',
  target:productionReview||productionRelease?'production':'preview',apiTarget:productionReview||productionRelease?'production':'staging',rootDirectory:'web',contentSource,
  productionReview,releaseReady:productionRelease,automaticCustomDomainAssignmentRequested:false,
  fileCount:files.length,totalBytes:inventory.reduce((total,file)=>total+file.bytes,0),
  payloadSha256:createHash('sha256').update(payload).digest('hex'),
  privateExportsIncluded:false,environmentFilesIncluded:false,gitConnectionRequested:false,
  sampleQuestionsInSource:4,fixtureServingEnabled:contentSource==='fixture',actualArchiveFilesIncluded:false,
  forumAndAdminEnabled:false,adsAndAnalyticsEnabled:productionRelease,files:inventory};
fs.writeFileSync(path.join(root,'docs/modernization',productionRelease?'production-release-package-evidence.json':productionReview?'production-review-package-evidence.json':candidate?'cutover-preview-package-evidence.json':'preview-package-evidence.json'),JSON.stringify(manifest,null,2)+'\n');
console.log(JSON.stringify({fileCount:manifest.fileCount,totalBytes:manifest.totalBytes,payloadSha256:manifest.payloadSha256,uploaded:false}));
