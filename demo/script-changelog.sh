#!/bin/bash

#     npm install -g commitizen
# Verifica se CHANGELOG.md esiste, altrimenti crea uno scheletro del changelog
if [ ! -f CHANGELOG.md ]; then
    echo "# Changelog" > CHANGELOG.md
fi

# Esegui commitizen per creare un nuovo commit interattivo
git-cz

# Incrementa la versione del changelog
current_version=$(grep -E '^##\s[0-9]+\.[0-9]+\.[0-9]+' CHANGELOG.md | head -n 1 | awk '{print $2}')
if [ -z "$current_version" ]; then
    # Se non c'è ancora una versione, assegnala manualmente
    current_version="0.1.0"
fi

# Incrementa la versione nel changelog
new_version=$(echo $current_version | awk -F. '{$NF++; OFS="."; print $0}')

# Aggiorna il changelog con la nuova versione
sed -i "s/^# Changelog/# Changelog\n\n## $new_version/" CHANGELOG.md

# Fai il commit del changelog aggiornato
git add CHANGELOG.md
git commit -m "chore(release): aggiorna changelog per la versione $new_version"

echo "Changelog aggiornato alla versione $new_version."
