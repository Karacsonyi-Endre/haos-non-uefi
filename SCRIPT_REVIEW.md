# Analysis of the Script

Here is exactly what the script does, step by step.
## What the Script Does

### 1. Selects HAOS Image

The script has a built-in list of versions:

- 17.1
- 15.2
- 13.0
- MY_URL

You download a `.img.xz` file directly from the Home Assistant OS releases. This is not patching an already written disk—the script always writes a fresh HAOS image to a selected disk.

### 2. You Select the Target Disk

The script lists all disks and lets you choose, e.g., `sdb`. **Important:**  
The script operates directly on a physical disk, not on an image file.

### 3. Writes the Original HAOS Image to the Disk

The central line is:

```bash
curl -L "$IMG" | xzcat | sudo dd of=$DISK bs=4M status=progress conv=fsync
```

This means:

- No modification of the image before writing
- No loop-mounting
- No manual partitioning

It's a **pure, standard HAOS layout** that is written to the disk first.

### 4. Repair GPT

The script runs  
`sgdisk -e` to ensure the GPT table is correct after the `dd` operation.

### 5. ⭐ Here’s the Real Magic: the “BRIDGE Partition”

#### Create the “GRUB Bridge” Partition

The script attempts to create an extra small ext4 partition at the end of the disk, called “GRUB Bridge”.

It does this by:

1. Shrinking the HAOS data partition (partition 8) backwards with `resizepart`
2. Running `resize2fs` on it
3. Creating a new partition (number 9) with a size of 32 → 24 → 16 → 12 → 10 → 9 → 8 MB, trying smaller sizes until it succeeds

This is clever:  
It ensures the script works on different disks with different geometries.

### 6. Install GRUB in BIOS Mode on the Bridge Partition

When partition 9 exists:

```bash
mkfs.ext4 ${DISK}9
mount ${DISK}9 /mnt/bridge
grub-install --boot-directory=/mnt/bridge/boot --target=i386-pc $DISK --force
```

This achieves two things:

- Installs **i386-pc GRUB** in MBR + BIOS boot code
- Places the GRUB files in `/mnt/bridge/boot/grub`

Then it creates a minimal grub.cfg:

```bash
set root=(hd0,gpt1)
configfile /efi/boot/grub.cfg
```

This chainloads HAOS’s own UEFI `grub.cfg` without modifying the HAOS system.

### 7. Fallback: Install GRUB Directly on Partition 1

If the bridge partition cannot be created, the script installs GRUB directly on hassos-boot (partition 1).

### 8. Done – The Disk Is BIOS-Bootable

The script finishes by notifying that the disk is ready to use in a pure BIOS machine.

This means:

- 👉 GRUB in BIOS mode chainloads HAOS’s **own UEFI grub.cfg**  
- 👉 HAOS itself does not need any modification
- 👉 Updates work, since the HAOS bootloader is untouched

This is a brilliant approach.

🟥 6. Fallback: Install GRUB directly on partition 1 (hassos-boot)

If “bridge” cannot be created:

- The script mounts partition 1 (hassos-boot)
- Installs GRUB there instead
- Places the same chainloading grub.cfg

It is a robust fallback.

🟢 7. Done – The disk is BIOS-bootable

The script ends with:

```
HAOS DISK READY AND BOOTABLE!
```

And that's accurate.

---

## This Is How You Apply the Method – Correctly and Exactly

Here is the real, precise process:

- Run the script: `./haos-non-uefi.sh`
- Select the HAOS version or enter a custom URL
- Select target disk (e.g., sdb)
- Confirm that it will be erased
- Wait while the script:
    - writes the HAOS image
    - repairs GPT
    - shrinks the data partition
    - creates the “bridge”
    - installs GRUB in BIOS mode
    - creates chainloading grub.cfg
- Move the disk to the BIOS machine
- Set BIOS to Legacy Only
- Boot—the HAOS now starts without UEFI

---

## 💡 Why This Works So Well

Because the script:

- does not modify the HAOS image
- does not modify the HAOS bootloader
- does not change A/B slots
- does not touch partitions 1–8
- only adds a BIOS-compatible GRUB bootstrap

It's exactly the right way to do it.

---

## How to Use the Method

- Run the script: `./haos-non-uefi.sh`
- Select HAOS version
- Select target disk
- Confirm erasure
- Wait as the script writes the image, repairs GPT, creates bridge, and installs GRUB
- Move the disk to the BIOS machine
- Set BIOS to “Legacy Only”
- Boot—HAOS now starts without UEFI

---

## Why This Works

- The HAOS image is not modified
- The HAOS bootloader isn’t changed
- A/B slots are unaffected
- Only a BIOS-compatible GRUB bootstrap is added

It’s exactly the right way to do it.

---

> This analysis describes [`haos-non-uefi.sh`](https://github.com/Karacsonyi-Endre/haos-non-uefi/blob/main/haos_non-uefi.sh)
