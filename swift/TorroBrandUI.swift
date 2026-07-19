// TorroBrandUI.swift — Torro-Markenbausteine für SwiftUI-Shells (macOS 14+).
//
// Drop-in aus dem torro-design-Repo: Farben, Displayschrift, die gezeichneten
// Markenformen (Horn, Signet), Wortmarke mit parametrisiertem Produktnamen,
// Hero, Kartenfläche, Button-Stil und Kachel-Badge. Werte und Begründungen in
// app-design.md; Ursprung der Bausteine ist TorroMail (TorroMailApp.swift) —
// Änderungen dort und hier gehören synchron gehalten.
//
// Voraussetzung für die Schrift: `fonts/frutiger/LTe50335.ttf` als
// `FrutigerLT-UltraBlack.ttf` in die App-Ressourcen legen und beim Start
// `TorroBrandFont.register(in:)` aufrufen. Der Schnitt ist lizenzpflichtig —
// nur in eigene Torro-Apps einbetten, nicht weitergeben.

import CoreText
import SwiftUI

// MARK: - Farben (tokens/tokens.json → color)

public extension Color {
    /// torro-red #D50C0C — der verbindliche Markenwert.
    static let torroRed = Color(red: 213 / 255, green: 12 / 255, blue: 12 / 255)
    /// torro-red-deep #A50A0A — Verläufe, Hover, Tiefe.
    static let torroRedDeep = Color(red: 165 / 255, green: 10 / 255, blue: 10 / 255)
    /// silver #C4C3C3 — die zweite Hälfte der Wortmarke.
    static let torroSilver = Color(red: 196 / 255, green: 195 / 255, blue: 195 / 255)
}

// MARK: - Displayschrift

/// Frutiger LT 95 UltraBlack, der Display-Schnitt der Marke (`font.display`).
/// Die App liefert ihn als Ressource mit und registriert ihn prozess-lokal —
/// so hängt nichts davon ab, was auf dem Mac installiert ist, und der Schnitt
/// bleibt aus der Schriftsammlung des Nutzers heraus.
public enum TorroBrandFont {
    /// PostScript-Name des eingebetteten Schnitts.
    public static let displayName = "FrutigerLT-UltraBlack"

    @discardableResult
    public static func register(in bundle: Bundle = .main, resource: String = "FrutigerLT-UltraBlack") -> Bool {
        guard let url = bundle.url(forResource: resource, withExtension: "ttf") else {
            return false
        }
        return CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }
}

public extension Font {
    /// Der Display-Schnitt, per PostScript-Name. Fällt auf eine schwere
    /// Systemschrift zurück, falls die Registrierung je scheitert.
    static func torroDisplay(size: CGFloat) -> Font {
        .custom(TorroBrandFont.displayName, size: size)
    }
}

// MARK: - Gezeichnete Markenformen

/// Das Hörner-Signet, nachgezeichnet aus dem quadratischen App-Icon
/// (`logo/icon-square/torro-logo-square.svg`) — Wasserzeichen und Icon
/// bleiben dieselbe Zeichnung.
public struct TorroSignet: Shape {
    /// Begrenzungsrahmen der Zeichnung in ihrem eigenen Koordinatenraum.
    private static let artwork = CGRect(x: 12.3, y: 38.7, width: 123.7, height: 69.9)

    public init() {}

    public func path(in rect: CGRect) -> Path {
        let scale = min(rect.width / Self.artwork.width, rect.height / Self.artwork.height)
        let drawn = CGSize(width: Self.artwork.width * scale, height: Self.artwork.height * scale)
        let origin = CGPoint(x: rect.midX - drawn.width / 2, y: rect.midY - drawn.height / 2)

        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(
                x: origin.x + (x - Self.artwork.minX) * scale,
                y: origin.y + (y - Self.artwork.minY) * scale
            )
        }

        var path = Path()
        path.move(to: p(54.0000, 108.4000))
        path.addCurve(to: p(31.6000, 103.3000), control1: p(44.9000, 106.9000), control2: p(38.5000, 105.5000))
        path.addCurve(to: p(12.3000, 78.6000), control1: p(18.0000, 99.0000), control2: p(11.1000, 90.2000))
        path.addCurve(to: p(25.2000, 56.5000), control1: p(13.1000, 70.8000), control2: p(16.8000, 64.4000))
        path.addCurve(to: p(50.1000, 38.7000), control1: p(33.3000, 48.7000), control2: p(49.0000, 37.6000))
        path.addCurve(to: p(48.9000, 50.0000), control1: p(50.4000, 39.2000), control2: p(49.9000, 44.2000))
        path.addCurve(to: p(47.8000, 68.6000), control1: p(46.9000, 61.3000), control2: p(46.6000, 66.8000))
        path.addCurve(to: p(61.3000, 72.8000), control1: p(49.3000, 70.9000), control2: p(53.4000, 72.2000))
        path.addLine(to: p(69.5000, 73.5000))
        path.addLine(to: p(69.5000, 91.0000))
        path.addLine(to: p(69.5000, 108.5000))
        path.addLine(to: p(63.0000, 108.6000))
        path.addCurve(to: p(54.0000, 108.4000), control1: p(59.4000, 108.7000), control2: p(55.4000, 108.6000))
        path.closeSubpath()
        path.move(to: p(79.5000, 107.9000))
        path.addCurve(to: p(79.2000, 90.0000), control1: p(79.2000, 107.1000), control2: p(79.1000, 99.0000))
        path.addLine(to: p(79.5000, 73.5000))
        path.addLine(to: p(87.7000, 72.8000))
        path.addCurve(to: p(101.2000, 68.6000), control1: p(95.6000, 72.2000), control2: p(99.7000, 70.9000))
        path.addCurve(to: p(100.1000, 50.0000), control1: p(102.4000, 66.8000), control2: p(102.1000, 61.3000))
        path.addCurve(to: p(98.9000, 38.7000), control1: p(99.1000, 44.2000), control2: p(98.6000, 39.2000))
        path.addCurve(to: p(123.8000, 56.5000), control1: p(100.0000, 37.6000), control2: p(115.7000, 48.7000))
        path.addCurve(to: p(133.7000, 68.4000), control1: p(128.0000, 60.4000), control2: p(132.3000, 65.6000))
        path.addCurve(to: p(136.0000, 87.5000), control1: p(136.7000, 74.4000), control2: p(137.7000, 82.4000))
        path.addCurve(to: p(121.2000, 102.0000), control1: p(134.1000, 93.4000), control2: p(127.7000, 99.6000))
        path.addCurve(to: p(79.5000, 107.9000), control1: p(106.9000, 107.4000), control2: p(80.7000, 111.0000))
        path.closeSubpath()
        return path
    }
}

/// Ein einzelnes, nach außen schwingendes Horn, nachgezeichnet aus der
/// TORROFORMS-Wortmarke (`logo/wordmark/torroforms-wordmark.svg`).
/// Für die rechte Seite spiegeln.
public struct TorroHorn: Shape {
    private static let artwork = CGRect(x: 46.429688, y: 59.398438, width: 55.765624, height: 68.832031)

    /// Seitenverhältnis Breite : Höhe der Zeichnung.
    public static let aspectRatio = artwork.width / artwork.height

    public init() {}

    public func path(in rect: CGRect) -> Path {
        let scaleX = rect.width / Self.artwork.width
        let scaleY = rect.height / Self.artwork.height

        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(
                x: rect.minX + (x - Self.artwork.minX) * scaleX,
                y: rect.minY + (y - Self.artwork.minY) * scaleY
            )
        }

        var path = Path()
        path.move(to: p(102.195312, 128.230469))
        path.addCurve(to: p(46.429688, 100.71875), control1: p(92.625, 128.230469), control2: p(45.835938, 128.230469))
        path.addCurve(to: p(82.910156, 59.398438), control1: p(47.664062, 76.40625), control2: p(82.910156, 59.398438))
        path.addCurve(to: p(79.394531, 88.992188), control1: p(82.910156, 59.398438), control2: p(77.566406, 85.226562))
        path.addCurve(to: p(102.195312, 93.8125), control1: p(80.632812, 91.546875), control2: p(83.589844, 94.261719))
        path.closeSubpath()
        return path
    }
}

// MARK: - Wortmarke

/// Der Produkt-Lockup nach dem Muster der TORROFORMS-Wortmarke: Hörner
/// beidseitig, der Name im Display-Schnitt, „TORRO" weiß und der Produktname
/// silber — gedacht für roten oder dunklen Grund.
///
///     TorroWordmark(product: "MAIL")      // TorroMail
///     TorroWordmark(product: "WHISPER")   // TorroWhisper
public struct TorroWordmark: View {
    /// Produkt-Hälfte des Namens, versal (z. B. "MAIL").
    public var product: String
    /// Versalhöhe. Alles Weitere leitet sich daraus ab — dieselben
    /// Proportionen wie die Original-Wortmarke.
    public var capHeight: CGFloat
    /// Für VoiceOver; leer → „Torro" + Produktname.
    public var accessibilityName: String

    public init(product: String, capHeight: CGFloat = 10, accessibilityName: String = "") {
        self.product = product
        self.capHeight = capHeight
        self.accessibilityName = accessibilityName.isEmpty
            ? "Torro" + product.capitalized
            : accessibilityName
    }

    private var hornHeight: CGFloat { capHeight * 2.0 }
    private var hornWidth: CGFloat { hornHeight * TorroHorn.aspectRatio }

    public var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: capHeight * 0.14) {
            horn(mirrored: false)
            Text(verbatim: "TORRO").foregroundStyle(.white)
                + Text(verbatim: product).foregroundStyle(Color.torroSilver)
            horn(mirrored: true)
        }
        // Frutigers Versalien sitzen bei ~0,7 em.
        .font(.torroDisplay(size: capHeight / 0.7))
        .lineLimit(1)
        .fixedSize()
        .accessibilityElement()
        .accessibilityLabel(accessibilityName)
    }

    private func horn(mirrored: Bool) -> some View {
        TorroHorn()
            .fill(.white)
            .frame(width: hornWidth, height: hornHeight)
            .scaleEffect(x: mirrored ? -1 : 1)
            // Die Hörner enden auf der Grundlinie, genau wie die Buchstaben.
            .alignmentGuide(.lastTextBaseline) { $0[.bottom] }
    }
}

// MARK: - Hero

/// Der eine laute Markenmoment pro Fenster: roter Verlaufs-Grund, die
/// Wortmarke, ein Satz Klartext, das Signet als angeschnittenes Wasserzeichen.
public struct TorroBrandHero: View {
    public var product: String
    public var tagline: String

    public init(product: String, tagline: String) {
        self.product = product
        self.tagline = tagline
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            TorroWordmark(product: product, capHeight: 15)
            Text(tagline)
                .font(.callout)
                .foregroundStyle(.white.opacity(0.92))
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 18)
        .padding(.vertical, 15)
        .background {
            let shape = RoundedRectangle(cornerRadius: 14, style: .continuous)
            LinearGradient(
                colors: [.torroRed, .torroRedDeep],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            // Das Signet läuft rechts mit Absicht aus dem Anschnitt — von der
            // Karte beschnitten statt frei schwebend. Als Overlay, damit seine
            // feste Höhe die Karte nicht aufzieht.
            .overlay(alignment: .trailing) {
                TorroSignet()
                    .fill(.white.opacity(0.09))
                    .frame(width: 260, height: 150)
                    .offset(x: 95)
            }
            .clipShape(shape)
            .overlay {
                shape.strokeBorder(.white.opacity(0.18), lineWidth: 1)
            }
            .shadow(color: .black.opacity(0.28), radius: 6, y: 3)
        }
    }
}

// MARK: - Kartenfläche

/// Die erhabene Fläche, auf der jedes Panel sitzt: belichtete Oberkante, die
/// nach unten ausläuft, über einem weichen Doppelschatten. Der Schatten hängt
/// allein am Grund der Karte — am ganzen Panel würde jedes Label mitwerfen.
public struct TorroCard: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    public var cornerRadius: CGFloat
    public var isHighlighted: Bool

    public func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        return content
            .background {
                shape
                    .fill(.background)
                    .shadow(color: .black.opacity(colorScheme == .dark ? 0.5 : 0.14), radius: 5, y: 3)
                    .shadow(color: .black.opacity(colorScheme == .dark ? 0.3 : 0.05), radius: 1, y: 1)
            }
            .overlay {
                shape.strokeBorder(edgeGradient, lineWidth: 1)
            }
            .contentShape(shape)
    }

    private var edgeGradient: LinearGradient {
        let top: Color
        let bottom: Color
        if colorScheme == .dark {
            top = .white.opacity(isHighlighted ? 0.34 : 0.20)
            bottom = .white.opacity(isHighlighted ? 0.10 : 0.05)
        } else {
            top = .white.opacity(0.9)
            bottom = .black.opacity(isHighlighted ? 0.18 : 0.10)
        }
        return LinearGradient(colors: [top, bottom], startPoint: .top, endPoint: .bottom)
    }
}

public extension View {
    /// Legt den Inhalt auf die Torro-Kartenfläche. `isHighlighted` verstärkt
    /// die Randlinie — für den Hover klickbarer Karten (Übergang:
    /// `easeOut 0,12 s`).
    func torroCard(cornerRadius: CGFloat = 12, isHighlighted: Bool = false) -> some View {
        modifier(TorroCard(cornerRadius: cornerRadius, isHighlighted: isHighlighted))
    }

    /// Der Standard-macOS-Druckknopf: graue Fläche, helle Beschriftung. Das
    /// Markenrot ist Grund- und Akzentfarbe — auf einem Control färbt es die
    /// Beschriftung statt der Fläche. Roter Text auf dunklem Grund ist unlesbar
    /// und nie erlaubt; Buttons verzichten deshalb ausnahmslos auf den App-Tint.
    func torroButton() -> some View {
        buttonStyle(.bordered).tint(nil)
    }
}

// MARK: - Kachel-Badge

/// Die rote Kachel, die für „die eigene Sache" steht (Mailkonto, eigener
/// Server). Fremdes (Assistenten, Dritt-Clients) bekommt stattdessen eine
/// neutrale Systemfläche — die Marke färbt nicht auf Fremde ab.
public struct TorroBadge: View {
    public var symbol: String
    public var size: CGFloat

    public init(symbol: String, size: CGFloat = 34) {
        self.symbol = symbol
        self.size = size
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: size * 0.24, style: .continuous)
            .fill(Color.torroRed.gradient)
            .frame(width: size, height: size)
            .overlay {
                Image(systemName: symbol)
                    .font(.system(size: size * 0.41, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .shadow(color: .black.opacity(0.2), radius: 1.5, y: 1)
    }
}
