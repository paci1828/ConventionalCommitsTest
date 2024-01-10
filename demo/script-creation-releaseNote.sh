#!/bin/bash

# Installa conventional-changelog globalmente se non è già installato
#npm install -g conventional-changelog-cli

# Indicato  il percorso completo del  changelog e della release note
changelog_file="/C/Users/simone.pacileo/Documents/ConventionalCommitsTest/demo/CHANGELOG.md"
release_note_file="/C/Users/simone.pacileo/Documents/ConventionalCommitsTest/demo/RELEASE_NOTE"

# Crea il file RELEASE_NOTE se non esiste già
if [ ! -f "$release_note_file" ]; then
  touch "$release_note_file"
  cat $changelog_file > $release_note_file
else

  # Se il file esiste già, rimuovi le prime righe già presenti e aggiungi il nuovo contenuto del changelog
  sed -i -e "/##/,\$d" "$release_note_file"
  cat "$changelog_file" >> "$release_note_file"
#tail -n +$(grep -n '##' "$changelog_file" | head -n 1 | cut -d: -f1) "$changelog_file" >> "$release_note_file"fi

fi
# Crea una nuova release note utilizzando conventional-changelog
#conventional-changelog -p angular -i "$changelog_file" -s -r 0 -n "$release_note_file"

# Aggiungi manualmente l'estensione .md al file di output
mv "$release_note_file" "$release_note_file.md"

echo "Release note generata con successo e salvata in $release_note_file.md"
