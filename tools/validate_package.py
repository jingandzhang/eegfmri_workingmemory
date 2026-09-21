"""Static integrity checks only; never executes research analyses."""
from pathlib import Path
import ast
import hashlib
import json
import sys

root = Path(__file__).resolve().parents[1]
errors = []
counts = dict(manifest_files=0, python_files=0, notebooks=0, notebook_code_cells=0)
for entry in json.loads((root / 'docs/source-manifest.json').read_text(encoding='utf-8')):
    path = root / entry['destination']
    counts['manifest_files'] += 1
    if not path.is_file():
        errors.append('Missing: ' + entry['destination'])
    elif hashlib.sha256(path.read_bytes()).hexdigest() != entry['packaged_sha256']:
        errors.append('Checksum changed: ' + entry['destination'])
for path in root.rglob('*.py'):
    counts['python_files'] += 1
    try:
        ast.parse(path.read_text(encoding='utf-8-sig'), filename=str(path))
    except (SyntaxError, UnicodeError) as exc:
        errors.append(f'{path.relative_to(root)}: {exc}')
for path in root.rglob('*.ipynb'):
    counts['notebooks'] += 1
    nb = json.loads(path.read_text(encoding='utf-8'))
    for number, cell in enumerate(nb['cells'], 1):
        if cell['cell_type'] != 'code':
            continue
        counts['notebook_code_cells'] += 1
        if cell.get('outputs') or cell.get('execution_count') is not None:
            errors.append(f'{path.name}, cell {number}: saved output/count')
        code = ''.join(cell.get('source', []))
        try:
            ast.parse(code)
        except SyntaxError as exc:
            errors.append(f'{path.name}, cell {number}: {exc}')
for name in ['RUN.m', 'WM_v5.m', 'Generate_seq.m', 'Intro.txt']:
    if not (root / 'task/working_memory' / name).is_file():
        errors.append('Missing task dependency: ' + name)
print(json.dumps({'checks': counts, 'errors': errors,
    'scope': 'Static package checks only; no MATLAB, EEG, MRI, statistics, or GUI execution.'}, indent=2))
sys.exit(1 if errors else 0)
