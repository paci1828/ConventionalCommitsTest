#!/bin/bash

# Percorso del changelog
changelog_file="CHANGELOG.md"

# Esegui auto-changelog per aggiornare il changelog
auto-changelog -p --unreleased --commit-limit false --output $changelog_file

# Aggiungi le modifiche non ancora rilasciate alle release notes (opzionale)
awk '/## Unreleased/{flag=1;next}/## /{flag=0}flag' $changelog_file > RELEASE_NOTES.md

