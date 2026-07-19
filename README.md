# Torro — Design & Brand Assets

Marken-Repository für **Torro**: Logo, Hörner-Signet, Kampfbulle, Farben und
Typografie. Ursprung sind die Original-Assets aus dem Projekt „Torro Forms"
(2016–2019); dieses Repo bündelt die für die Marke notwendigen Quelldateien an
einem Ort.

> 🐂 **Interaktiver Design-Guide:** [`design-guide.html`](design-guide.html)
> (im Browser öffnen — enthält alle Vektoren live, Farben, Schriftmuster und Do/Don't).
>
> 📱 **Designsprache der Apps:** [`app-design.md`](app-design.md)
> (Kartensystem, Layoutmaße, Statusfarben, Sprache — destilliert aus TorroMail).

---

## Auf einen Blick

| | |
|---|---|
| **Kernfarbe** | Torro Rot · `#D50C0C` |
| **Hausschrift** | Frutiger LT |
| **Logo-Schnitt** | Frutiger LT 95 UltraBlack (`fonts/frutiger/LTe50335.ttf`) |
| **Signet** | Zwei nach innen gestellte Hörner |
| **Sekundärschrift** | Minion Pro (Serifen, Print/Fließtext) |

---

## Farben

| Rolle | HEX | RGB | CMYK (ca.) | Einsatz |
|-------|-----|-----|------------|---------|
| **Torro Rot** | `#D50C0C` | 213 · 12 · 12 | 0 · 95 · 95 · 16 | Kernfarbe, Grundflächen |
| **Rot (dunkel)** | `#A50A0A` | 165 · 10 · 10 | — | Verläufe, Hover, Tiefe |
| **Schwarz** | `#0E0E0F` | 14 · 14 · 15 | — | Kontur (Bulle), Text |
| **Silber** | `#C4C3C3` | 196 · 195 · 195 | — | Wortmarken-Zusatz |
| **Weiß** | `#FFFFFF` | 255 · 255 · 255 | — | Schrift auf Rot |

> Verbindlich ist der **Vektorwert `#D50C0C`**. Der gemessene Rotton im
> gerasterten Logo (`#D41116`) liegt praktisch deckungsgleich.

Maschinenlesbar in [`tokens/tokens.json`](tokens/tokens.json) und als
CSS-Custom-Properties in [`tokens/colors.css`](tokens/colors.css).

---

## Typografie — Frutiger LT

Die komplette Familie liegt unter [`fonts/frutiger/`](fonts/frutiger/).

| Schnitt | Datei | Verwendung |
|---------|-------|------------|
| **95 UltraBlack** | `LTe50335.ttf` | **Logo, Headlines** |
| 75 Black | `LTe50333.ttf` | Betonung |
| 65 Bold | `LTe50329.ttf` | Subheads |
| 55 Roman | `LTe50331.ttf` | Fließtext |
| 45 Light | `LTe50327.ttf` | Feine Labels |
| 47/57/77/87 Condensed | `LTe52125–52129.ttf` | Enge Layouts |

Kursiv- und CE-Schnitte (`FT*.TTF`) sind ebenfalls enthalten.
Sekundär für Print-Fließtext: **Minion Pro Regular**
([`fonts/minion-pro/`](fonts/minion-pro/)).

---

## Logo-Bausteine

```
logo/
├── wordmark/       Wortmarken (Hörner + Schriftzug) — TORROFORMS, TORROMAIL
├── icon-square/    App-Icon: rotes Quadrat mit Hörnern
│   └── products/   App-Icons je Produkt (Hörner + Funktions-Glyph)
├── horns/          Hörner-Signet allein (weiß / rot / schwarz)
└── bull/           Kampfbulle (Key-Visual)
```

### Empfohlene Quelle je Einsatz

| Element | Datei | Hinweis |
|---------|-------|---------|
| Wortmarke (Web/Print) | `logo/wordmark/torro-forms-logo-outlines.ai/.eps` | **Outlines** → keine Font-Abhängigkeit |
| Wortmarke (editierbar) | `logo/wordmark/torro-forms-logo.ai` | Text noch als Frutiger-Font |
| Wortmarke (Web) | `logo/wordmark/torroforms-wordmark.svg` | weiß/silber, für dunklen/roten Grund |
| Wortmarke TorroMail | `logo/wordmark/torromail-wordmark.svg` | Produktvariante, weiß/silber, Outlines |
| App-Icon (Dachmarke) | `logo/icon-square/torro-logo-square.svg` | Favicon, Avatar, Suite — nicht für einzelne Apps |
| App-Icon je Produkt | `logo/icon-square/products/torro{mail,whisper,talk,forms}-icon.svg` | Hörner-Signet + Funktions-Glyph |
| Hörner-Signet | `logo/horns/horns-{white,red,black}.svg` | kleine Akzente, Loader, Wasserzeichen |
| Kampfbulle | `logo/bull/torro-bull-transparent.ai` · `torro-bull.svg` | Hero/Key-Visual, großformatig |

Die Produktvariante `torromail-wordmark.svg` übernimmt Hörner, Abstände und
Versalhöhe unverändert aus `torroforms-wordmark.svg`; „MAIL" steht wie der
Zusatz der Hauptmarke in Silber. Der Schriftzug ist in Outlines gewandelt,
also ohne Font-Abhängigkeit. Nach demselben Muster lassen sich weitere
Produktmarken ableiten.

Die `.ai`-Dateien sind PDF-kompatibel und lassen sich mit
`pdftocairo -svg datei.ai datei.svg` (Poppler) verlustfrei nach SVG wandeln —
so entstanden `torroforms-wordmark.svg` und `torro-bull.svg`.

---

## Anwendung

**So:**
- Das volle Rot als Grund nutzen — die Marke ist für Rot gebaut.
- Auf hellem Grund die rote Fassung der Wortmarke/Hörner einsetzen.
- Für kleine Größen das Hörner-Signet statt der gestauchten Wortmarke.
- Freiraum: mindestens eine Hornhöhe rundherum.
- Outlines-Vektoren verwenden, um Font-Ausfälle zu vermeiden.

**Nicht:**
- Rotton verschieben oder entsättigen — `#D50C0C` ist verbindlich.
- Wortmarke verzerren, neigen oder die Schnittstärke wechseln.
- Weiße Wortmarke auf hellen Grund setzen (unlesbar).
- Schlagschatten/Effekte auf das flache Logo legen.

---

## Die Marke in Apps

Wie aus der Marke eine App wird — Haltung („Entscheidungen statt Optionen"),
Kartensystem, Layoutmaße, Statusfarben, Bausteine und Sprachregeln — steht in
[`app-design.md`](app-design.md). Referenz-Implementierung ist **TorroMail**.

| Baustein | Ort |
|----------|-----|
| Designsprache (Doku) | [`app-design.md`](app-design.md) |
| Swift-Bausteine (Wortmarke, Hörner, Signet, Hero, Karte) | [`swift/TorroBrandUI.swift`](swift/TorroBrandUI.swift) |
| Statusfarben & App-Maße, maschinenlesbar | [`tokens/tokens.json`](tokens/tokens.json) → `app` · [`tokens/colors.css`](tokens/colors.css) |

Die Wortmarke ist im Swift-Baustein parametrisiert
(`TorroWordmark(product: "WHISPER")`), sodass jede App der Familie ihren
Lockup nach demselben Muster bekommt.

---

## Herkunft & Lizenz

- **Grafik-Assets** (Logo, Hörner, Bulle) stammen aus dem eigenen Projekt
  „Torro Forms". Vollständiges Original-Archiv inkl. PSD-Quellen, Rollups und
  Social-Templates liegt lokal unter `~/Downloads/Torro Forms/`.
- **Schriften:** *Frutiger LT* und *Minion Pro* sind **kommerziell lizenzierte
  Schriften** (Linotype/Monotype bzw. Adobe). Sie sind hier nur als Referenz
  für die eigene Markennutzung abgelegt — **nicht zur Weitergabe bestimmt**.
  Dieses Repository ist deshalb **privat** zu halten.
- Das Bull-Motiv basiert auf einer lizenzierten iStock-Illustration
  (`iStock_000072409101`), grafisch überarbeitet.

Bei Weitergabe der Marke an Dritte bitte die Font-Lizenzlage prüfen.
