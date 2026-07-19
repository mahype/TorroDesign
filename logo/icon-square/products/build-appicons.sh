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
render() { # svg png groesse
  if command -v rsvg-convert >/dev/null; then
    rsvg-convert -w "$3" -h "$3" -o "$2" "$1"
  elif [ -x "$chrome" ]; then
    "$chrome" --headless --disable-gpu --hide-scrollbars \
      --default-background-color=00000000 \
      --window-size="$3,$3" --screenshot="$2" "file://$1" >/dev/null 2>&1
  else
    echo "Weder rsvg-convert noch Google Chrome gefunden." >&2; exit 1
  fi
}

mkdir -p "$out"

# --- macOS -------------------------------------------------------------------
iconset="$out/$app.iconset"; rm -rf "$iconset"; mkdir -p "$iconset"
for pair in "16 icon_16x16" "32 icon_16x16@2x" "32 icon_32x32" "64 icon_32x32@2x" \
            "128 icon_128x128" "256 icon_128x128@2x" "256 icon_256x256" \
            "512 icon_256x256@2x" "512 icon_512x512" "1024 icon_512x512@2x"; do
  set -- $pair
  render "$mac_master" "$iconset/$2.png" "$1"
done
iconutil -c icns "$iconset" -o "$out/$app.icns"
rm -rf "$iconset"

# --- iOS / iPadOS ------------------------------------------------------------
set="$out/AppIcon.appiconset"; rm -rf "$set"; mkdir -p "$set"
render "$ios_master" "$set/icon-1024.png" 1024
cat > "$set/Contents.json" <<'JSON'
{
  "images" : [ { "filename" : "icon-1024.png", "idiom" : "universal",
                 "platform" : "ios", "size" : "1024x1024" } ],
  "info" : { "author" : "torro-design", "version" : 1 }
}
JSON

echo "Fertig: $out/$app.icns  ·  $set/"
