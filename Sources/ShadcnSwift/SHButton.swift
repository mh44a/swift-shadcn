import SwiftUI

public enum SHButtonVariant: String, CaseIterable, Sendable {
    case `default`, secondary, outline, ghost, destructive, link
}

public enum SHButtonSize: String, CaseIterable, Sendable {
    case xs, sm, `default`, lg, iconXS, iconSM, icon, iconLG

    fileprivate var height: CGFloat {
        switch self {
        case .xs, .iconXS: return 24
        case .sm, .iconSM: return 32
        case .default, .icon: return 36
        case .lg, .iconLG: return 40
        }
    }

    fileprivate var isIcon: Bool {
        switch self {
        case .iconXS, .iconSM, .icon, .iconLG: return true
        default: return false
        }
    }

    fileprivate var padding: CGFloat {
        switch self {
        case .xs: return 8
        case .sm: return 12
        case .lg: return 24
        default: return 16
        }
    }
}

/// A native SwiftUI button with shadcn-inspired variants.
/// Use `.disabled(true)` for disabled state and provide an accessibility label for icon-only buttons.
public struct SHButton<Label: View>: View {
    private let variant: SHButtonVariant
    private let size: SHButtonSize
    private let isLoading: Bool
    private let role: ButtonRole?
    private let action: () -> Void
    private let label: Label

    public init(
        variant: SHButtonVariant = .default,
        size: SHButtonSize = .default,
        isLoading: Bool = false,
        role: ButtonRole? = nil,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.variant = variant
        self.size = size
        self.isLoading = isLoading
        self.role = role
        self.action = action
        self.label = label()
    }

    public var body: some View {
        Button(role: role, action: action) {
            label
                .opacity(isLoading ? 0 : 1)
                .overlay {
                    if isLoading {
                        ProgressView()
                            .controlSize(.small)
                            .accessibilityHidden(true)
                    }
                }
        }
        .buttonStyle(SHButtonStyle(variant: variant, size: size))
        .disabled(isLoading)
        .accessibilityValue(isLoading ? Text("Loading") : Text(""))
    }
}

extension SHButton where Label == Text {
    public init(
        _ title: LocalizedStringKey,
        variant: SHButtonVariant = .default,
        size: SHButtonSize = .default,
        isLoading: Bool = false,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.init(variant: variant, size: size, isLoading: isLoading, role: role, action: action) {
            Text(title)
        }
    }
}

/// Also applies shadcn styling to standard SwiftUI `Button` views.
public struct SHButtonStyle: ButtonStyle {
    public var variant: SHButtonVariant
    public var size: SHButtonSize
    @Environment(\.shTheme) private var customTheme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @ScaledMetric(relativeTo: .subheadline) private var scale: CGFloat = 1

    public init(variant: SHButtonVariant = .default, size: SHButtonSize = .default) {
        self.variant = variant
        self.size = size
    }

    public func makeBody(configuration: Configuration) -> some View {
        StyledLabel(
            label: configuration.label,
            theme: customTheme ?? (colorScheme == .dark ? .dark : .light),
            variant: variant, size: size, scale: scale,
            isPressed: configuration.isPressed, isEnabled: isEnabled,
            reduceMotion: reduceMotion
        )
    }

    private struct StyledLabel: View {
        let label: ButtonStyleConfiguration.Label
        let theme: SHTheme
        let variant: SHButtonVariant
        let size: SHButtonSize
        let scale: CGFloat
        let isPressed: Bool
        let isEnabled: Bool
        let reduceMotion: Bool
        @State private var isHovered = false

        private var foreground: Color {
            switch variant {
            case .default: return theme.primaryForeground
            case .secondary: return theme.secondaryForeground
            case .destructive: return theme.destructiveForeground
            case .link: return theme.primary
            case .outline, .ghost: return theme.foreground
            }
        }

        private var background: Color {
            switch variant {
            case .default: return theme.primary
            case .secondary: return theme.secondary
            case .destructive: return theme.destructive
            case .outline: return theme.background
            case .ghost, .link: return .clear
            }
        }

        var body: some View {
            label
                .font(.subheadline.weight(.medium))
                .labelStyle(.titleAndIcon)
                .underline(variant == .link && (isHovered || isPressed))
                .foregroundStyle(foreground)
                .tint(foreground)
                .padding(.horizontal, size.isIcon ? 0 : size.padding)
                .frame(width: size.isIcon ? size.height * scale : nil)
                .frame(minHeight: size.height * scale)
                .background(background)
                .overlay {
                    if (isHovered || isPressed) && isEnabled {
                        (variant == .ghost || variant == .outline ? theme.foreground : foreground)
                            .opacity(isPressed ? 0.12 : 0.06)
                            .allowsHitTesting(false)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: theme.radius))
                .overlay {
                    RoundedRectangle(cornerRadius: theme.radius)
                        .strokeBorder(variant == .outline ? theme.border : .clear, lineWidth: 1)
                        .allowsHitTesting(false)
                }
                .contentShape(RoundedRectangle(cornerRadius: theme.radius))
                .opacity(isEnabled ? 1 : 0.5)
                .onHover { isHovered = $0 }
                .animation(reduceMotion ? nil : .easeOut(duration: 0.12), value: isPressed)
                .animation(reduceMotion ? nil : .easeOut(duration: 0.12), value: isHovered)
        }
    }
}
