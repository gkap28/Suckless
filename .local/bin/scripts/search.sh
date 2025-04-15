#!/usr/bin/env bash
#
## Created By: Jake@Linux
# Created On: Fri 02 Jun 2023 01:13:18 PM CDT
# # Project: launch menu

# Setze die gewünschte Schriftart und -größe sowie die Farbe und Grenzstile
export FZF_DEFAULT_OPTS="--color='fg:104,fg+:255,pointer:31,hl:255,hl+:12,header:12,prompt:255' --height 100% --reverse --header='' --border=rounded --margin=5%"

#mpv --no-video --no-terminal ~/Media/soundClips/launch2.mp3 2>/dev/null &
sleep .15
DIR1="/usr/bin/"
DIR2="/home/georg/.local/scripts/bin/"

# Alle ausführbaren Dateien in den angegebenen Verzeichnissen auflisten und im Launcher-Menü anzeigen
Menu=$(ls "$DIR1" "$DIR2" | fzf --prompt="Which Program Would You Like To Run : " --header="PROGRAMS")

# Die ausgewählte Anwendung ausführen
if [ -n "$Menu" ]; then
    exec devour "$Menu"
fi
