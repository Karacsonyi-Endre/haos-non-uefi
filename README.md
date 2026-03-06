# HAOS Legacy BIOS Factory Script — Detaljerad Teknisk Manual (Svenska/English)

---

## 🇸🇪 **Svenska — Teknisk förklaring**

### **Syfte**

Detta script möjliggör installation av Home Assistant OS (HAOS) på x86-64-maskiner med endast legacy BIOS (utan UEFI), vilket inte stöds av moderna HAOS-versioner.

---

### **Teknisk Problembild**

- **HAOS-diskimage** använder alltid **GPT** för partitionsschema och förväntar sig UEFI-boot.
- BIOS-maskiner vill helst ha **MBR** och kan INTE direkt läsa GPT/UFS-root, samt hittar ofta inte rätt bootsektorer.
- Core-struktur i GPT:
  - *sda1*: `hassos-boot` (FAT16, bootfiler)
  - *sda2--sda6*: kernel/root/system/backups
  - *sda8*: `hassos-data` (user data)
- BIOS kan inte starta *någon* av dessa direkt.

---

### **Tekniska Lösningssteg (Vad Scriptet Gör)**

1. **Image-Skrivning**
    - Hämtar (eller läser från egen server) en xz-komprimerad HAOS-image (t.ex. v13.0), paketerad av Home Assistant-teamet.
    - Skriver bilden rakt ut till vald disk med `dd` (block­läget), så hela GPT-tavlan, alla partitioners UUID och originalstruktur bevaras bit för bit.
    - Detta krävs för att hela det officiella HAOS-upplägget med updatering/backups/addons ska fungera.

2. **Synkar Kernel/Devices**
    - `partprobe`, `udevadm settle`, sleep — garanterar att alla `/dev/sdXN`-noder och kerneltabeller är fullt i synk innan vidare partitionsexpansion eller GRUB-operatör.
    - Löst många edge-cases på äldre BIOS där statiska device nodes kan bli fel.

3. **Partitionstabell-vidgning (sgdisk)**
    - Om disken är större än imagen, expanderas GPT så att hela fysiska disken kan användas (självklart, annars “missar” man MB/GB).
    - (`sgdisk -e`). Synk igen.

4. **Bryggpartition (GRUB-Bridge, EXT4) — Dynamisk storlek**
    - Krymper partition 8 (“hassos-data”) så att ledigt utrymme skapas på slutet.
    - Loopar med _flera minskande storlekar_ (32→8MB) och försöker skapa ny partition 9 (“GRUB Bridge”) med `sgdisk` som EXT4-typ.
    - Skapar EXT4-filsystem på denna, **endast om tillräckligt med plats.**
    - Varför ext4? För det är den enda robusta metoden GRUB Legacy kan använda på gpt-disk i BIOS om man vill undvika UEFI/EF02—en direkt effekt av ThinkPad-communityns reverse engineering.

5. **GRUB-installation**
    - Mountar “bryggan”, lägger boot-directory och installerar legacy GRUB (`grub-install --target=i386-pc`) rakt till MBR.
    - Lägger in custom `grub.cfg` som pekar på HAOS bootpartition.
    - *Om* bryggan blir för liten/GRUB-install failar:  
      ----> **Fallback: installerar GRUB rakt på hassos-boot-partitionen** (`/dev/sda1`, FAT16), som dock saknar vissa features men alltid startar HAOS.

6. **Boot-kedja (BIOS→MBR/GRUB→brygga→HAOS/GRUB2)**
    - Vid boot:
      1. **BIOS** söker MBR, laddar GRUB från brygga/boot-partition.
      2. **GRUB** hittar/”chainloadar” config/filer från GPT/boot.
      3. **HAOS** startar kernel/initrd upp genom sin egen moderna bootkedja.
    - Allt sker *utan UEFI*, ingen ändring av original-HAOS, inget behov av EF02.

---

#### **Erfarenheter och gränser**

- Fungerar på: X61s, HP DC5100, äldre Dells, IBM server/desktop x86-64, m.fl.
- Testat: SSD, IDE, SATA, USB-adapter
- **HAOS 13 rekommenderas. Nyare versioner** (t.ex. 15) kraschar på många gamla BIOS-PC.
- Du får ocensurerad HAOS-upplevelse med full Addon/Supervisor-stöd (ej möjligt i container/lxc-docker på dessa maskiner).

---

### **Full Installation Workflow**

1. Starta Ubuntu (eller använd Live USB).
2. Koppla in disk (den raderas!).
3. Kör scriptet (`sudo ./haos_bios_factory_final.sh`).
4. Välj disk, konfirmera med ‘yes’.
5. Vänta — alltföras automatiskt (status syns).
6. Sätt disken i valfri BIOS-maskin och boot — HAOS lever!

---

### **Community-acknowledgement**

Denna lösning är baserad på [Home Assistant-dokumentationens issue #39584](https://github.com/home-assistant/home-assistant.io/issues/39584).  
Det är genuin community reverse engineering på ett OS som annars exkluderar gammal hårdvara.  

---

## 🇬🇧 **English — Detailed Technical Explanation**

### **Purpose**

This script enables installation of Home Assistant OS (HAOS) on x86-64 machines with **legacy BIOS only** (no UEFI), which is not supported by modern HAOS releases.

---

### **Technical Problem Overview**

- **HAOS disk images** use **GPT** partitioning and expect UEFI boot.
- BIOS-only computers expect **MBR** and cannot directly boot from a GPT/UFS root, and often cannot read the GPT partition table at all.
- Typical GPT layout:
  - *sda1*: `hassos-boot` (FAT16, bootloader files)
  - *sda2--sda6*: kernel/root/system/backups
  - *sda8*: `hassos-data` (user data)
- BIOS cannot boot any of these partitions directly.

---

### **Technical Step-by-Step (What the Script Does Internally)**

1. **Image Write**
    - Fetches (or uses your own HTTP server) an xz-compressed HAOS image (e.g., v13.0, by Home Assistant).
    - Writes it to the chosen disk using `dd`, preserving the exact GPT table, partitions, UUIDs, and original filesystem.
    - Required so that HAOS works as intended with its own update/backup system.

2. **Kernel/Device Sync**
    - Immediately after any operation: runs `partprobe`, `udevadm settle`, and sleep—ensures all `/dev/sdXN` nodes and kernel representations are correct and up-to-date before resizing or running GRUB.
    - This fixes edge-cases on older BIOS machines with inconsistent device mapping.

3. **GPT repair (sgdisk)**
    - If disk is larger than the HAOS image, expands GPT so the full physical disk is used (`sgdisk -e`).
    - Sync again.

4. **Bridge Partition (Dynamic size – EXT4)**
    - Shrinks partition 8 ("hassos-data") to create free space at the physical disk end.
    - Loops over multiple decreasing sizes (32→8MB) and tries to create a new partition 9 ("GRUB Bridge" EXT4).
    - Creates EXT4 filesystem on it (only if enough space).
    - Why EXT4? Because it’s the only robust method for GRUB Legacy on a GPT disk/BIOS (without needing UEFI/EF02)—a hack proven by the ThinkPad and retro community.

5. **GRUB Installation**
    - Mounts the bridge, lays down the boot directory and installs legacy GRUB (`grub-install --target=i386-pc`) directly to the MBR.
    - Installs your chained `grub.cfg` referencing HAOS’s boot partition.
    - *If* the bridge is too small or GRUB install fails:  
      ----> **Fallback: Installs GRUB directly onto the HAOS boot partition** (`/dev/sda1`, FAT16), which always boots, but with limited feature set.

6. **Boot chain (BIOS→MBR/GRUB→bridge→HAOS/GRUB2)**
    - At boot:
      1. **BIOS** loads MBR, boots GRUB from bridge or boot partition.
      2. **GRUB** finds/configures from GPT boot partition.
      3. **HAOS** starts kernel/initrd via its own modern chainload.
    - No need to modify HAOS, no EF02 or UEFI required.

---

#### **Operational Results / Hardware Tested**

- Success on: ThinkPad X61s, HP DC5100, old Dell x86-64, IBM servers/desktops, others.
- Tested with: SSDs, IDE, SATA, USB adapters.
- **HAOS 13 recommended.** Newer versions (e.g., 15.x) often crash at boot on legacy hardware.
- Outcomes: Full-featured HAOS (not container, not supervised) experience, with add-ons and update support.

---

### **Complete Usage Workflow**

1. Boot Ubuntu (Live USB or installed).
2. Attach your target disk (warning—all data will be lost!).
3. Copy and run this script (`sudo ./haos_bios_factory_final.sh`).
4. Choose your correct disk (e.g., sda/sdb), confirm.
5. Wait for finish—all steps handled automatically.
6. Move disk to any BIOS-only (non-UEFI) machine and boot: HAOS is ready!

---

### **Community Acknowledgement / Credits**

- This solution is based on [Home Assistant issue #39584](https://github.com/home-assistant/home-assistant.io/issues/39584).
- Represents true community reverse engineering.

---

_Last updated: March 2026_
