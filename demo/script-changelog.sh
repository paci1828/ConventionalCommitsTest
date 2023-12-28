#!/bin/bash

# Importa la libreria commitizen
source "$(dirname "$0")/commitizen"

# Determina la versione corrente del changelog
# shellcheck disable=SC2002
current_version=$(cat CHANGELOG.md | grep "^## Version" | awk '{print $2}')

# Controlla se sono stati effettuati dei commit
if [ "$(git log --oneline | wc -l)" -gt 0 ]; then

    # Genera il nuovo changelog
    new_changelog=$(cz generate)

    # Aggiorna la versione del changelog
    new_version=$(echo "$new_changelog" | grep "^## Version" | awk '{print $2}')

    # Controlla se la versione è cambiata
    if [ "$new_version" != "$current_version" ]; then

        # Scrivi il nuovo changelog
        echo "$new_changelog" > CHANGELOG.md

        # Aggiorna la versione corrente
        current_version="$new_version"

    fi

fi

# Stampa la versione corrente del changelog
echo "Versione corrente del changelog: $current_version"