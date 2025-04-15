#!/bin/bash

# Ruft alle verfügbaren Updates (Repo + AUR) ab
updates=$(yay -Qu 2> /dev/null | wc -l)

# Ausgabe für die Statusleiste
echo " Updates: $updates"