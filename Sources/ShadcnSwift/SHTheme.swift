import SwiftUI

/// Semantic colors shared by ShadcnSwift components. Supply both light and dark palettes.
public struct SHTheme {
    public var primary: Color
    public var primaryForeground: Color
    public var secondary: Color
    public var secondaryForeground: Color
    public var background: Color
    public var foreground: Color
    public var destructive: Color
    public var destructiveForeground: Color
    public var border: Color
    public var ring: Color
    public var radius: CGFloat

    public init(
        primary: Color, primaryForeground: Color,
        secondary: Color, secondaryForeground: Color,
        background: Color, foreground: Color,
        destructive: Color, destructiveForeground: Color,
        border: Color, ring: Color, radius: CGFloat = 6
    ) {
        self.primary = primary
        self.primaryForeground = primaryForeground
        self.secondary = secondary
        self.secondaryForeground = secondaryForeground
        self.background = background
        self.foreground = foreground
        self.destructive = destructive
        self.destructiveForeground = destructiveForeground
        self.border = border
        self.ring = ring
        self.radius = radius
    }

    public static let light = SHTheme(
        primary: Color(white: 0.09), primaryForeground: Color(white: 0.98),
        secondary: Color(white: 0.96), secondaryForeground: Color(white: 0.09),
        background: .white, foreground: Color(white: 0.04),
        destructive: Color(red: 0.86, green: 0.15, blue: 0.15), destructiveForeground: .white,
        border: Color(white: 0.90), ring: Color(white: 0.55)
    )

    public static let dark = SHTheme(
        primary: Color(white: 0.98), primaryForeground: Color(white: 0.09),
        secondary: Color(white: 0.15), secondaryForeground: Color(white: 0.98),
        background: Color(white: 0.04), foreground: Color(white: 0.98),
        destructive: Color(red: 0.94, green: 0.27, blue: 0.27), destructiveForeground: .white,
        border: Color(white: 0.28), ring: Color(white: 0.65)
    )
}

private struct SHThemeKey: EnvironmentKey {
    static let defaultValue: SHTheme? = nil
}

extension EnvironmentValues {
    var shTheme: SHTheme? {
        get { self[SHThemeKey.self] }
        set { self[SHThemeKey.self] = newValue }
    }
}

extension View {
    /// Overrides the automatic light/dark theme for this view hierarchy.
    public func shadcnTheme(_ theme: SHTheme) -> some View {
        environment(\.shTheme, theme)
    }
}
