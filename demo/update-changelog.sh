#!/bin/bash

# Esegui standard-version per incrementare la versione e generare il changelog
standard-version -a --commit-all --releaseCommitMessageFormat "chore(release): %s"

# Estrai la versione appena generata dal package.json
new_version=$(awk -F'"' '/"version":/ {print $4}' package.json)

# Ottieni le informazioni sul changelog dal file generato
changelog_content=$(cat CHANGELOG.md)

# Scrivi le informazioni nel changelog
echo -e "## $new_version ($(date +"%Y-%m-%d"))\n\n$changelog_content" > CHANGELOG.md

# Fai il commit del changelog aggiornato
git add CHANGELOG.md
git commit -m "chore(release): aggiorna changelog per la versione $new_version"
