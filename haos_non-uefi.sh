#!/bin/bash
set -e

# -------- 1. IMAGEVAL --------

declare -A IMAGES
IMAGES["18.4"]="https://github.com/home-assistant/operating-system/releases/download/18.4/haos_generic-x86-64-18.4.img.xz"
IMAGES["18.3"]="https://github.com/home-assistant/operating-system/releases/download/18.3/haos_generic-x86-64-18.3.img.xz"
IMAGES["18.2"]="https://github.com/home-assistant/operating-system/releases/download/18.2/haos_generic-x86-64-18.2.img.xz"
IMAGES["18.1"]="https://github.com/home-assistant/operating-system/releases/download/18.1/haos_generic-x86-64-18.1.img.xz"
IMAGES["18.0"]="https://github.com/home-assistant/operating-system/releases/download/18.0/haos_generic-x86-64-18.0.img.xz"
IMAGES["17.3"]="https://github.com/home-assistant/operating-system/releases/download/17.3/haos_generic-x86-64-17.3.img.xz"
IMAGES["17.2"]="https://github.com/home-assistant/operating-system/releases/download/17.2/haos_generic-x86-64-17.2.img.xz"
IMAGES["17.1"]="https://github.com/home-assistant/operating-system/releases/download/17.1/haos_generic-x86-64-17.1.img.xz"
IMAGES["17.0"]="https://github.com/home-assistant/operating-system/releases/download/17.0/haos_generic-x86-64-17.0.img.xz"
IMAGES["16.3"]="https://github.com/home-assistant/operating-system/releases/download/16.3/haos_generic-x86-64-16.3.img.xz"
IMAGES["16.2"]="https://github.com/home-assistant/operating-system/releases/download/16.2/haos_generic-x86-64-16.2.img.xz"
IMAGES["16.1"]="https://github.com/home-assistant/operating-system/releases/download/16.1/haos_generic-x86-64-16.1.img.xz"
IMAGES["16.0"]="https://github.com/home-assistant/operating-system/releases/download/16.0/haos_generic-x86-64-16.0.img.xz"
IMAGES["15.2"]="https://github.com/home-assistant/operating-system/releases/download/15.2/haos_generic-x86-64-15.2.img.xz"
IMAGES["15.1"]="https://github.com/home-assistant/operating-system/releases/download/15.1/haos_generic-x86-64-15.1.img.xz"
IMAGES["15.0"]="https://github.com/home-assistant/operating-system/releases/download/15.0/haos_generic-x86-64-15.0.img.xz"
IMAGES["14.2"]="https://github.com/home-assistant/operating-system/releases/download/14.2/haos_generic-x86-64-14.2.img.xz"
IMAGES["14.1"]="https://github.com/home-assistant/operating-system/releases/download/14.1/haos_generic-x86-64-14.1.img.xz"
IMAGES["14.0"]="https://github.com/home-assistant/operating-system/releases/download/14.0/haos_generic-x86-64-14.0.img.xz"
IMAGES["13.2"]="https://github.com/home-assistant/operating-system/releases/download/13.2/haos_generic-x86-64-13.2.img.xz"
IMAGES["13.1"]="https://github.com/home-assistant/operating-system/releases/download/13.1/haos_generic-x86-64-13.1.img.xz"
IMAGES["13.0"]="https://github.com/home-assistant/operating-system/releases/download/13.0/haos_generic-x86-64-13.0.img.xz"
IMAGES["12.4"]="https://github.com/home-assistant/operating-system/releases/download/12.4/haos_generic-x86-64-12.4.img.xz"
IMAGES["12.3"]="https://github.com/home-assistant/operating-system/releases/download/12.3/haos_generic-x86-64-12.3.img.xz"
IMAGES["12.2"]="https://github.com/home-assistant/operating-system/releases/download/12.2/haos_generic-x86-64-12.2.img.xz"
IMAGES["12.1"]="https://github.com/home-assistant/operating-system/releases/download/12.1/haos_generic-x86-64-12.1.img.xz"
IMAGES["12.0"]="https://github.com/home-assistant/operating-system/releases/download/12.0/haos_generic-x86-64-12.0.img.xz"
IMAGES["11.5"]="https://github.com/home-assistant/operating-system/releases/download/11.5/haos_generic-x86-64-11.5.img.xz"
IMAGES["11.4"]="https://github.com/home-assistant/operating-system/releases/download/11.4/haos_generic-x86-64-11.4.img.xz"
IMAGES["11.3"]="https://github.com/home-assistant/operating-system/releases/download/11.3/haos_generic-x86-64-11.3.img.xz"
IMAGES["11.2"]="https://github.com/home-assistant/operating-system/releases/download/11.2/haos_generic-x86-64-11.2.img.xz"
IMAGES["11.1"]="https://github.com/home-assistant/operating-system/releases/download/11.1/haos_generic-x86-64-11.1.img.xz"
IMAGES["11.0"]="https://github.com/home-assistant/operating-system/releases/download/11.0/haos_generic-x86-64-11.0.img.xz"
IMAGES["10.5"]="https://github.com/home-assistant/operating-system/releases/download/10.5/haos_generic-x86-64-10.5.img.xz"
IMAGES["10.4"]="https://github.com/home-assistant/operating-system/releases/download/10.4/haos_generic-x86-64-10.4.img.xz"
IMAGES["10.3"]="https://github.com/home-assistant/operating-system/releases/download/10.3/haos_generic-x86-64-10.3.img.xz"
IMAGES["10.2"]="https://github.com/home-assistant/operating-system/releases/download/10.2/haos_generic-x86-64-10.2.img.xz"
IMAGES["10.1"]="https://github.com/home-assistant/operating-system/releases/download/10.1/haos_generic-x86-64-10.1.img.xz"
IMAGES["10.0"]="https://github.com/home-assistant/operating-system/releases/download/10.0/haos_generic-x86-64-10.0.img.xz"
IMAGES["9.5"]="https://github.com/home-assistant/operating-system/releases/download/9.5/haos_generic-x86-64-9.5.img.xz"
IMAGES["9.4"]="https://github.com/home-assistant/operating-system/releases/download/9.4/haos_generic-x86-64-9.4.img.xz"
IMAGES["9.3"]="https://github.com/home-assistant/operating-system/releases/download/9.3/haos_generic-x86-64-9.3.img.xz"
IMAGES["9.2"]="https://github.com/home-assistant/operating-system/releases/download/9.2/haos_generic-x86-64-9.2.img.xz"
IMAGES["9.1"]="https://github.com/home-assistant/operating-system/releases/download/9.1/haos_generic-x86-64-9.1.img.xz"
IMAGES["9.0"]="https://github.com/home-assistant/operating-system/releases/download/9.0/haos_generic-x86-64-9.0.img.xz"
IMAGES["8.5"]="https://github.com/home-assistant/operating-system/releases/download/8.5/haos_generic-x86-64-8.5.img.xz"
IMAGES["8.4"]="https://github.com/home-assistant/operating-system/releases/download/8.4/haos_generic-x86-64-8.4.img.xz"
IMAGES["8.3"]="https://github.com/home-assistant/operating-system/releases/download/8.3/haos_generic-x86-64-8.3.img.xz"
IMAGES["8.2"]="https://github.com/home-assistant/operating-system/releases/download/8.2/haos_generic-x86-64-8.2.img.xz"
IMAGES["8.1"]="https://github.com/home-assistant/operating-system/releases/download/8.1/haos_generic-x86-64-8.1.img.xz"
IMAGES["8.0"]="https://github.com/home-assistant/operating-system/releases/download/8.0/haos_generic-x86-64-8.0.img.xz"
IMAGES["7.6"]="https://github.com/home-assistant/operating-system/releases/download/7.6/haos_generic-x86-64-7.6.img.xz"
IMAGES["7.5"]="https://github.com/home-assistant/operating-system/releases/download/7.5/haos_generic-x86-64-7.5.img.xz"
IMAGES["7.4"]="https://github.com/home-assistant/operating-system/releases/download/7.4/haos_generic-x86-64-7.4.img.xz"
IMAGES["7.3"]="https://github.com/home-assistant/operating-system/releases/download/7.3/haos_generic-x86-64-7.2.img.xz"
IMAGES["7.2"]="https://github.com/home-assistant/operating-system/releases/download/7.2/haos_generic-x86-64-7.2.img.xz"
IMAGES["7.1"]="https://github.com/home-assistant/operating-system/releases/download/7.1/haos_generic-x86-64-7.1.img.xz"
IMAGES["7.0"]="https://github.com/home-assistant/operating-system/releases/download/7.0/haos_generic-x86-64-7.0.img.xz"
IMAGES["6.6"]="https://github.com/home-assistant/operating-system/releases/download/6.6/haos_generic-x86-64-6.6.img.xz"
IMAGES["6.5"]="https://github.com/home-assistant/operating-system/releases/download/6.5/haos_generic-x86-64-6.5.img.xz"
IMAGES["6.4"]="https://github.com/home-assistant/operating-system/releases/download/6.4/haos_generic-x86-64-6.4.img.xz"
IMAGES["6.3"]="https://github.com/home-assistant/operating-system/releases/download/6.3/haos_generic-x86-64-6.3.img.xz"
IMAGES["6.2"]="https://github.com/home-assistant/operating-system/releases/download/6.2/haos_generic-x86-64-6.2.img.xz"
IMAGES["6.1"]="https://github.com/home-assistant/operating-system/releases/download/6.1/haos_generic-x86-64-6.1.img.xz"
IMAGES["6.0"]="https://github.com/home-assistant/operating-system/releases/download/8.0/haos_generic-x86-64-6.0.img.xz"
IMAGES["MY_URL"]="MY_URL"

if [ -z "$1" ]; then
    echo
    echo "Which HAOS version/image do you want to use? 1-4"
    echo " The image will be retrieved from"
    echo " https://github.com/home-assistant/operating-system/releases"
    echo " except MY URL"
    echo
    select image in "${!IMAGES[@]}"; do
        case $image in
            "MY_URL")
                read -rp " Enter full URL to .img.xz-archive: " CUSTOM_URL
                IMG="$CUSTOM_URL"
                break
                ;;
            *)
                IMG="${IMAGES[$image]}"
                break
                ;;
        esac
    done
else
    IMG="$1"
fi

echo
echo "All disks on the system:"
echo
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
echo

echo "Available disks:"
echo
lsblk -dno NAME,SIZE,MODEL | grep -E 'sd[a-z]' | nl -w2 -s': '
echo

read -p "Which disk should be used/deleted? (e.g. sdb): " DISK_SHORT
DISK="/dev/$DISK_SHORT"

echo
echo "Target disk:      $DISK"
echo "Image-file:    $IMG"
echo

echo "=== DISK STATUS BEFORE FORMATTING  ==="
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
echo
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT $DISK*
echo
echo "WARNING: ALL DATA ON $DISK WILL BE ERASED!"
echo
read -p "Are you absolutely sure? (type 'yes'): " CONFIRM
[ "$CONFIRM" != "yes" ] && echo "Aborting." && exit 1

echo
echo "=== Step 1: Unmounting partitions ==="
sudo umount ${DISK}?* 2>/dev/null || true

echo
echo "=== Step 2: Writing HAOS image ==="
curl -L "$IMG" | xzcat | sudo dd of=$DISK bs=4M status=progress conv=fsync
sync

sudo partprobe $DISK
sudo udevadm settle
sleep 2

echo
echo "======== Step 3: GPT repair & shrink/expand data ========"
echo
echo
echo ">>>  NOTE: Don´t touch! Let the script finish its work!   <<<"
echo
echo ">>>        Lots of warnings and errors are ok!            <<<"
echo
echo
echo "========================================================="
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
  sleep 2

  sudo resize2fs ${DISK}8

  if sudo sgdisk -n 9:0:+${BRIDGE_MB}M -t 9:8300 -c 9:"GRUB Bridge" $DISK; then
    sudo partprobe $DISK
    sudo udevadm settle
    sleep 2

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
      echo "Successfully created bridge at $BRIDGE_MB MB and installed GRUB there!"
      break
    else
      echo "GRUB installation failed on bridge (${BRIDGE_MB} MB), trying smaller bridge..."
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
  echo "Bridge was TOO SMALL or could not be created – installing GRUB on the HAOS boot partition instead..."
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
  echo "GRUB installed on boot partition!"
fi

echo
echo "==============================================================="
echo "               HAOS DISK READY AND BOOTABLE!"
echo "                 Bridge partition: ${BRIDGE_MB:-ingen, fallback} MB"
echo
echo "        The disk can now be moved to your computer."
echo " Make sure your computer is set to boot in 'Legacy BIOS' mode."
echo
echo "Best regards, https://github.com/Karacsonyi-Endre/haos-non-uefi"
echo "==============================================================="
