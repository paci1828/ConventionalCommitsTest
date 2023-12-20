#!/bin/bash

# Esegui standard-version per incrementare la versione e generare il changelog
standard-version -a --commit-all --releaseCommitMessageFormat "chore(release): %s"

# Estrai la versione appena generata dal package.json
new_version=$(awk -F'"' '/"version":/ {print $4}' package.json)

# Rimuovi le sezioni indesiderate dal changelog
awk '/^## / {if (++n == 1) print $0; next} /^# Changelog/ {n=0} /^All notable changes/ {n=0} !n {print $0}' CHANGELOG.md > tmp_changelog.md

# Controlla se ci sono versioni con features, bug fix o refactoring
if [[ "$(cat tmp_changelog.md)" =~ ^##\ $new_version.*\n\ \*\*\[.*\]\*\*.*$ ]]; then
  # Sovrascrivi il changelog originale con quello aggiornato
  mv tmp_changelog.md CHANGELOG.md

  # Fai il commit del changelog aggiornato
  git add CHANGELOG.md
  git commit -m "chore(release): aggiorna changelog per la versione $new_version"
else
  echo "Nessun aggiornamento significativo per la versione $new_version."
  rm tmp_changelog.md
fi
