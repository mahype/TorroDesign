#!/usr/bin/env bash
# Baut aus den SVG-Mastern die fertigen App-Icons.
#
#   ./build-appicons.sh torromail [zielordner]
#
# Ergebnis im Zielordner (Vorgabe: ./build/<app>):
#   <app>.icns          — macOS: 824er Squircle auf transparenter 1024er Leinwand
#   AppIcon.appiconset/ — iOS/iPadOS: randlos, deckend, ohne Eckenrundung
#
# Beide Fassungen kommen aus demselben Master. Nie von Hand nachbauen und
# niemals eine weisse Flaeche unterlegen — der weisse Rand entsteht genau so.
set -euo pipefail

app="${1:-}"
[ -n "$app" ] || { echo "Nutzung: $0 <torromail|torrowhisper|torrotalk|torroforms> [zielordner]" >&2; exit 1; }

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mac_master="$here/macos/$app-icon-macos.svg"
ios_master="$here/$app-icon.svg"
out="${2:-$here/build/$app}"

[ -f "$mac_master" ] || { echo "Kein macOS-Master: $mac_master" >&2; exit 1; }
[ -f "$ios_master" ] || { echo "Kein Master: $ios_master" >&2; exit 1; }

chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Chrome-Fallback: --window-size schneidet den Viewport zu, es skaliert nicht.
# Ein 32er Fenster auf einer 1024er Leinwand liefert also die linke obere Ecke,
# nicht das verkleinerte Icon. Darum immer in voller Groesse schiessen und
# danach herunterrechnen. Pro SVG genuegt ein Schuss.
chrome_full() { # svg -> pfad zum 1024er png (gecached)
  local key full page
  key="$(echo "$1" | shasum | cut -c1-12)"
  full="$shots/$key.png"
  if [ ! -f "$full" ]; then
    # Chrome rendert ein SVG in seiner Eigengroesse — der iOS-Master ist 120px
    # und landet sonst als Briefmarke in der Ecke. Ueber eine Wrapper-Seite auf
    # 1024 aufgezogen skaliert die viewBox vektoriell mit.
    page="$shots/$key.html"
    cat > "$page" <<HTML
<style>html,body{margin:0;padding:0;background:transparent}
img{display:block;width:1024px;height:1024px}</style>
<img src="file://$1">
HTML
    "$chrome" --headless --disable-gpu --hide-scrollbars \
      --default-background-color=00000000 \
      --window-size=1024,1024 --screenshot="$full" "file://$page" >/dev/null 2>&1
  fi
  echo "$full"
}

render() { # svg png groesse
  if command -v rsvg-convert >/dev/null; then
    rsvg-convert -w "$3" -h "$3" -o "$2" "$1"
  elif [ -x "$chrome" ]; then
    local full; full="$(chrome_full "$1")"
    if [ "$3" = 1024 ]; then
      cp "$full" "$2"
    else
      sips -z "$3" "$3" "$full" --out "$2" >/dev/null
    fi
  else
    echo "Weder rsvg-convert noch Google Chrome gefunden." >&2; exit 1
  fi
}

# Faengt den Fehler, der die Icons in e67afda unbrauchbar gemacht hat: ein
# gecropptes Rendering sieht auf 1024 richtig aus und ist in jeder kleineren
# Groesse ein leerer Ausschnitt. Ein 1x1-Downscale mittelt das ganze Bild —
# der Traeger muss rot sein und rund 60% der Leinwand decken (824 von 1024).
check() { # png
  local px b g r a
  px="$(sips -z 1 1 "$1" --out "$shots/px.png" >/dev/null 2>&1 \
        && sips -s format bmp "$shots/px.png" --out "$shots/px.bmp" >/dev/null 2>&1 \
        && xxd -s -4 -l 4 -p "$shots/px.bmp")"
  b=$((16#${px:0:2})); g=$((16#${px:2:2})); r=$((16#${px:4:2})); a=$((16#${px:6:2}))
  # Das iOS-Icon ist deckend und hat gar keinen Alphakanal; sips schreibt dann
  # eine 0 ins Alphabyte, was ohne diese Zeile wie ein leeres Bild aussieht.
  [ "$(sips -g hasAlpha "$1" 2>/dev/null | tail -1 | tr -d ' ')" = "hasAlpha:no" ] && a=255
  [ "$a" -ge 102 ] || { echo "$1: nur ${a}/255 gedeckt — Ausschnitt statt Icon?" >&2; exit 1; }
  [ "$r" -gt $((g + 48)) ] && [ "$r" -gt $((b + 48)) ] \
    || { echo "$1: nicht rot (r=$r g=$g b=$b) — falscher Master?" >&2; exit 1; }
}

mkdir -p "$out"

shots="$(mktemp -d)"
trap 'rm -rf "$shots"' EXIT

# --- macOS -------------------------------------------------------------------
iconset="$out/$app.iconset"; rm -rf "$iconset"; mkdir -p "$iconset"
for pair in "16 icon_16x16" "32 icon_16x16@2x" "32 icon_32x32" "64 icon_32x32@2x" \
            "128 icon_128x128" "256 icon_128x128@2x" "256 icon_256x256" \
            "512 icon_256x256@2x" "512 icon_512x512" "1024 icon_512x512@2x"; do
  set -- $pair
  render "$mac_master" "$iconset/$2.png" "$1"
  check "$iconset/$2.png"
done
iconutil -c icns "$iconset" -o "$out/$app.icns"
rm -rf "$iconset"

# --- iOS / iPadOS ------------------------------------------------------------
set="$out/AppIcon.appiconset"; rm -rf "$set"; mkdir -p "$set"
render "$ios_master" "$set/icon-1024.png" 1024
check "$set/icon-1024.png"
cat > "$set/Contents.json" <<'JSON'
{
  "images" : [ { "filename" : "icon-1024.png", "idiom" : "universal",
                 "platform" : "ios", "size" : "1024x1024" } ],
  "info" : { "author" : "torro-design", "version" : 1 }
}
JSON

echo "Fertig: $out/$app.icns  ·  $set/"
