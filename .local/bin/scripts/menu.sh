#!/usr/bin/env bash

# Funktion zur Anpassung der Schriftart und -größe sowie der Farbe und Grenzstile für Fzf
fzf_with_font() {
    # Verwenden Sie xterm, um die Schriftart und -größe anzupassen
    FZF_PREVIEW_COMMAND="xterm -fa 'Fantasque Sans Mono:size=12' -e cat {}" fzf "$@"
}

# Funktion zum Zurückkehren zum Hauptmenü
return_to_menu() {
    read -p "Drücke Enter, um zum Hauptmenü zurückzukehren..."
}

# Funktion zur Installation von Paketen mit yay
install_with_yay() {
    package="$1"
    yay -S "$package"
}

# Funktion zur Installation von Paketen mit pacman
install_with_pacman() {
    package="$1"
    sudo pacman -S "$package"
}

# Funktion zur Suche nach Dateien und Ordnern
search_files_and_folders() {
    read -p "Enter search term: " search_term
    echo "Searching for files and folders matching '$search_term':"
    # Suche mit find
    find_results=$(find / -type f -iname "*$search_term*" 2>/dev/null)
    if [ -n "$find_results" ]; then
        echo "Results found:"
        echo "$find_results"
    else
        echo "No results found."
    fi
}

# Funktion zum Entfernen von Anwendungen
remove_apps() {
    read -p "Enter program name: " program_name
    echo "Searching for program '$program_name'..."

    # Suche nach dem Programm mit 'find'
    program_paths=$(find / -type f -iname "*$program_name*" 2>/dev/null)

    if [ -n "$program_paths" ]; then
        echo "Program found at the following locations:"
        echo "$program_paths"
        
        read -p "Do you want to completely remove this program? (Y/n): " confirm
        confirm=${confirm:-Y}

        if [ "$confirm" == "Y" ] || [ "$confirm" == "y" ]; then
            echo "Removing program '$program_name' from the following locations:"
            echo "$program_paths"
            sudo rm -rf $program_paths
            echo "Program '$program_name' removed."
        else
            echo "Removal canceled."
        fi
    else
        echo "Program not found."
    fi
}

# Hauptmenüfunktion
main_menu() {
    # Setze die gewünschte Farbe und Grenzstile für Fzf
    export FZF_DEFAULT_OPTS="--color='fg:255,fg+:255,pointer:31,hl:255,hl+:12,header:12,prompt:255' --height 100% --reverse --header='' --border=rounded --margin=5%"

    # Optionen für das Menü
    options=("Install with yay" "Install with pacman" "Update System" "Remove Apps" "Search File and Folder" "Fix Arch Linux Keys" "Reflector Change German Mirrors" "Quit")

    while true; do
        # Fzf-Menü anzeigen
        selected_option=$(printf '%s\n' "${options[@]}" | fzf_with_font)

        # Aktionen basierend auf der Auswahl ausführen
        case $selected_option in
            "Install with yay")
                read -p "Enter package name: " package_name
                install_with_yay "$package_name"
                return_to_menu
                ;;
            "Install with pacman")
                read -p "Enter package name: " package_name
                install_with_pacman "$package_name"
                return_to_menu
                ;;
            "Update System")
                sudo pacman -Syu
                return_to_menu
                ;;
            "Remove Apps")
                remove_apps
                return_to_menu
                ;;
            "Search File and Folder")
                search_files_and_folders
                return_to_menu
                ;;
            "Fix Arch Linux Keys")
                sudo pacman-key --init
                sudo pacman-key --populate archlinux
                return_to_menu
                ;;
            "Reflector Change German Mirrors")
                sudo reflector --country 'Germany' --latest 10 --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
                return_to_menu
                ;;
            "Quit")
                exit 0
                ;;
            *)
                echo "Ungültige Option ausgewählt"
                ;;
        esac
    done
}

# Hauptmenü aufrufen
main_menu
