##!/bin/bash
#
## Esegui standard-version per incrementare la versione e generare il changelog
#standard-version -a --commit-all --releaseCommitMessageFormat "chore(release): %s"
#
## Estrai la versione appena generata dal package.json
#new_version=$(awk -F'"' '/"version":/ {print $4}' package.json)
#
## Ottieni le informazioni sul changelog dal file generato
#changelog_content=$(cat CHANGELOG.md)
#
## Scrivi le informazioni nel changelog
#echo -e "## $new_version ($(date +"%Y-%m-%d"))\n\n$changelog_content" > CHANGELOG.md
#
## Fai il commit del changelog aggiornato
#git add CHANGELOG.md
#git commit -m "chore(release): aggiorna changelog per la versione $new_version"



# Esegui standard-version per incrementare la versione e generare il changelog
standard-version -a --commit-all --releaseCommitMessageFormat "chore(release): %s"

# Estrai la versione appena generata dal package.json
new_version=$(awk -F'"' '/"version":/ {print $4}' package.json)

# Ottieni le informazioni sul changelog dal file generato
changelog_content=$(cat CHANGELOG.md)

# Rimuovi l'intestazione standard
changelog_content=$(echo "$changelog_content" | sed '/^# Changelog$/d' | sed '/All notable changes to this project will be documented in this file. See standard-version for commit guidelines./d')

# Controlla se ci sono versioni con features, bug fix o refactoring
if [[ "$changelog_content" =~ ^##\ $new_version.*\n\ \*\*\[.*\]\*\*.*$ ]]; then
  # Rimuovi la frase standard
  changelog_content=$(echo "$changelog_content" | sed '/All notable changes to this project will be documented in this file. See standard-version for commit guidelines./d')

  # Scrivi le informazioni nel changelog
  echo -e "# Changelog\n\n## $new_version ($(date +"%Y-%m-%d"))\n\n$changelog_content" > CHANGELOG.md

  # Fai il commit del changelog aggiornato
  git add CHANGELOG.md
  git commit -m "chore(release): aggiorna changelog per la versione $new_version"
else
  echo "Nessun aggiornamento significativo per la versione $new_version."
fi
