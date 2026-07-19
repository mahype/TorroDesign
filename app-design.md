# Torro Apps — Designsprache

Wie eine Torro-App aussieht und spricht. Destilliert aus **TorroMail**, der
Referenz-Implementierung, und gedacht für alle Apps der Familie — als Nächstes
TorroWhisper. Die Markenbausteine selbst (Logo, Farben, Schrift) stehen im
[README](README.md) und im interaktiven [`design-guide.html`](design-guide.html);
hier steht, wie daraus eine App wird.

Alle Maße in Punkten (pt). Referenzquelle im Code:
`TorroMail/apps/TorroMailApp/Sources/TorroMailApp/TorroMailApp.swift` —
die wiederverwendbaren Bausteine liegen als Drop-in unter
[`swift/TorroBrandUI.swift`](swift/TorroBrandUI.swift), die Werte
maschinenlesbar im `app`-Block von [`tokens/tokens.json`](tokens/tokens.json).

---

## Haltung

1. **Entscheidungen statt Optionen.** Die Oberfläche zeigt, was zu entscheiden
   ist und was gerade passiert — in der Sprache des Nutzers. Mechanik,
   Prozesszustände und Fehlerdetails gehören ins Log, nicht auf die Fläche.
   Status wird als Antwort auf die Frage des Nutzers formuliert
   („Bereit für Assistenten"), nie als Prozesszustand („Server: running").
2. **Nativ zuerst.** Systemcontrols, Systemschrift, Systemverhalten. Die Marke
   gestaltet das Betriebssystem nicht um — sie setzt Akzente.
3. **Ein lauter Markenmoment pro Fenster.** Der Hero (rote Fläche, Wortmarke,
   ein Satz Klartext) ist die eine Stelle, an der die Marke laut sein darf.
   Alles Übrige bleibt ruhiges macOS-Material.

---

## Farbe

### Rot ist Marke, nie Status

- **Torro-Rot `#D50C0C`** ist der App-weite Akzent (Tint): Auswahl,
  Zähler-Badges, vereinzelte Text-Akzente (z. B. „Log öffnen").
- **Buttons bleiben Standard-macOS.** Der rote Tint färbt bei Systemknöpfen
  die Beschriftung statt der Fläche — roter Text auf dunklem Grund ist unlesbar
  und **nie** erlaubt. Ein Button sieht immer aus wie der neutrale System-Knopf:
  graue Fläche, helle Beschriftung (`.bordered`, Tint aus). Kein Button trägt
  seine Bedeutung über die Textfarbe — schon gar nicht über Markenrot.
  `borderedProminent` gibt es genau einmal: als Primär-Button im Wizard-Footer.
- **Rot als Fläche** nur im Hero und auf den Kachel-Badges der „eigenen Sache"
  (siehe Bausteine).
- Destruktives läuft über die System-Rolle (`role: .destructive`), nicht über
  Markenrot.

### Statusfarben — Systemfarben, feste Bedeutung

| Farbe | Bedeutung | Beispiele |
|-------|-----------|-----------|
| **Grün** | geprüft, verbunden, in Ordnung | Zugangsdaten verifiziert, Server läuft, Check bestanden |
| **Orange** | wartet auf den Nutzer, ungeprüft, Abweichung | Verbindung nie getestet, Schlüssel fehlt, Ordner-Ausnahme („angepasst") |
| **Rot** | kaputt, abgelehnt | Login schlägt fehl, Server antwortet nicht |
| **Grau** | nicht eingerichtet, nicht vorhanden | Kein Konto konfiguriert, Client nicht installiert |

Native Apple-Apps nehmen die **Systemfarben** (sie passen sich hell/dunkel an);
für Web/Sonstiges stehen die Hex-Werte in `tokens/tokens.json` → `app.status`.
Markenrot ist **nie** Statusfarbe — Rot als Status ist Systemrot.

---

## Typografie

- **UI komplett in der Systemschrift** (SF Pro). Frutiger ist Markenschrift,
  keine UI-Schrift.
- **Frutiger LT 95 UltraBlack** erscheint ausschließlich in der Wortmarke
  (Hero, Sidebar-Fuß). Die App liefert den Schnitt als Ressource mit und
  registriert ihn prozess-lokal — er landet nicht in der Schriftsammlung
  des Nutzers. Fallback: schwere Systemschrift.

Rollen der Systemschrift:

| Rolle | Schnitt | Einsatz |
|-------|---------|---------|
| Titel in Karte | `headline` | Name eines Kontos, Clients, Eintrags |
| Zustands-/Zusammenfassungszeile | `subheadline`, sekundär | „Verbunden", „Läuft im Hintergrund" |
| Karten-Titel (außen) | `subheadline` semibold, sekundär | Überschrift über einer Karte |
| Meta, Fußnoten, Hinweise | `caption`, sekundär | Erklärsätze unter Karten und Formularen |
| Chips | `caption` / `caption2` | Presets, „Neu", „angepasst" |
| Zahlen, Uhrzeiten, Countdown | `monospacedDigit` | Log-Zeiten, Zähler, „läuft ab in…" |
| Code, Pfade, Snippets | `caption` monospaced | Config-Snippets, Dateipfade |

---

## Fläche & Tiefe — das Kartensystem

### Grund und Fläche

Inhaltsseiten liegen auf dem **sekundären Fenstergrund** (`background.secondary`);
Karten darauf auf dem **primären Grund** (`background`). Detail- und
Einstellungsseiten sind stattdessen gruppierte Formulare (macOS
`Form`/`grouped`) — dort übernimmt das System die Flächen.

### Die Torro-Karte

Die erhabene Fläche, auf der jedes Panel sitzt:

- Eckenradius **12**, kontinuierlich (Code-Block: **8**; der Hero ist
  randlos, siehe unten).
- Füllung: primärer Grund.
- **Zwei Schatten** (Umgebungs- + Kontaktschatten), am Hintergrund der Karte,
  nie am Inhalt — sonst wirft jedes Label mit:
  hell `schwarz 14 % / r 5 / y 3` + `schwarz 5 % / r 1 / y 1`,
  dunkel `schwarz 50 % / r 5 / y 3` + `schwarz 30 % / r 1 / y 1`.
- **1-pt-Randlinie mit Vertikalverlauf** — oben belichtet, nach unten
  auslaufend: hell `weiß 90 % → schwarz 10 %`,
  dunkel `weiß 20 % → weiß 5 %`.
- **Hover** (klickbare Karten): Randlinie verstärkt
  (hell unten `schwarz 18 %`, dunkel `weiß 34 % → 10 %`),
  Übergang `easeOut 0,12 s`. Die ganze Karte ist die Klickfläche,
  rechts ein Chevron (tertiär, semibold, 11–12 pt).

### Benannte Karte

Titel und Fußnote stehen **außerhalb** der Karte: Titel darüber
(`subheadline` semibold, sekundär), optional rechts daneben eine kleine
Aktion (roter Klartext-Link), Fußnote darunter (`caption`, sekundär).
Innenabstand der Karte: horizontal 14, Zeilen vertikal 7–11, Trennung durch
`Divider` in voller oder eingerückter Breite.

### Der Hero

Der eine laute Markenmoment (Werte aus TorroMail):

- **Randlos** oben im Inhalt: bündig an **Fensteroberkante, rechter Kante und
  Seitenleiste** — kein dunkler Rand, **kein Außenradius, keine Randlinie,
  keine Margin**. Die Fensterecke beschneidet ihn oben rechts; die übrigen
  Ecken sind gerade. Keine schwebende Karte.
- Verlauf `#D50C0C → #A50A0A`, diagonal (oben links → unten rechts).
- Innen: Wortmarke (Versalhöhe 15), darunter **ein Satz Klartext in einer
  Zeile** in Weiß 92 % (`callout`) — was die App tut.
- **Signet als Wasserzeichen**: weiß ~10 %, rechts **angeschnitten** — vom
  Header beschnitten, nie frei schwebend.

### Wortmarke im Produkt

Aufbau wie die TORROFORMS-Wortmarke: Hörner beidseitig, Name im Display-Schnitt,
**„TORRO" weiß, Produktname silber `#C4C3C3`**. Proportionen aus der
Versalhöhe abgeleitet: Hornhöhe = 2 × Versalhöhe, Hörner enden auf der
Grundlinie, Abstand ≈ 0,14 × Versalhöhe, Schriftgröße = Versalhöhe / 0,7.
Am Fuß der Sidebar sitzt sie **still** (ohne eigenen Grund), **zentriert mit
gleichem Abstand links und rechts** und etwas größer als eine Fußnote — die
ruhige Signatur; das Rot gehört dem Hero.

---

## Layout

### Fenster — ein Bauplan für alle Apps

Jede App der Familie hat denselben Aufbau: **oben der rote Header** mit der
Wortmarke, **links die Seitenleiste** als Menü, **rechts der Inhalt** auf
ruhigem Material. Nur Wortmarke, Icons und Inhalt wechseln — Proportionen und
Chrome bleiben gleich.

- Hauptfenster mindestens **1080 × 660**, `NavigationSplitView`.
  System-Eckenradius, großer weicher Umgebungsschatten — ein Fenster, das
  über der Fläche schwebt.
- **Titelleiste nativ und minimal**, mit der Seitenleiste zu einer Fläche
  vereinheitlicht: System-Ampel links, Seitenleisten-Umschalter rechts. Keine
  eigene Toolbar, keine Markenfarbe — die Chrome bleibt macOS.
- Sidebar **200–280** (ideal 220), SF-Symbole; der aktive Eintrag ist die
  eine Stelle, an der Rot als Auswahl-Tint sitzt; unten der stille
  Wortmarken-Fuß, **zentriert mit gleichem Abstand links und rechts**.
- **Die Seitenleiste ist eine deckende Fläche, kein durchscheinendes
  Material** — Systemfenster-Grau (`windowBackgroundColor`, folgt hell/dunkel),
  darüber der leichte Schlagschatten zur Inhaltsspalte
  (`schwarz 12 % / r 6 / x 2`). Grund ist Verlässlichkeit: das
  Seitenleisten-Material blendet gegen den Fensterhintergrund und fällt genau
  auf dieses Grau zurück, sobald der Compositor nicht sampeln kann — erste
  Frames nach dem Öffnen, Fenster nicht im Fokus, Mission Control,
  Bildschirmaufnahme. Die Fläche wechselte also ohnehin zwischen zwei
  Zuständen; wir nehmen den stabilen. Das bleibt „Nativ zuerst": es ist die
  Systemfarbe, nur nicht mehr durchscheinend. Baustein:
  [`torroSidebar()`](swift/TorroBrandUI.swift).
- Bereiche der App als Sidebar-Einträge; zählbares Offenes als Badge am
  Eintrag (z. B. wartende Freigaben).
- **Der Hero sitzt randlos oben im Inhalt** — bündig an Fensteroberkante,
  rechter Kante und Seitenleiste, ohne dunklen Rand. Der eine laute
  Markenmoment pro Fenster (Werte siehe „Der Hero").

### Inhaltsspalte

- Inhalt in einer zentrierten Spalte, **maximal 720 breit**, Außenabstand
  **20**, Kartenabstand **10**, Abschnittsabstand **12–16**.
- **Listen sind Kartenlisten** (eine Karte pro Eintrag), keine Tabellen —
  Tabellen nur fürs Log.
- **Wächst ein Set kompakter Karten** (Kurzstatus, keine Aktionen in der
  Zeile), wechselt die Liste auf **zwei gleiche Spalten**: halbe Breite minus
  Spaltenabstand 10. So wächst das Feld, ohne dass die Seite in die Länge
  schießt. Einspaltig bleibt, was pro Zeile Detail und Gewicht trägt.

### Detailseiten

Gruppierte Formulare (`formStyle(.grouped)`): Abschnitte mit Header,
Erklärsätze als Footer in `caption`. Zeilenmuster „Rechtegruppe":
Symbol (sekundär, feste Breite 20) · Titel + Zusammenfassungszeile ·
rechts der Schalter, Unterpunkte eingerückt (32) unter ihrer Gruppe.

### Wizard / Sheet

Fester Rahmen **520 × 420**: Kopf (Symbol in Markenrot · Titel `headline` ·
Untertitel `caption`) — `Divider` — Inhalt — `Divider` — Fuß.
Im Fuß: links die Fehlermeldung (`caption`, sekundär, mit Warn-Symbol),
rechts `Abbrechen` und **ein** Primär-Button (`borderedProminent`).

- **Warteschritte** sind eigene Schritte: großer Spinner + ein Satz, was
  gerade passiert („Prüfe die Verbindung…").
- **Ausweichfelder** (manuelle Serverdaten) liegen hinter einer
  `DisclosureGroup` — zugeklappt, wenn die Automatik lief; aufgeklappt,
  wenn sie leer ausging. Escape-Hatch, nicht Normalweg.
- Abbruch räumt restlos auf; nichts Halbkonfiguriertes erreicht die App.

**Das gilt für Sheets, die etwas *committen*.** Eine Fläche, die direkt ins
Model schreibt — Einstellungs- und Verwaltungs-Sheets, bei denen jede Änderung
sofort greift —, ist kein Wizard:

- Sie trägt **nur „Fertig"**, kein „Abbrechen". Ein Abbrechen, das nichts
  zurücknimmt, täuscht Zurücknehmbarkeit vor; das ist schlimmer als der fehlende
  Knopf.
- Der **feste Rahmen 520 × 420 gilt für sie nicht.** Listen von Konten, Modellen
  oder Schlüsseln brauchen Platz; sie werden nach Inhalt bemessen. Der feste
  Rahmen ist die Wizard-Disziplin, keine Sheet-Disziplin.
- Kopf, `Divider` und Fehler-Slot im Fuß bleiben identisch — die Chrome ist
  dieselbe, nur die Fuß-Knöpfe und das Maß unterscheiden sich.

Wer Zurücknehmbarkeit *will*, macht die Fläche zum Wizard: auf einem Entwurf
arbeiten und erst beim Primär-Button schreiben. Dann gilt die Spec oben wieder
vollständig.

---

## Bausteine

### Kachel-Badges — eigen rot, fremd neutral

Abgerundetes Quadrat (Radius = **0,24 × Kantenlänge**, kontinuierlich),
SF-Symbol ≈ 0,4 × Kantenlänge, semibold. Standardgröße 34, kompakt 26.

- **Die eigene Sache** (Mailkonto, eigener Server): Markenrot als Verlauf,
  Symbol weiß, Hauch Schatten (`schwarz 20 % / r 1,5 / y 1`).
- **Fremde** (Assistenten, Dritt-Clients): neutrale Systemfläche
  (`quaternary`), Symbol sekundär — die Marke färbt nicht auf Fremde ab.
  Nicht installierte Fremde: Symbol tertiär (gedimmt).

### Statuspunkt

Kreis **8–9 pt** in Statusfarbe, in Listenzeilen vor dem Chevron. Immer mit
Tooltip und Accessibility-Label — der Punkt allein erklärt sich nicht.

### Status-Kachel

Punkt (eigene Spalte) + Titel (`headline`) + ein Satz Zustand
(`subheadline`, sekundär) auf einer Torro-Karte. Unabhängige Dienste stehen
als Kacheln **nebeneinander**, nicht als Liste übereinander.

### Chips & Kapseln

| Chip | Form | Einsatz |
|------|------|---------|
| Zähler | Kapsel in Tint, weiße `caption`, Ziffern monospaced | wartende Aktionen an einer Karte |
| „Neu" | Kapsel Markenrot, weiße `caption2` bold | News-Einträge |
| Ausnahme | Kapsel Orange 16 %, Text orange, `caption2` | „angepasst" an Ordnerregeln — Klick setzt auf Standard zurück |
| Neutral | Kapsel Primär 6 %, Text sekundär | „Standard" |

### Preset-Chips (Chip-Strip)

Benannte Profile als kompakter Strip — wie ein Segmented Control, mit dem
einen Unterschied, den ein Segmented Control nicht kann: **im
Custom-Zustand ist nichts ausgewählt.** Grund `quaternary 60 %`, Radius 7,
Innenabstand 2; aktiver Chip: primäre Fläche, Haarlinie (`separator`),
Radius 5, Text primär; inaktive Chips sekundär. Ein Control an allen
Orten — die Wahl aus dem Setup findet der Nutzer später identisch wieder.

### Schritt-Zeile (Onboarding)

Nummernkreis **18 pt** in Markenrot (weiße `caption` bold, monospaced) +
Titel (`headline`) + Erklärsatz (`subheadline`, sekundär). Danach genau
**ein** Button für den nächsten Schritt.

Das beschreibt die **eine Schritt-Zeile im Inhalt** — den Schritt, auf dem der
Nutzer gerade steht. Steht dieselbe Zeile als **Navigations-Rail** (alle Schritte
untereinander, erledigte mit Haken), bleiben Kreis und Ziffern wie oben, aber der
Titel geht auf `subheadline` zurück und der Erklärsatz entfällt: fünf `headline`-
Zeilen nebeneinander wären lauter als der Inhalt, den sie begleiten. Der aktive
Eintrag trägt das Gewicht (`semibold`), nicht die ganze Liste.

### Check-Zeilen (Selbsttest)

`checkmark.circle.fill` grün = bestanden · `circle` sekundär = offen ·
`xmark.circle.fill` rot = fehlgeschlagen — daneben ein Klartext-Satz,
bei Fehlern darunter die Ursache in `caption` sekundär.

### Code-Block

Monospaced `caption` auf `Primär 5 %`, Radius 8, Haarlinie (`separator`),
Innenabstand 12. **Scrollt horizontal statt umzubrechen** — ein langer Pfad
zerreißt das Snippet nicht. Geheimnisse (Schlüssel) sind auf dem Schirm
**maskiert**; „Schlüssel zeigen" ist ein bewusster Klick, kopiert wird
immer der echte Wert. Angezeigter und kopierter Text sind sonst identisch.

### Leere Zustände

Ganze Fläche leer: System-Empty-State (`ContentUnavailableView`) mit Symbol,
Titel und einem Satz, **was hier erscheinen wird**. Leere Karte: ein
sekundärer Satz in der Karte („Noch keine Aktivität. Sie erscheint hier,
sobald ein Assistent etwas tut.").

---

## Sprache

- **Ganze Sätze, Nutzerperspektive.** „Bereit für Assistenten" statt
  „MCP-Server: running". „Nicht erreichbar für Assistenten" statt „Prozess
  beendet".
- **Ereignisse in Klartext.** Interne Namen werden übersetzt:
  `mail_get_message` → „Hat eine Nachricht gelesen". Ergebnis binär und
  menschlich: „Ausgeführt" / „Abgelehnt". Unbekanntes zeigt seinen rohen
  Namen — besser als nichts.
- **Fehler sind Diagnosen, keine Entscheidungen.** Sie erscheinen als
  Fußnote/Label am Ort des Geschehens und im Log — nicht als modaler Alert.
- **Destruktive Dialoge nennen die Konsequenz.** „Das entfernt nur die
  Konfiguration aus TorroMail. Deine Mail bleibt auf dem Server."
- **Warnungen vorwegnehmen.** Wenn ein Fremd-Dialog erschrecken wird
  (Googles „nicht verifiziert"), sagt die App es vorher — ein erwarteter
  Schritt statt eines Fehlers.
- **Sicherheit in einem Satz, wo sie entsteht.** „Jeder Zugriff wird
  protokolliert." · „Der Schlüssel ist wie ein Passwort zu behandeln."
- Entwicklungssprache Englisch, Übersetzungen pro Sprache
  (`Localizable.strings`); Fachbegriffe wie MCP bleiben stehen, alles
  andere wird übersetzt.

---

## Übernehmen in eine neue App

1. **Tokens**: Farben aus `tokens/` (Marke) und `app`-Block (Status, Maße).
2. **Swift-Shell**: [`swift/TorroBrandUI.swift`](swift/TorroBrandUI.swift)
   einkopieren — Wortmarke (Produktname parametrisiert), Hörner, Signet,
   Hero, Torro-Karte, Button-Stil, Kachel-Badge. Frutiger-UltraBlack-TTF
   (`fonts/frutiger/LTe50335.ttf`) als `FrutigerLT-UltraBlack.ttf` in die
   App-Ressourcen legen und beim Start registrieren.

   ⚠️ **Das Drop-in hinkt dieser Prosa hinterher**: es enthält noch den Hero
   als schwebende Karte (Radius 14, weiße Randlinie), während oben unter
   „Der Hero" der **randlose** Hero steht. Bei Konflikt gilt dieser Text, nicht
   die Datei — und wer die Datei einkopiert, prüft den Hero danach gegen
   „Der Hero". Gleiches gilt für Apps ohne Frutiger-Lizenzweitergabe (Open
   Source): dort UI-Systemschrift, die Wortmarke im schwersten Systemschnitt.

   Dass einzelne Bausteine des Drop-ins in einer App **keinen Aufrufer** haben
   (Hover für klickbare Karten, Zähler-Chips), ist in Ordnung und kein toter
   Code: die Shell bildet das Vokabular vollständig ab, damit die nächste Fläche
   es vorfindet. Nicht „aufräumen".
3. **App-Icon** nach dem Familien-System (siehe Design-Guide, Sektion 08):
   Hörner-Signet oben, Funktions-Glyph darunter — beide weiß auf rotem
   Verlauf. Nicht von Hand bauen, sondern aus dem Master erzeugen:

   ```
   logo/icon-square/products/build-appicons.sh torrowhisper
   ```

   liefert `torrowhisper.icns` (macOS) und `AppIcon.appiconset`
   (iOS/iPadOS) aus denselben Vektoren. Master:
   `logo/icon-square/products/<app>-icon.svg` (randlos) und
   `.../macos/<app>-icon-macos.svg` (824er Squircle auf transparenter
   1024er Leinwand).

   **Der rote Träger ist die äußerste sichtbare Fläche.** Ringsum bleibt
   die Leinwand transparent — nie weiß. Eine weiße Platte darunter wird
   im Dock zum weißen Rahmen, und die App fällt sichtbar aus der Familie.
   Apple rundet selbst: macOS-Icon einmal gerundet mit transparentem
   Rand, iOS-Icon randlos und ungerundet.

   Für kleine Größen (Menüleiste, Favicon) die kompakte Fassung ohne
   Hörner, nur der Glyph (Sektion 07).
4. Haltung prüfen: Was auf der Fläche steht, ist eine Entscheidung oder
   eine Antwort — alles andere ins Log.
