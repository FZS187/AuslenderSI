# Auslender SI – Načrt razvoja in razdelitev odgovornosti

Auslender SI je mobilna aplikacija za tuje študente v Sloveniji. Študent izbere administrativni postopek, pregleda korake in potrebne dokumente ter spremlja svoj napredek. Dodatna vprašanja lahko postavi AI asistentu, ki odgovori na podlagi preverjenih virov in jih prikaže ob odgovoru.

Projekt bomo razvijali v štirih fazah. Prva faza pokriva začetne naloge v GitHub Issues [#1–#10](https://github.com/FZS187/AuslenderSI/issues). Naslednje faze so predlog izvedbe na podlagi obsega v [README.md](../README.md). Za konkretne naloge teh faz bomo odprli ločene Issues.

## Razdelitev odgovornosti

| Član ekipe | Področje | Odgovornosti in začetni rezultati |
| --- | --- | --- |
| **Lola Novaković** | Frontend in uporabniška izkušnja | Pripravi diagram primerov uporabe ali opise ključnih uporabniških scenarijev ([#1](https://github.com/FZS187/AuslenderSI/issues/1)). Oblikuje makete ali prototip za izbiro postopka, vodič, seznam dokumentov in AI asistenta ter pokaže navigacijo med zasloni ([#2](https://github.com/FZS187/AuslenderSI/issues/2)). Na podlagi maket izdela uporabniški vmesnik z Reactom. |
| **Veljko Stojanović** | Backend, podatkovna baza in dokumentacija | Opiše ciljne uporabnike, obseg projekta in glavne funkcionalnosti ([#3](https://github.com/FZS187/AuslenderSI/issues/3)). Pripravi podatkovni model, arhitekturo in pregled predvidenih tehnologij ([#4](https://github.com/FZS187/AuslenderSI/issues/4)). Uredi povezave iz README-ja do dokumentacije v mapi `dokumentacija/` ([#5](https://github.com/FZS187/AuslenderSI/issues/5)). V nadaljevanju pripravi prijavo, podatke za vodiče in shranjevanje napredka. |
| **Filip Sekulović** | AI in GitHub | Uredi začetno strukturo repozitorija in način sodelovanja ([#6](https://github.com/FZS187/AuslenderSI/issues/6)), preveri dostop ekipe in asistenta pri predmetu ([#7](https://github.com/FZS187/AuslenderSI/issues/7)), uredi začetne Issues ([#8](https://github.com/FZS187/AuslenderSI/issues/8)), pripravi načrt razvoja ([#9](https://github.com/FZS187/AuslenderSI/issues/9)) ter vzpostavi GitHub Actions ([#10](https://github.com/FZS187/AuslenderSI/issues/10)). V nadaljevanju razvije AI asistenta in preveri kakovost odgovorov ter navedb virov. |

## Faze razvoja

### 1. Načrtovanje in priprava repozitorija

Lola opiše ključne uporabniške scenarije in jih uporabi pri pripravi maket. Veljko opredeli obseg in pripravi podatkovni model za postopke, korake, dokumente, vire in uporabniški napredek. Filip vzpostavi način dela v repozitoriju ter pripravi osnovna preverjanja ob odprtju ali posodobitvi pull requesta. Začetna preverjanja prilagodi datotekam, ki so že v repozitoriju, izvedbo pa potrdi s povezavo do uspešnega zagona v [#10](https://github.com/FZS187/AuslenderSI/issues/10).

**Rezultat faze** so uporabniški scenariji, makete z navigacijo, opredeljen obseg, začetna arhitektura in podatkovni model ter pripravljen repozitorij z dokumentacijo, dostopi, nalogami in delujočim preverjanjem v GitHub Actions.

### 2. Prvi delujoči postopek

Ekipa izbere en postopek iz README-ja in zanj zbere uradne vire ter pripravi korake in seznam dokumentov. Veljko omogoči prijavo, branje vodiča in shranjevanje napredka. Lola izdela pot od izbire postopka do vodiča in seznama dokumentov. Filip po vzpostavitvi projekta React v GitHub Actions doda preverjanje kode z `npm run lint`. Izvajanje testov vključi, ko so na voljo.

**Rezultat faze** je delujoč tok, v katerem se uporabnik prijavi, izbere postopek, odpre uradni vir, označi opravljen korak in po ponovnem odprtju aplikacije vidi shranjeni napredek.

### 3. Povezava z AI asistentom

Filip pripravi iskanje po preverjenih virih za izbrani postopek in sestavljanje odgovora iz najdenih odlomkov (RAG). Veljko in Filip se dogovorita, kako bo storitev pridobila vire za posamezen postopek. Lola v aplikaciji prikaže odgovor, povezave do virov in sporočilo za primer, ko viri ne zadoščajo.

**Rezultat faze** je asistent, ki za vprašanje iz vodiča prikaže odgovor z viri, pri vprašanju brez podlage v virih pa jasno sporoči, da nima dovolj informacij. Filip preveri oba primera in pri odgovorih preveri, ali navedeni viri podpirajo podane informacije.

### 4. Razširitev, preverjanje in oddaja

Ekipa po potrditvi prvega postopka doda še preostale postopke iz dogovorjenega obsega. Lola in Veljko uskladita prikaz dodatnih vodičev, jezikovne različice in opomnike. Filip preveri delovanje asistenta za dodane vodiče in poskrbi za avtomatizirana preverjanja ter gradnjo aplikacije za Android. Vsi trije pripravijo demonstracijo in pregledajo dokumentacijo.

**Rezultat faze** je različica za oddajo s preverjenimi uporabniškimi scenariji, posodobljeno dokumentacijo in pripravljeno demonstracijo.

## Ključne odvisnosti

| Pred začetkom dela | Kaj to omogoči |
| --- | --- |
| Dogovor o obsegu in ključnih uporabniških scenarijih ([#3](https://github.com/FZS187/AuslenderSI/issues/3), [#1](https://github.com/FZS187/AuslenderSI/issues/1)) | Lola lahko dokonča makete ([#2](https://github.com/FZS187/AuslenderSI/issues/2)), Veljko pa uskladi podatkovni model ([#4](https://github.com/FZS187/AuslenderSI/issues/4)). Začetne osnutke lahko pripravljata vzporedno. |
| Začetna struktura in dostopi ([#6](https://github.com/FZS187/AuslenderSI/issues/6), [#7](https://github.com/FZS187/AuslenderSI/issues/7)) | Člani lahko samostojno odpirajo veje in oddajajo pull requeste. Osnovna preverjanja se lahko uvedejo že pred pripravo projekta React ([#10](https://github.com/FZS187/AuslenderSI/issues/10)). |
| Dogovor o podatkih med aplikacijo in zaledjem | Lola lahko poveže zaslone z vodičem in shranjevanjem napredka. Veljko in Lola se dogovorita o podatkih, potrebnih za prikaz in označevanje korakov. |
| Prvi vodič s preverjenimi viri in dogovorjen format odgovora | Filip lahko preveri odgovore za ta postopek, Lola pa poveže prikaz odgovora in virov z AI storitvijo. |
| Uspešen preizkus prvega postopka od prijave do shranjenega napredka in odgovora AI | Ekipa lahko isti način izvedbe uporabi pri preostalih postopkih. |

## Način sodelovanja

Vsaka naloga ima GitHub Issue z opisom, merili sprejema, odgovorno osebo in prioriteto. Član za nalogo odpre vejo, v pull requestu navede povezani Issue in opiše, kako je preveril rezultat. Spremembo pred združitvijo v `main` pregleda drug član ekipe. Naloga je zaključena, ko so merila sprejema izpolnjena in je rezultat dostopen v repozitoriju.
