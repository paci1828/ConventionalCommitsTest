#!/bin/bash


# Controlla se ci sono file modificati
if git diff-index --quiet HEAD --; then
    echo "Non ci sono file modificati."
else
    # Aggiungi tutti i file modificati al tuo commit
    git add .
git cz;
    # Esegui il commit utilizzando Commitizen
#    if git cz; then
#        echo "Commit eseguito con successo."
#    else
#        echo "Errore durante l'esecuzione del commit."
#        exit 1
#    fi
#
#    # Pusha il tuo commit al tuo repository remoto
#    if git push; then
#        echo "Push eseguito con successo."
#    else
#        echo "Errore durante l'esecuzione del push."
#        exit 1
#    fi

#    # Genera il changelog
#    if git cz ch; then
#        echo "Changelog generato con successo."
#    else
#        echo "Errore durante la generazione del changelog."
#        exit 1
#    fi
fi
