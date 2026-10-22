#!/bin/sh
# يبني index.html المستقل من portfolio.html (مصدر الـArtifact)
set -e
cd "$(dirname "$0")"
SRC="${1:-portfolio.html}"
{ printf '<!doctype html>\n<html lang="ar" dir="rtl">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1">\n'; cat "$SRC"; printf '\n</html>\n'; } > index.html
python3 - <<'PY'
p='index.html'; s=open(p,encoding='utf-8').read()
s=s.replace('</style>\n\n<div class="page">','</style>\n</head>\n<body>\n<div class="page">',1)
s=s.replace('</script>\n\n</html>','</script>\n</body>\n</html>',1)
open(p,'w',encoding='utf-8').write(s)
assert '</head>' in s and '</body>' in s
PY
echo built index.html
