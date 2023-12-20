#!/bin/bash

# Conta il numero di commit con feat, fix o refactor nella storia
count=$(git log --pretty=format:%s | grep -E '^\s*\*\*\[(feat|fix|refactor)\]' | wc -l)

if [ $count -gt 0 ]; then
  # Esegui standard-version per incrementare la versione e generare il changelog
  standard-version -a --commit-all --releaseCommitMessageFormat "chore(release): %s"

  # Estrai la versione appena generata dal package.json
  new_version=$(jq -r '.version' package.json)

  # Rimuovi le sezioni indesiderate dal changelog
  awk '/^## / {if (++n == 1) print $0; next} /^# Changelog/ {n=0} /^All notable changes/ {n=0} !n {print $0}' CHANGELOG.md > tmp_changelog.md

  # Sovrascrivi il changelog originale con quello aggiornato solo se ci sono aggiornamenti significativi
  if [[ "$(grep -E '^(\s*\*\*\[feat\]|(\s*\*\*\[fix\]|\s*\*\*\[refactor\]))' tmp_changelog.md)" ]]; then
    mv tmp_changelog.md CHANGELOG.md

    # Fai il commit del changelog aggiornato
    git add CHANGELOG.md
    git commit -m "chore(release): aggiorna changelog per la versione $new_version"
  else
    echo "Nessun aggiornamento significativo rilevato. La versione rimane invariata."
    rm tmp_changelog.md
  fi
else
  echo "Nessun commit rilevante per l'auto-incremento del changelog. La versione rimane invariata."
fi
