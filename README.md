# Auslender SI

**Mobilni pomočnik za tuje študente v Sloveniji.**

Auslender SI je spletna in mobilna aplikacija (PWA + Android APK), ki tujim študentom pomaga pri urejanju ključnih administrativnih postopkov v Sloveniji. Namesto iskanja razpršenih informacij po različnih portalih aplikacija združuje preverjena navodila po korakih, sezname potrebnih dokumentov, povezave do uradnih obrazcev ter AI asistenta na enem mestu.


## Glavne funkcionalnosti

* **Dostop za vse uporabnike (tudi brez prijave):** Pregled postopkov, korakov, seznama dokumentov, uradnih obrazcev in uporaba AI asistenta brez obvezne registracije.
* **Prilagoditev glede na državljanstvo:** Samodejno filtriranje korakov in dokumentov za državljane EU ter državljane tretjih držav (ne-EU).
* **Interaktivni vodnik po korakih (Roadmap):** Jasen pregled poteka postopka od začetka do konca.
* **Seznam potrebnih dokumentov in podrobnosti:** Pojasnila o namenu dokumenta, načinu pridobitve, pristojni ustanovi ter neposredne povezave za prenos uradnih obrazcev.
* **Sledenje napredku (prijavljeni uporabniki):** Označevanje opravljenih korakov in pripravljenih dokumentov z vizualnim prikazom napredka.
* **Opomniki in obvestila (prijavljeni uporabniki):** Nastavitev opomnikov za pomembne roke in dokumente z obveščanjem prek e-pošte in potisnih obvestil (Push).
* **AI asistent (RAG):** Odgovarjanje na vprašanja uporabnikov izključno na podlagi preverjenih virov z navedbo povezav do uradnih dokumentov.
* **Večjezična podpora:** Uporabniški vmesnik in vsebine v slovenskem (`SL`), angleškem (`EN`) in srbskem (`SR`) jeziku.

---

## Tehnološki sklad

| Plast | Tehnologija |
|---|---|
| **Frontend (PWA)** | React (Vite), TypeScript, Tailwind CSS |
| **Mobilna aplikacija (APK)** | Capacitor |
| **Backend & Baza podatkov** | Supabase (PostgreSQL, Auth, Edge Functions, `pgvector`) |
| **AI Asistent** | Google Gemini API (RAG arhitektura) |
| **Obvestila** | E-pošta in potisna obvestila (Push) prek Supabase Edge Functions |
| **Gostovanje** | Vercel / Netlify |

---

## Dokumentacija

Podrobnejša projektna in tehnična dokumentacija se nahaja v mapi `dokumentacija/`:

* [Opis projekta, funkcionalnosti in delovni tok](dokumentacija/opis-in-funkcionalnosti.md)
* [Arhitektura sistema in načrtovane tehnologije](dokumentacija/arhitektura-in-tehnologije.md)
* [Začetni podatkovni model](dokumentacija/podatkovni-model.md)

---

## Ekipa

* **Filip Sekulović**
* **Lola Novaković**
* **Veljko Stojanović**

---

## Stanje projekta

Začetna struktura vsebuje spletni vmesnik, projekt Android in migracijo Supabase. Lokalni začetni podatki vsebujejo nazive in kratke opise treh načrtovanih postopkov v slovenščini, angleščini in srbščini. Uporabniške funkcionalnosti iz dokumentacije so načrt za MVP.

## Kako zagnati projekt lokalno

- `frontend/` vsebuje React, TypeScript, Tailwind CSS, konfiguracijo PWA in odjemalca Supabase.
- `frontend/android/` vsebuje nativni projekt Capacitor.
- `backend/supabase/` vsebuje konfiguracijo, migracije in lokalne začetne podatke.

Za lokalni razvoj na Windows potrebuješ Node.js 22.12+ iz veje 22 ali Node.js 24+ ter Docker Desktop. Ukaze zaženi v PowerShellu.

### 1. Zaženi Supabase

Odpri Docker Desktop in počakaj, da se zažene. Nato iz korena repozitorija zaženi naslednje ukaze.

```powershell
cd backend
npx.cmd supabase@3.2.0 start
npx.cmd supabase@3.2.0 status
```

[Supabase Studio](http://127.0.0.1:54323/) omogoča pregled lokalne baze.

### 2. Nastavi povezavo s Supabase

Ob prvi nastavitvi v novem terminalu iz korena repozitorija kopiraj predlogo. Če `frontend/.env.local` že obstaja, ga odpri neposredno.

```powershell
Copy-Item frontend/.env.example frontend/.env.local
```

V `frontend/.env.local` nastavi `VITE_SUPABASE_URL` na **Project URL** iz izpisa `status` (privzeto `http://127.0.0.1:54321`) in `VITE_SUPABASE_PUBLISHABLE_KEY` na ključ **Publishable** iz istega izpisa.

### 3. Zaženi spletni vmesnik

V terminalu iz korena repozitorija zaženi naslednje ukaze.

```powershell
cd frontend
npm.cmd ci
npm.cmd run dev
```

Odpri [Auslender SI](http://127.0.0.1:5173/). Za ponovni zagon po prvi namestitvi zaženi Supabase in nato `npm.cmd run dev` iz mape `frontend/`.

### Preizkus PWA

V mapi `frontend/` zaženi `npm.cmd run build` in nato `npm.cmd run preview`. Predogled je privzeto na [vratih 4173](http://127.0.0.1:4173/), datoteke za objavo pa so v `frontend/dist/`.

### Android

Za gradnjo uporabi Android Studio, JDK 21 in Android SDK 36. V terminalu iz korena repozitorija zaženi naslednje ukaze po namestitvi odvisnosti v `frontend/`.

```powershell
cd frontend
npm.cmd run android:sync
npx.cmd cap open android
```

Za razvojni APK nastavi `JAVA_HOME` na JDK 21 in zaženi naslednje ukaze iz mape `frontend/android/`. Nastavi `ANDROID_HOME` na dejansko lokacijo SDK, če se razlikuje od privzete.

```powershell
$env:ANDROID_HOME = Join-Path $env:LOCALAPPDATA 'Android/Sdk'
.\gradlew.bat assembleDebug
```

Gradle shrani APK v `frontend/android/app/build/outputs/apk/debug/`.
