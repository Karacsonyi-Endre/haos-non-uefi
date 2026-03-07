# Manual (English/Svenska): Create a turnkey HAOS disk for BIOS

---

> **This is not a "guide to build an image" – it is a tool that transforms a physical disk into a ready-to-boot HAOS start disk for BIOS machines in one single sweep.**
>
> Here is the manual for how to use the script `haos-non-uefi.sh` to create your ready-to-boot disk.
>
> **This script does the heavy lifting for you:** it fetches the official HAOS image, writes it to your hard drive, and then installs a specially configured GRUB bootloader so your old PC can boot from a modern GPT-partitioned disk.

---

## Why this is superior

The script is designed to remove “human error”. It automatically lists all disks and lets you choose, eliminating the risk of accidentally overwriting the wrong partition. It creates a perfect copy of an official HAOS installation, but with the magic “BIOS key” that allows your old hardware to unlock and boot it.

---

## Why this is the only real solution for you

Since the script injects a Hybrid-MBR, your BIOS can “see” the disk as an old-fashioned boot disk, while the actual data remains in the modern format required by HAOS. You get a 100% official HAOS experience on legacy hardware that the manufacturer has long since abandoned.

---

# Step-by-step: Create a Home Assistant OS disk with `haos-non-uefi.sh` (for COMPLETE Linux beginners)

---

## 1. Download the script

### a) Boot Ubuntu (or similar Linux) on your computer
- **Live USB?** Always pick "Try Ubuntu" (not "Install Ubuntu") when you boot from the thumbdrive.

### b) Open the terminal
- Click the top left menu and type “Terminal” (or press **Ctrl+Alt+T**).

### c) Paste the following, then press Enter:
```bash
sudo apt update
sudo apt install git curl xz-utils gdisk parted e2fsprogs grub-pc -y
```
*(This installs all required tools. Just copy-paste and press Enter!)*

### d) Download the script from GitHub
```bash
git clone https://github.com/Karacsonyi-Endre/haos-non-uefi.git
cd haos-non-uefi
```

---

## 2. Insert your target disk

- Plug in the SSD/HDD/USB stick you want to use as your Home Assistant disk.
- **WARNING: All data on that disk will be erased!**

---

## 3. Make the script executable

```bash
chmod +x haos-non-uefi.sh
```

---

## 4. Start the script

```bash
sudo ./haos-non-uefi.sh
```

- **It is important to use sudo!** Otherwise, the script cannot write to the disk.

---

## 5. Follow the on-screen instructions

### a) Choose HAOS version
- The script presents a menu with Home Assistant OS versions. Type a number (e.g., “1”) and press Enter for the newest version, or choose “EGEN_URL” to use your own link.

### b) Choose your target disk
- All disks are listed with size/model.
- Type the number for the correct disk and press Enter.

### c) Confirm
- You get a final warning that your disk will be erased.
- Type exactly `yes` and press Enter to continue.

### d) Wait
- The script downloads, writes, and finishes everything automatically. This may take several minutes depending on your internet and USB speed.

---

## 6. Done!

- When you see **"KLART!"** or **"Ready"**, you’re finished.
- Remove the disk and plug it into your old PC/server.
- Boot up – Home Assistant will start automatically!

---

## Extra info for first-time Linux users

- **What is a “terminal”?**  
  A text window where you can paste and run commands directly.
- **What does “sudo” mean?**  
  “Super User DO” –  gives you extra privileges to write disks, install, etc.
- **Do I have to pick the right disk?**  
  YES! The script will erase everything on the disk you select. Read the list carefully, make sure you have the right size and model.

---

## FAQ

**Q: Can this destroy my regular computer?**  
A: Not if you CHOOSE THE RIGHT DISK. Be very careful when selecting your disk!

**Q: Do I need to install Ubuntu?**  
A: No! Just boot from USB and pick “Try Ubuntu”. Your regular computer is not affected.

**Q: I get “permission denied” or “no such file”?**  
A: Check your spelling, that you are in the right folder (`cd haos-non-uefi`), and always use `sudo` when running the script.

---

**Good luck! Your Home Assistant disk will be ready in just minutes – and you can repeat the process at any time with a new disk or a new version.**

---

---

# Manual: Skapa en nyckelfärdig HAOS-disk för BIOS

> **Det här är inte en "guide för att bygga en image", det är ett verktyg som förvandlar en fysisk disk till en färdig HAOS-startdisk för BIOS-maskiner i ett enda svep.**
>
> Här är manualen för hur du använder skriptet `haos-non-uefi.sh` för att skapa din färdiga disk.
>
> **Det här skriptet gör grovjobbet åt dig:** det hämtar den officiella HAOS-imagen, skriver den till din hårddisk, och installerar sedan en specialkonfigurerad GRUB-bootloader som gör att din gamla dator kan läsa den moderna GPT-partitionen.

---

## Varför detta är överlägset:

Skriptet är skrivet för att ta bort "mänskliga faktorn". Genom att det själv listar diskarna och låter dig välja, elimineras risken att du skriver över fel partition av misstag. Det skapar en perfekt kopia av en officiell HAOS-installation, men med den magiska "BIOS-nyckeln" som gör att din gamla hårdvara faktiskt kan låsa upp den.

---

## Varför detta är den enda rätta lösningen för dig:

Eftersom skriptet injicerar en Hybrid-MBR, kan ditt BIOS "se" disken som en gammaldags startbar disk, medan den faktiska datan ligger kvar i det moderna formatet som HAOS kräver. Du får alltså en officiell HAOS-upplevelse på hårdvara som tillverkaren egentligen gett upp hoppet om.

---

# Steg-för-steg: Skapa Home Assistant OS-disk med `haos-non-uefi.sh` (för HELT nya Linux-användare)

## **1. Ladda ner skriptet**

### **a) Starta Ubuntu (eller liknande Linux) på datorn**
- **Live USB?** Välj alltid "Testa Ubuntu" eller "Try Ubuntu" när du bootar från stickan, INTE "Installera Ubuntu".

### **b) Öppna “Terminal”**
- Klicka på menyn uppe till vänster och skriv “Terminal” (eller tryck **Ctrl+Alt+T**).

### **c) Skriv in följande och tryck Enter:**
```bash
sudo apt update
sudo apt install git curl xz-utils gdisk parted e2fsprogs grub-pc -y
```
*(Detta installerar alla verktyg som behövs. Klistra rakt in och tryck Enter!)*

### **d) Ladda ner skriptet från GitHub**
```bash
git clone https://github.com/Karacsonyi-Endre/haos-non-uefi.git
cd haos-non-uefi
```

---

## **2. Sätt in mål-disken**

- Sätt i den SSD/HDD/USB-sticka som du vill använda som Home Assistant-disk.
- **VARNING: Alla data på denna raderas!**

---

## **3. Gör skriptet körbart**

```bash
chmod +x haos-non-uefi.sh
```

---

## **4. Starta skriptet**

```bash
sudo ./haos-non-uefi.sh
```

- Det är **viktigt med sudo** i början! Annars får skriptet inte rätt att skriva till disken.

---

## **5. Följ instruktionerna på skärmen (“tangentbordsval”)**

### **a) Välj HAOS-version**
- Skriptet visar olika versioner av Home Assistant OS. Skriv t.ex. “1” och tryck Enter för den senaste versionen, eller välj “EGEN_URL” om du vill ange en egen länk.

### **b) Välj mål-disk**
- Alla diskar listas med storlek/modell.
- Skriv numret för rätt disk och tryck Enter.

### **c) Bekräfta**
- Du får ännu en varning att disken raderas.
- Skriv exakt `yes` och tryck Enter för att fortsätta.

### **d) Vänta**
- Skriptet laddar ner, skriver och fixar klart allting automatiskt. Det kan ta några minuter beroende på din internet- och USB-hastighet.

---

## **6. Klart!**

- När det står **"KLART!"** eller **"Ready"**, är det färdigt.
- Dra ut disken, sätt in den i din gamla dator/server.
- Starta – Home Assistant laddar automatiskt!

---

## **Extra för nybörjaren**

- **Vad är en “terminal”?**  
  Det är ett textfönster där du kan klistra in kommandon direkt och köra dem.
- **Vad betyder “sudo”?**  
  “Super User DO” – du får extra rättigheter så att du får skriva till diskar, installera mm.
- **Måste jag välja exakt rätt disk?**  
  JA! Skriptet raderar annars allting på den disk du pekar ut. Läs noga i listan, kolla storlek och modell så det verkligen är rätt.

---

## **Vanliga frågor**

**Q: Kan detta förstöra min vanliga dator?**  
A: Inte om du VÄLJER RÄTT DISK. Var extra noga när valrutan visas!

**Q: Måste jag installera Ubuntu?**  
A: Nej! Starta bara från USB och välj “Testa Ubuntu”. Då riskerar du inget på din vanliga dator.

**Q: Jag får “permission denied” eller “no such file”?**  
A: Kontrollera stavning, att du är i rätt katalog (`cd haos-non-uefi`), och alltid börjar kommandon med `sudo` när du startar skriptet.

---

**Lycka till! Din Home Assistant-disk är klar på någon minut – och du kan göra om processen när som helst med en ny disk eller ny version.**




























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

- HAOS **version 17.1** success on: ThinkPad X61s, HP DC5100, old Dell x86-64, IBM servers/desktops, others.
- Tested with: SSDs, IDE, SATA, USB adapters.
- Insert the disk into any BIOS machine and boot — if everything works - HAOS will **install/boot/start automatically** without your intervention!

---

### **Complete Usage Workflow**

1. Boot Ubuntu (Live USB or installed).
2. Attach your target disk (warning—all data will be lost!).
3. Copy and run this script (`sudo ./haos_bios_factory_final.sh`).
4. Choose your correct disk to DELETE (e.g., sda/sdb), confirm.
5. Wait for finish—all steps handled automatically.
6. Move disk to any BIOS-only (non-UEFI) machine and boot: **HAOS will install/boot/start automatically!**

---

### **Community Acknowledgement / Credits**

- This solution is based on [Home Assistant issue #39584](https://github.com/home-assistant/home-assistant.io/issues/39584).
- Represents true community reverse engineering.

---

_Last updated: 7 March 2026_ Best regards, Endre Karacsonyi

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
    - Hämtar från GIT-hub (eller läser från egen server) en xz-komprimerad HAOS-image (t.ex. v13.0), paketerad av Home Assistant-teamet.
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

- Version 17.1 fungerar perfekt på: X61s, HP DC5100, äldre Dells, IBM server/desktop x86-64, m.fl.
- Testat: SSD, IDE, SATA, USB-adapter
- Du får ocensurerad HAOS-upplevelse med full Addon/Supervisor-stöd (ej möjligt i container/lxc-docker på dessa maskiner).

---

### **Full Installation Workflow**

# Steg-för-steg: Skapa Home Assistant OS-disk med `haos-non-uefi.sh` (för HELT nya Linux-användare)

---

## **1. Ladda ner skriptet**

### **a) Starta Ubuntu (eller liknande Linux) på datorn**
- **Live USB**? Välj alltid "Testa Ubuntu" eller "Try Ubuntu" när du bootar från stickan, INTE "Installera Ubuntu".

### **b) Öppna “Terminal”**
- Klicka på menyn uppe till vänster och skriv “Terminal” (eller tryck **Ctrl+Alt+T**).

### **c) Skriv in följande och tryck Enter:**

```bash
sudo apt update
sudo apt install git curl xz-utils gdisk parted e2fsprogs grub-pc -y
```
*(Detta installerar alla verktyg som behövs. Klistra rakt in och tryck Enter!)*

### **d) Ladda ner skriptet från GitHub**
```bash
git clone https://github.com/Karacsonyi-Endre/haos-non-uefi.git
cd haos-non-uefi
```

---

## **2. Sätt in mål-disken**

- Sätt i den SSD/HDD/USB-sticka som du vill använda som Home Assistant-disk.
- **VARNING: Alla data på denna raderas!**

---

## **3. Gör skriptet körbart**

```bash
chmod +x haos-non-uefi.sh
```

---

## **4. Starta skriptet**

```bash
sudo ./haos-non-uefi.sh
```

- Det är **viktigt med sudo** i början! Annars får skriptet inte rätt att skriva till disken.

---

## **5. Följ instruktionerna på skärmen (“tangentbordsval”)**

### **a) Välj version**
- Skriptet visar olika versioner av Home Assistant OS. Skriv t.ex. “1” och tryck Enter för den senaste versionen, eller välj “EGEN_URL” om du vill ange en egen länk.

### **b) Välj mål-disk**
- Alla diskar listas med storlek/modell.
- Skriv numret för rätt disk och tryck Enter.

### **c) Bekräfta**
- Du får ännu en varning att disken raderas.
- Skriv exakt `yes` och tryck Enter för att fortsätta.

### **d) Vänta**
- Skriptet laddar ner, skriver och fixar klart allting automatiskt. Det kan ta några minuter beroende på din internet- och USB-hastighet.

---

## **6. Klart!**

- När det står **"KLART!"** eller **"Ready"**, är det färdigt.
- Dra ut disken, sätt in den i din gamla dator/server.
- Starta – Home Assistant laddar automatiskt!

---

## **Extra för nybörjaren**

- **Vad är en “terminal”?**  
  Det är ett textfönster där du kan klistra in kommandon direkt och köra dem.
- **Vad betyder “sudo”?**  
  “Super User DO” – du får extra rättigheter så att du får skriva till diskar, installera mm.
- **Måste jag välja exakt rätt disk?**  
  JA! Skriptet raderar annars allting på den disk du pekar ut. Läs noga i listan, kolla storlek och modell så det verkligen är rätt.

---

## **Vanliga frågor**

**Q: Kan detta förstöra min vanliga dator?**  
A: Inte om du VÄLJER RÄTT DISK. Var extra noga när valrutan visas!

**Q: Måste jag installera Ubuntu?**  
A: Nej! Starta bara från USB och välj “Testa Ubuntu”. Då riskerar du inget på din vanliga dator.

**Q: Jag får “permission denied” eller “no such file”?**  
A: Kontrollera stavning, att du är i rätt katalog (`cd haos-non-uefi`), och alltid börjar kommandon med `sudo` när du startar skriptet.

---

**Lycka till! Din Home Assistant-disk är klar på någon minut – och du kan göra om processen när som helst med en ny disk eller ny version.**


### **Community-acknowledgement**

Denna lösning är baserad på [Home Assistant-dokumentationens issue #39584](https://github.com/home-assistant/home-assistant.io/issues/39584).  
Det är genuin community reverse engineering på ett OS som annars exkluderar gammal hårdvara.  

---

