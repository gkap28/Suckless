#!/bin/bash

# Teil 1 - Festplatten anzeigen und auswählen
lsblk
echo "Wählen Sie die Festplatte aus, auf der Void Linux installiert werden soll (z.B. /dev/sda):"
read -rp "Festplatte: " DISK

# Partitionierung mit cfdisk
cfdisk $DISK

# Teil 2 - Partitionen erstellen und formatieren
echo "Welche Partitionen möchten Sie für /boot/efi, /, /home und swap verwenden?"
echo "z.B. /dev/sda1 für boot/efi, /dev/sda2 für root, /dev/sda3 für home, /dev/sda4 für swap"
read -rp "Boot-Partition (z.B. /dev/sda1): " BOOTPART
read -rp "Root-Partition (z.B. /dev/sda2): " ROOTPART
read -rp "Home-Partition (z.B. /dev/sda3): " HOMEPART
read -rp "Swap-Partition (z.B. /dev/sda4): " SWAPPART

echo "Bitte wählen Sie das Dateisystem für die Partitionen: ext4, btrfs oder andere"
read -rp "Dateisystem für Boot-Partition: " BOOTFS
read -rp "Dateisystem für Root-Partition: " ROOTFS
read -rp "Dateisystem für Home-Partition: " HOMEFS
read -rp "Dateisystem für Swap-Partition: " SWAPFS

# Partitionen formatieren
mkfs.$BOOTFS $BOOTPART
mkfs.$ROOTFS $ROOTPART
mkfs.$HOMEFS $HOMEPART
mkswap $SWAPPART
swapon $SWAPPART

# Partitionen mounten
mount $ROOTPART /mnt
mkdir -p /mnt/boot/efi
mount $BOOTPART /mnt/boot/efi
mkdir -p /mnt/home
mount $HOMEPART /mnt/home

# Void Linux Basissystem installieren
xbps-install -Syu
xbps-install -S void-repo-multilib void-repo-nonfree
xbps-install -y base-system

# Teil 3 - Konfiguration der Installation
echo "Wählen Sie Ihre Region (z.B. de_DE.UTF-8):"
read -rp "Locale: " LOCALE
echo "Wählen Sie Ihr Tastatur-Layout (z.B. de):"
read -rp "Keyboard-Layout: " KEYBOARD
echo "Wählen Sie Ihre Zeitzone (z.B. Europe/Berlin):"
read -rp "Zeitzone: " TZ
echo "Wählen Sie den Hostnamen:"
read -rp "Hostname: " HOSTNAME

# Systemeinstellungen
echo $LOCALE > /mnt/etc/locale.conf
echo "KEYMAP=$KEYBOARD" > /mnt/etc/vconsole.conf
ln -sf /usr/share/zoneinfo/$TZ /mnt/etc/localtime
echo $HOSTNAME > /mnt/etc/hostname

# Mirror-Server konfigurieren
cp /etc/xbps.d/00-repository-main.conf /mnt/etc/xbps.d/
cp /etc/xbps.d/00-repository-multilib.conf /mnt/etc/xbps.d/

# Chroot ins System
arch-chroot /mnt /bin/bash << "EOF"

# Benutzer erstellen
read -rp "Neuer Benutzername: " NEWUSER
useradd -m -G wheel,audio,video,network -s /bin/bash "$NEWUSER"
passwd "$NEWUSER"

# LightDM aktivieren
ln -s /etc/sv/dbus /var/service
ln -s /etc/sv/lightdm /var/service

# Autologin für LightDM
mkdir -p /etc/lightdm/lightdm.conf.d
cat << EOL > /etc/lightdm/lightdm.conf.d/10-autologin.conf
[Seat:*]
autologin-user=$NEWUSER
EOL

# DWM + dmenu + slstatus + Autostart-Patch
cd /home/"$NEWUSER"
sudo -u "$NEWUSER" git clone https://git.suckless.org/dwm
sudo -u "$NEWUSER" git clone https://git.suckless.org/dmenu
sudo -u "$NEWUSER" git clone https://git.suckless.org/slstatus

# Optional: Autostart-Patch anwenden (wenn du willst)
cd dwm
sudo -u "$NEWUSER" wget https://dwm.suckless.org/patches/autostart/dwm-autostart-20211122-65cb96b.diff
sudo -u "$NEWUSER" patch -p1 < dwm-autostart-20211122-65cb96b.diff

sudo -u "$NEWUSER" make clean install
cd ../dmenu && sudo -u "$NEWUSER" make clean install
cd ../slstatus && sudo -u "$NEWUSER" make clean install

# Autostart-Skript für dwm
mkdir -p /home/"$NEWUSER"/.local/share/dwm
cat << 'EOL' > /home/"$NEWUSER"/.local/share/dwm/autostart.sh
#!/bin/sh
xrandr --output HDMI-A-0 --left-of DisplayPort-2
setxkbmap de
numlockx on
nitrogen --restore &
slstatus &
EOL
chmod +x /home/"$NEWUSER"/.local/share/dwm/autostart.sh

# .xinitrc setzen
echo "exec dwm" > /home/"$NEWUSER"/.xinitrc
chown -R "$NEWUSER:$NEWUSER" /home/"$NEWUSER"

# GRUB installieren (wenn noch nicht gemacht)
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=VoidLinux
grub-mkconfig -o /boot/grub/grub.cfg

echo -e "${GREEN}DWM wurde installiert. Autologin ist aktiv.${NC}"
echo -e "${GREEN}Beim nächsten Start bootet das System direkt in den DWM-Desktop.${NC}"
EOF

# Teil 4 - Nach dem Neustart: Software-Installation
echo "Starte System neu..."
reboot
