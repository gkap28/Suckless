#!/bin/bash

# Funktion zur Ermittlung der WLAN-Schnittstelle
get_wlan_interface() {
    ip route | awk '/default/ {print $5; exit}'
}

# Funktion zur Ermittlung der Download-Geschwindigkeit der WLAN-Schnittstelle
get_wlan_download_speed() {
    interface=$(get_wlan_interface)
    rx1=$(cat "/sys/class/net/$interface/statistics/rx_bytes")
    sleep 1
    rx2=$(cat "/sys/class/net/$interface/statistics/rx_bytes")
    echo "$((($rx2 - $rx1) / 1024))"
}

# Funktion zur Ermittlung der Upload-Geschwindigkeit der WLAN-Schnittstelle
get_wlan_upload_speed() {
    interface=$(get_wlan_interface)
    tx1=$(cat "/sys/class/net/$interface/statistics/tx_bytes")
    sleep 1
    tx2=$(cat "/sys/class/net/$interface/statistics/tx_bytes")
    echo "$((($tx2 - $tx1) / 1024))"
}

# Funktion zur Ermittlung der Internetgeschwindigkeit
get_internet_speed() {
    speedtest_result=$(speedtest-cli --simple)
    download_speed=$(echo "$speedtest_result" | awk '/Download/ {print $2}')
    upload_speed=$(echo "$speedtest_result" | awk '/Upload/ {print $2}')
    echo "$download_speed"
    echo "$upload_speed"
}

# Hauptfunktion, die die Geschwindigkeiten anzeigt und dwmblocks startet
main() {
    wlan_download_speed=$(get_wlan_download_speed)
    wlan_upload_speed=$(get_wlan_upload_speed)
    internet_speed=$(get_internet_speed)
    echo "📥  $wlan_download_speed kB/s | 📦 $wlan_upload_speed kB/s | 📥 $internet_speed"
}

main
