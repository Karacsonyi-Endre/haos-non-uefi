# Kézikönyv: Kész HAOS indítólemez BIOS rendszerekhez

> **Ez nem "image készítési útmutató" – ez egy olyan eszköz, amely egy fizikai lemezt egyetlen lépésben átalakít egy használatra kész HAOS boot lemezzé régi BIOS-os gépek számára.**
>
> Itt a kézikönyv a `haos-non-uefi.sh` script használatához, hogy elkészítse a saját indítólemezét.
>
> **Ez a script elvégzi a nehéz munkát:** letölti a hivatalos HAOS képfájlt, kiírja a merevlemezre, majd telepít egy speciális GRUB bootloadert, hogy régi PC-d is képes legyen modern GPT partíciós lemezről indulni.

---

## Miért jobb ez?

A script célja az emberi hibák kizárása. Automatikusan listázza az összes elérhető lemezt, engedi kiválasztani a megfelelőt, így kizárja annak kockázatát, hogy véletlenül rossz partíciót írunk felül. Tökéletesen lemásolja a hivatalos HAOS telepítést, viszont hozzáadja azt a "BIOS kulcsot", amivel a régi hardver fel tudja ismerni és indítani.

---

## Miért EZ az igazi megoldás?

A script beilleszt egy hibrid MBR-t: a BIOS így régi típusú indítólemeznek látja, de a tényleges adat modern GPT (amit a HAOS elvár). Így a régi hardvered is teljes értékű, hivatalos HAOS élményt nyújt – gyártók által már rég elhagyott gépeken is.

---

# Lépésről-lépésre: Home Assistant OS indítólemez készítése a `haos-non-uefi.sh` script-tel (TELJESEN kezdő Linux felhasználóknak)

---

## 1. Script letöltése

### a) Indíts Ubuntu-t (vagy más Linuxot) a gépeden
- **Live USB?** [Ubuntu Desktop letöltése itt](https://ubuntu.com/download/desktop)
- Mindig válaszd a "Try Ubuntu" vagy "Testa Ubuntu" opciót, ne az "Install Ubuntu"-t!

### b) Nyisd meg a terminált
- Kattints bal felső menüre és írd be: "Terminal" (vagy nyomd meg: **Ctrl+Alt+T**).

### c) Másold be és futtasd:
```bash
sudo apt update
sudo apt install git curl xz-utils gdisk parted e2fsprogs grub-pc -y
```
*(Ez minden szükséges eszközt telepít. Másold be, nyomj Entert!)*

### d) Töltsd le a script-et GitHub-ról
```bash
git clone https://github.com/Karacsonyi-Endre/haos-non-uefi.git
cd haos-non-uefi
```

---

## 2. Céllemez csatlakoztatása

- Tedd be azt az SSD/HDD/USB meghajtót, amit Home Assistant diszként akarsz használni.
- **FIGYELEM: Minden adat elvész erről a lemezről!**

---

## 3. Script futtathatóvá tétele

```bash
chmod +x haos-non-uefi.sh
```

---

## 4. Script indítása

```bash
sudo ./haos-non-uefi.sh
```
- **Fontos a sudo használata!** Egyébként a script nem fog tudni írni a lemezre.

---

## 5. Kövesd a képernyőn megjelenő utasításokat

### a) HAOS verzió kiválasztása
- A script menüben kínálja fel a Home Assistant OS verziókat. Írj be egy számot (pl. “1”) és Enter a legújabbhoz, vagy válaszd az “EGEN_URL” opciót saját linkhez.

### b) Céllemez kiválasztása
- Listázz minden lemez mérettel/modelllel. Írd be a megfelelő számot majd Enter.

### c) Megerősítés
- Utolsó figyelmeztetést kapsz, hogy a lemez törlődni fog.
- Írd be pontosan, hogy `yes`, majd Enter a folytatáshoz.

### d) Várj
- A script automatikusan letölti, kiírja, befejezi a folyamatot. Ez pár perc lehet a net/USB sebességétől függően.

---

## 6. Kész!

- Ha megjelenik a **"KLART!"** vagy **"Ready"** felirat, kész vagy!
- Húzd ki a lemezt, tedd be a régi PC-be vagy szerverbe.
- Indítsd be – a Home Assistant automatikusan indul!

---

## Extra infó kezdőknek

- **Mi az a “terminál”?**  
  Egy szöveges ablak, ahová közvetlenül beilleszthetsz és futtathatsz parancsokat.
- **Mit jelent az a “sudo”?**  
  “Super User DO” – jogosultságot ad lemezírásra, telepítésre stb.
- **Biztos a jó lemezt választom?**  
  IGEN! Ha nem, minden adat elveszik azon, amit kiválasztasz. Olvasd el a listát, nézd meg a méretét/modelljét!

---

## Gyakran ismételt kérdések

**K: Tönkreteheti ez a rendes gépemet?**  
V: Ha JÓLEMEZT választasz, nem! Különösen ügyelj a kiválasztásnál!

**K: Telepítenem kell Ubuntu-t?**  
V: Nem! Csak bootolj USB-ről és válaszd a “Try Ubuntu”-t. Az eredeti számítógéped nem érinti.

**K: “permission denied” vagy “no such file” hibát kapok?**  
V: Ellenőrizd a helyesírást, hogy a megfelelő mappában vagy (`cd haos-non-uefi`), és mindig `sudo`-val indítsd a scriptet!

---

**Sok sikert! A Home Assistant lemezed percek alatt elkészül – és bármikor újra elvégezheted új lemezzel vagy verzióval.**
