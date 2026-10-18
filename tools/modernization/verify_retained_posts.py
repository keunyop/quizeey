"""Verify the existing owner-private archives without copying or printing user text."""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import subprocess


ROOT = Path(__file__).resolve().parents[2]
DOCS = ROOT / 'docs/modernization'


def sha256(path):
    digest = hashlib.sha256()
    with path.open('rb') as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b''):
            digest.update(chunk)
    return digest.hexdigest()


def main():
    snapshot = json.loads((DOCS / 'source-snapshot-evidence.json').read_text(encoding='utf-8'))
    native = json.loads((DOCS / 'native-explanation-evidence.json').read_text(encoding='utf-8'))
    publication = json.loads((DOCS / 'publication-candidate-evidence.json').read_text(encoding='utf-8'))
    directory = (ROOT / snapshot['privatePath']).resolve(strict=True)
    if not directory.is_relative_to((ROOT / '.modernization/exports').resolve(strict=True)):
        raise ValueError('Unexpected private archive location')
    if os.name == 'nt':
        script = ('$a=Get-Acl -LiteralPath $env:QUIZEEY_RETAINED_ARCHIVE_PATH; '
                  '$s=[System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value; '
                  'if(-not $a.AreAccessRulesProtected -or $a.GetOwner([System.Security.Principal.SecurityIdentifier]).Value -ne $s){exit 3}; '
                  'foreach($r in $a.GetAccessRules($true,$true,[System.Security.Principal.SecurityIdentifier])){if($r.IdentityReference.Value -ne $s){exit 4}}')
        acl = subprocess.run(['powershell.exe', '-NoProfile', '-Command', script], capture_output=True,
                             creationflags=subprocess.CREATE_NO_WINDOW,
                             env={**os.environ, 'QUIZEEY_RETAINED_ARCHIVE_PATH': str(directory)})
        if acl.returncode:
            raise ValueError('Owner-only private directory ACL verification failed')
    elif directory.stat().st_mode & 0o077:
        raise ValueError('Owner-only private directory permissions required')
    candidates = [p for p in directory.iterdir() if p.is_file() and not p.is_symlink()
                  and p.stat().st_size == snapshot['snapshotBytes']]
    if not any(sha256(p) == snapshot['snapshotSha256'] for p in candidates):
        raise ValueError('Original snapshot integrity check failed')
    filtered = directory / 'new-service-dataset.json'
    policy = json.loads((directory / 'publication-candidate-plan.json').read_text(encoding='utf-8'))
    if sha256(filtered) != policy['newServiceDatasetSha256']:
        raise ValueError('Retained filtered snapshot integrity check failed')
    posts = json.loads(filtered.read_bytes())['explanation']
    semantic_hash = hashlib.sha256(json.dumps(posts, ensure_ascii=False, sort_keys=True,
                                  separators=(',', ':')).encode('utf-8')).hexdigest()
    if len(posts) != 2183 or semantic_hash != publication['tables']['explanation']['sha256']:
        raise ValueError('Retained post count or values changed')
    native_directory = (ROOT / native['privatePath']).resolve(strict=True)
    if not native_directory.is_relative_to(directory):
        raise ValueError('Unexpected private rehearsal location')
    native_dump = native_directory / 'native.dump'
    if native_dump.is_symlink() or not native_dump.is_file():
        raise ValueError('Retained native backup missing')
    with native_dump.open('rb') as stream:
        if stream.read(5) != b'PGDMP':
            raise ValueError('Retained native backup format mismatch')
    result = {
        'checkedAt': datetime.now(timezone.utc).isoformat(),
        'policy': 'Retain privately; forum design and publication deferred beyond this cutover',
        'originalSnapshotSha256Matched': True,
        'ownerOnlyDirectoryPermissionsVerified': True,
        'originalSnapshotUtc': snapshot['snapshotUtc'],
        'originalUserPostsPreserved': snapshot['tables']['explanation'],
        'filteredSnapshotSha256Matched': True,
        'filteredUserPosts': len(posts),
        'filteredUserPostValuesSha256Matched': True,
        'postsAssociatedWithExcludedQuestionsStillInOriginal': snapshot['tables']['explanation'] - len(posts),
        'existingNativeRehearsalDirectoryPresent': True,
        'existingNativeBackupPresent': True,
        'nativeBackupSha256': sha256(native_dump),
        'sourceFilesModified': False,
        'newCopiesOrExternalUploads': False,
        'userTextOrDisplayNamesPrinted': False,
        'limit': 'Point-in-time development archive; final cutover archive must retain subsequent user writes too',
    }
    (DOCS / 'retained-user-posts-evidence.json').write_text(json.dumps(result, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(result))


if __name__ == '__main__':
    main()
