#!/bin/bash
set -e

echo "================================="
echo " HAOS Legacy BIOS Factory Creator"
echo "================================="

echo "Alla diskar på systemet:"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
echo

echo "Tillgängliga diskar:"
lsblk -dno NAME,SIZE,MODEL | grep -E 'sd[a-z]' | nl -w2 -s': '
echo

read -p "Vilken disk ska användas? (t.ex. sda): " DISK_SHORT
DISK="/dev/$DISK_SHORT"
IMG="https://github.com/home-assistant/operating-system/releases/download/13.0/haos_generic-x86-64-13.0.img.xz"

echo
echo "Måldisk:      $DISK"
echo "Image-fil:    $IMG"
echo

echo "=== DISKSTATUS FÖRE FORMATERING ==="
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
echo
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT $DISK*
echo
echo "VARNING: ALL DATA PÅ $DISK KOMMER ATT RADERAS!"
echo
read -p "Är du helt säker? (skriv 'yes'): " CONFIRM
[ "$CONFIRM" != "yes" ] && echo "Avbryter." && exit 1

echo
echo "=== Steg 1: Avmonterar partitioner ==="
sudo umount ${DISK}?* 2>/dev/null || true

echo
echo "=== Steg 2: Skriver HAOS-image ==="
curl -L "$IMG" | xzcat | sudo dd of=$DISK bs=4M status=progress conv=fsync
sync

sudo partprobe $DISK
sudo udevadm settle
sleep 2

echo
echo "=== Steg 3: GPT repair & shrink/expand data ==="
sudo sgdisk -e $DISK
sudo partprobe $DISK
sudo udevadm settle
sleep 2

# Flexibel bryggstorlek och fallback vid fail
BRIDGE_DONE=""
for BRIDGE_MB in 32 24 16 12 10 9 8; do
  echo "Försöker skapa brygga på $BRIDGE_MB MB..."

  sudo parted -s $DISK resizepart 8 -- -$((BRIDGE_MB + 1))MB || continue
  sudo partprobe $DISK
  sudo udevadm settle
  sleep 1

  sudo resize2fs ${DISK}8

  if sudo sgdisk -n 9:0:+${BRIDGE_MB}M -t 9:8300 -c 9:"GRUB Bridge" $DISK; then
    sudo partprobe $DISK
    sudo udevadm settle
    sleep 1

    sudo mkfs.ext4 -F ${DISK}9
    sudo mkdir -p /mnt/bridge
    sudo mount ${DISK}9 /mnt/bridge
    GRUB_OK=1
    sudo grub-install --boot-directory=/mnt/bridge/boot --target=i386-pc $DISK --force || GRUB_OK=0
    if [ $GRUB_OK -eq 1 ]; then
      sudo mkdir -p /mnt/bridge/boot/grub
      sudo tee /mnt/bridge/boot/grub/grub.cfg <<EOF
set root=(hd0,gpt1)
configfile /efi/boot/grub.cfg
EOF
      sudo umount /mnt/bridge
      sync
      BRIDGE_DONE="1"
      echo "Lyckades skapa brygga på $BRIDGE_MB MB och installera GRUB där!"
      break
    else
      echo "GRUB-installation misslyckades på brygga (${BRIDGE_MB} MB), försöker mindre brygga..."
      sudo umount /mnt/bridge || true
      sudo sgdisk --delete 9 $DISK 2>/dev/null || true
      sudo partprobe $DISK
      sudo udevadm settle
      sleep 1
    fi
  fi
done

if [ -z "$BRIDGE_DONE" ]; then
  echo
  echo "Bryggan blev FÖR LITEN eller kunde ej skapas – installerar GRUB på HAOS boot-partition istället..."
  sudo mkdir -p /mnt/haosboot
  sudo mount ${DISK}1 /mnt/haosboot
  sudo grub-install --boot-directory=/mnt/haosboot/boot --target=i386-pc $DISK --force
  sudo mkdir -p /mnt/haosboot/boot/grub
  sudo tee /mnt/haosboot/boot/grub/grub.cfg <<EOF
set root=(hd0,gpt1)
configfile /efi/boot/grub.cfg
EOF
  sudo umount /mnt/haosboot
  sync
  echo "GRUB installerad på bootpartitionen!"
fi

echo
echo "========================================="
echo " HAOS FABRIKSDISK REDO OCH BOOTBAR!"
echo " Brygga-partition: ${BRIDGE_MB:-ingen, fallback} MB"
echo "========================================="