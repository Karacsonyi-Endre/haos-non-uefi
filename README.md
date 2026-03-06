# HAOS Legacy BIOS Factory Script â€” Detaljerad Teknisk Manual (Svenska/English)

---

## ðŸ‡¸ðŸ‡ª **Svenska â€” Teknisk fÃ¶rklaring**

### **Syfte**

Detta script mÃ¶jliggÃ¶r installation av Home Assistant OS (HAOS) pÃ¥ x86-64-maskiner med endast legacy BIOS (utan UEFI), vilket inte stÃ¶ds av moderna HAOS-versioner.

---

### **Teknisk Problembild**

- **HAOS-diskimage** anvÃ¤nder alltid **GPT** fÃ¶r partitionsschema och fÃ¶rvÃ¤ntar sig UEFI-boot.
- BIOS-maskiner vill helst ha **MBR** och kan INTE direkt lÃ¤sa GPT/UFS-root, samt hittar ofta inte rÃ¤tt bootsektorer.
- Core-struktur i GPT:
  - *sda1*: `hassos-boot` (FAT16, bootfiler)
  - *sda2--sda6*: kernel/root/system/backups
  - *sda8*: `hassos-data` (user data)
- BIOS kan inte starta *nÃ¥gon* av dessa direkt.

---

### **Tekniska LÃ¶sningssteg (Vad Scriptet GÃ¶r)**

1. **Image-Skrivning**
    - HÃ¤mtar (eller lÃ¤ser frÃ¥n egen server) en xz-komprimerad HAOS-image (t.ex. v13.0), paketerad av Home Assistant-teamet.
    - Skriver bilden rakt ut till vald disk med `dd` (blockÂ­lÃ¤get), sÃ¥ hela GPT-tavlan, alla partitioners UUID och originalstruktur bevaras bit fÃ¶r bit.
    - Detta krÃ¤vs fÃ¶r att hela det officiella HAOS-upplÃ¤gget med updatering/backups/addons ska fungera.

2. **Synkar Kernel/Devices**
    - `partprobe`, `udevadm settle`, sleepÂ â€” garanterar att alla `/dev/sdXN`-noder och kerneltabeller Ã¤r fullt i synk innan vidare partitionsexpansion eller GRUB-operatÃ¶r.
    - LÃ¶st mÃ¥nga edge-cases pÃ¥ Ã¤ldre BIOS dÃ¤r statiska device nodes kan bli fel.

3. **Partitionstabell-vidgning (sgdisk)**
    - Om disken Ã¤r stÃ¶rre Ã¤n imagen, expanderas GPT sÃ¥ att hela fysiska disken kan anvÃ¤ndas (sjÃ¤lvklart, annars â€œmissarâ€ man MB/GB).
    - (`sgdisk -e`). Synk igen.

4. **Bryggpartition (GRUB-Bridge, EXT4) â€” Dynamisk storlek**
    - Krymper partition 8 (â€œhassos-dataâ€) sÃ¥ att ledigt utrymme skapas pÃ¥ slutet.
    - Loopar med _flera minskande storlekar_ (32â†’8MB) och fÃ¶rsÃ¶ker skapa ny partition 9 (â€œGRUB Bridgeâ€) med `sgdisk` som EXT4-typ.
    - Skapar EXT4-filsystem pÃ¥ denna, **endast om tillrÃ¤ckligt med plats.**
    - VarfÃ¶r ext4? FÃ¶r det Ã¤r den enda robusta metoden GRUB Legacy kan anvÃ¤nda pÃ¥ gpt-disk i BIOS om man vill undvika UEFI/EF02â€”en direkt effekt av ThinkPad-communityns reverse engineering.

5. **GRUB-installation**
    - Mountar â€œbrygganâ€, lÃ¤gger boot-directory och installerar legacy GRUB (`grub-install --target=i386-pc`) rakt till MBR.
    - LÃ¤gger in custom `grub.cfg` som pekar pÃ¥ HAOS bootpartition.
    - *Om* bryggan blir fÃ¶r liten/GRUB-install failar:  
      ----> **Fallback: installerar GRUB rakt pÃ¥ hassos-boot-partitionen** (`/dev/sda1`, FAT16), som dock saknar vissa features men alltid startar HAOS.

6. **Boot-kedja (BIOSâ†’MBR/GRUBâ†’bryggaâ†’HAOS/GRUB2)**
    - Vid boot:
      1. **BIOS** sÃ¶ker MBR, laddar GRUB frÃ¥n brygga/boot-partition.
      2. **GRUB** hittar/â€chainloadarâ€ config/filer frÃ¥n GPT/boot.
      3. **HAOS** startar kernel/initrd upp genom sin egen moderna bootkedja.
    - Allt sker *utan UEFI*, ingen Ã¤ndring av original-HAOS, inget behov av EF02.

---

#### **Erfarenheter och grÃ¤nser**

- Fungerar pÃ¥: X61s, HP DC5100, Ã¤ldre Dells, IBM server/desktop x86-64, m.fl.
- Testat: SSD, IDE, SATA, USB-adapter
- **HAOS 13 rekommenderas. Nyare versioner** (t.ex. 15) kraschar pÃ¥ mÃ¥nga gamla BIOS-PC.
- Du fÃ¥r ocensurerad HAOS-upplevelse med full Addon/Supervisor-stÃ¶d (ej mÃ¶jligt i container/lxc-docker pÃ¥ dessa maskiner).

---

### **Full Installation Workflow**

1. Starta Ubuntu (eller anvÃ¤nd Live USB).
2. Koppla in disk (den raderas!).
3. KÃ¶r scriptet (`sudo ./haos_bios_factory_final.sh`).
4. VÃ¤lj disk, konfirmera med â€˜yesâ€™.
5. VÃ¤nta â€”Â alltfÃ¶ras automatiskt (status syns).
6. SÃ¤tt disken i valfri BIOS-maskin och boot â€”Â HAOS lever!

---

### **Community-acknowledgement**

Denna lÃ¶sning Ã¤r baserad pÃ¥ [Home Assistant-dokumentationens issue #39584](https://github.com/home-assistant/home-assistant.io/issues/39584).  
Det Ã¤r genuin community reverse engineering pÃ¥ ett OS som annars exkluderar gammal hÃ¥rdvara.  
Scriptet har vidare optimerats och robustifierats av TG-Proton m.fl. vÃ¥ren 2026 med hjÃ¤lp av OpenAI Copilot Chat.

---

## ðŸ‡¬ðŸ‡§ **English â€” Detailed Technical Explanation**

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
    - Immediately after any operation: runs `partprobe`, `udevadm settle`, and sleepâ€”ensures all `/dev/sdXN` nodes and kernel representations are correct and up-to-date before resizing or running GRUB.
    - This fixes edge-cases on older BIOS machines with inconsistent device mapping.

3. **GPT repair (sgdisk)**
    - If disk is larger than the HAOS image, expands GPT so the full physical disk is used (`sgdisk -e`).
    - Sync again.

4. **Bridge Partition (Dynamic size â€“ EXT4)**
    - Shrinks partition 8 ("hassos-data") to create free space at the physical disk end.
    - Loops over multiple decreasing sizes (32â†’8MB) and tries to create a new partition 9 ("GRUB Bridge" EXT4).
    - Creates EXT4 filesystem on it (only if enough space).
    - Why EXT4? Because itâ€™s the only robust method for GRUB Legacy on a GPT disk/BIOS (without needing UEFI/EF02)â€”a hack proven by the ThinkPad and retro community.

5. **GRUB Installation**
    - Mounts the bridge, lays down the boot directory and installs legacy GRUB (`grub-install --target=i386-pc`) directly to the MBR.
    - Installs your chained `grub.cfg` referencing HAOSâ€™s boot partition.
    - *If* the bridge is too small or GRUB install fails:  
      ----> **Fallback: Installs GRUB directly onto the HAOS boot partition** (`/dev/sda1`, FAT16), which always boots, but with limited feature set.

6. **Boot chain (BIOSâ†’MBR/GRUBâ†’bridgeâ†’HAOS/GRUB2)**
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
2. Attach your target disk (warningâ€”all data will be lost!).
3. Copy and run this script (`sudo ./haos_bios_factory_final.sh`).
4. Choose your correct disk (e.g., sda/sdb), confirm.
5. Wait for finishâ€”all steps handled automatically.
6. Move disk to any BIOS-only (non-UEFI) machine and boot: HAOS is ready!

---

### **Community Acknowledgement / Credits**

- This solution is based on [Home Assistant issue #39584](https://github.com/home-assistant/home-assistant.io/issues/39584).
- Represents true community reverse engineering.
- This script further optimised in 2026 by TG-Proton & OpenAI Copilot Chat with empirical fixes for edge-cases and legacy quirks.

---

_Last updated: March 2026_
