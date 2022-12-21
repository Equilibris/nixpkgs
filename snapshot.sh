git reset HEAD -- */**/*.pdf
git add .
git commit -m "Snapshot $(date -Iminutes)"
timeout 10 git push

