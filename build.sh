#!/bin/sh
# يبني index.html المستقل من portfolio.html (مصدر الـArtifact)
set -e
cd "$(dirname "$0")"
python3 - <<'PY'
s=open('portfolio-editorial.html',encoding='utf-8').read()
i=s.index('</style>')+len('</style>')
out='<!doctype html>\n<html lang="ar" dir="rtl">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'+s[:i]+'\n</head>\n<body>\n'+s[i:].lstrip()+'\n</body>\n</html>\n'
open('index.html','w',encoding='utf-8').write(out)
print('built index.html')
PY
