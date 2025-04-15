#!/bin/bash

# Funktion zur Anzeige der Kopfzeile
show_header() {
    clear
    echo "*******************************"
    echo "*          Hauptmenü          *"
    echo "*******************************"
    echo "1. Pakete aktualisieren"
    echo "2. Pakete installieren"
    echo "3. Datei suchen"
    echo "4. Datei entfernen"
    echo "5. Repository durchsuchen"
    echo "6. Beenden"
    echo "*******************************"
}

# Funktion zum Aktualisieren des Systems
update_system() {
    sudo xbps-install -Suv
}

# Funktion zum Installieren von Paketen
install_packages() {
    read -p "Geben Sie den Namen des Pakets ein, das Sie installieren möchten: " package
    sudo xbps-install -S "$package"
}

# Funktion zum Suchen nach einer Datei
search_file() {
    read -p "Geben Sie den Dateinamen ein, den Sie suchen möchten: " filename
    echo "Suchergebnisse für '$filename':"
    sudo find / -type f -name "$filename"
}

# Funktion zum Entfernen einer Datei
remove_file() {
    read -p "Geben Sie den vollständigen Pfad zur zu löschenden Datei ein: " filepath
    sudo rm -rf "$filepath"
    echo "Datei erfolgreich entfernt."
}

# Funktion zum Durchsuchen des Repositorys
search_repository() {
    read -p "Geben Sie den Suchbegriff für das Repository ein: " searchterm
    xbps-query -Rs "$searchterm"
}

# Hauptfunktion, um das Menü anzuzeigen und Benutzeraktionen zu verarbeiten
main() {
    while true; do
        show_header
        read -p "Bitte wählen Sie eine Option (1-6): " choice
        case $choice in
            1) update_system ;;
            2) install_packages ;;
            3) search_file ;;
            4) remove_file ;;
            5) search_repository ;;
            6) echo "Auf Wiedersehen!"; exit ;;
            *) echo "Ungültige Eingabe. Bitte wählen Sie eine Zahl von 1 bis 6." ;;
        esac
        read -p "Drücken Sie Enter, um fortzufahren..."
    done
}

# Hauptprogramm starten
main
