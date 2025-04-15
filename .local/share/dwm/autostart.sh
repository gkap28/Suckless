#!/bin/sh

# Monitore konfigurieren
xrandr --output DisplayPort-0 --off \
       --output DisplayPort-1 --off \
       --output DisplayPort-2 --mode 1920x1080 --pos 2560x0 --rotate normal \
       --output HDMI-A-0 --mode 2560x1080 --pos 0x0 --rotate normal

# Mauszeiger setzen
xsetroot -cursor_name left_ptr &

# Hintergrundbild laden
nitrogen --restore &

# Compositor starten (ohne deprecated Optionen)
picom --config ~/.config/picom/picom.conf -b &

# Numlock aktivieren
numlockx on &

# Statusbar starten
dwmblocks &

# Energieverwaltung
xfce4-power-manager &

# PolicyKit-Agent (nur einer reicht)
if [ -x /usr/libexec/polkit-gnome-authentication-agent-1 ]; then
    /usr/libexec/polkit-gnome-authentication-agent-1 &
elif [ -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# Bildschirmschoner und DPMS deaktivieren
xset s off &
xset -dpms &
