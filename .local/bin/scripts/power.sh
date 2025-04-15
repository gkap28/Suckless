#!/bin/bash

# Setze die gewünschte Schriftart und -größe sowie die Farbe und Grenzstile
export FZF_DEFAULT_OPTS="--color='fg:255,bg:-1,hl:255,fg+:255,bg+:21,hl+:51,info:37,spinner:33' --height 100% --reverse --header='' --border='rounded' --margin=5% --prompt='>>>' --preview-window='right:0%' --preview='cat {}'"

# Optionen für das Menü
options=("1. Reboot" "2. Poweroff" "3. Logout" "4. Lock" "5. Exit")

# Fzf-Menü anzeigen
selected_option=$(printf '%s\n' "${options[@]}" | fzf)

# Aktionen basierend auf der Auswahl ausführen
case $selected_option in
    "1. Reboot")
        systemctl reboot
        ;;
    "2. Poweroff")
        systemctl poweroff
        ;;
    "3. Logout")
        pkill -KILL -u "$USER"
        ;;
    "4. Lock")
        # Hier kannst du den Befehl zum Sperren des Bildschirms einfügen
        ;;
    "5. Exit")
        exit 0
        ;;
    *)
        echo "Ungültige Option ausgewählt"
        ;;
esac
