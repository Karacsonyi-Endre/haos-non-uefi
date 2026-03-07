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
- **Live USB?** [Download Ubuntu Desktop here](https://ubuntu.com/download/desktop)
- Välj alltid "Testa Ubuntu" eller "Try Ubuntu" när du bootar från stickan, INTE "Installera Ubuntu".

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
- Skriptet visar olika versioner av Home Assistant OS. Skriv t.ex. “1” och tryck Enter för den senaste versionen, eller välj “MY_URL” om du vill ange en egen länk.

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

- När det står **"HAOS DISK READY AND BOOTABLE!"**, är det färdigt.
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


