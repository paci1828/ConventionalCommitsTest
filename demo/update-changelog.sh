#!/bin/bash

# Verifica se ci sono nuove features, bug fix o refactoring nella storia dei commit
if git log -n 1 --pretty=format:%s | grep -E '^\s*\*\*\[(feat|fix|refactor)\]'; then
  # Esegui standard-version per incrementare la versione e generare il changelog
  standard-version -a --commit-all --releaseCommitMessageFormat "chore(release): %s"

  # Estrai la versione appena generata dal package.json
  new_version=$(jq -r '.version' package.json)

  # Rimuovi le sezioni indesiderate dal changelog
  awk '/^## / {if (++n == 1) print $0; next} /^# Changelog/ {n=0} /^All notable changes/ {n=0} !n {print $0}' CHANGELOG.md > tmp_changelog.md

  # Sovrascrivi il changelog originale con quello aggiornato
  mv tmp_changelog.md CHANGELOG.md

  # Fai il commit del changelog aggiornato
  git add CHANGELOG.md
  git commit -m "chore(release): aggiorna changelog per la versione $new_version"
else
  echo "Nessun aggiornamento significativo rilevato. La versione rimane invariata."
fi
