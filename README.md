<p align="center">
  <img src="Resources/icon.png" alt="ShadcnSwift" width="128" />
</p>

<h1 align="center">ShadcnSwift</h1>

<p align="center">
  The shadcn/ui aesthetic, built with native SwiftUI.<br />
  Composable components and customizable themes for iOS and macOS.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5.9%2B-F05138?logo=swift&logoColor=white" alt="Swift 5.9+" />
  <img src="https://img.shields.io/badge/iOS-17%2B-181717?logo=apple" alt="iOS 17+" />
  <img src="https://img.shields.io/badge/macOS-14%2B-181717?logo=apple" alt="macOS 14+" />
  <img src="https://img.shields.io/badge/SwiftPM-compatible-orange" alt="Swift Package Manager compatible" />
</p>

---

ShadcnSwift is an independent SwiftUI component library inspired by
[shadcn/ui](https://ui.shadcn.com). Compose native views with familiar variants,
custom labels, and a shared theme. No external dependencies.

> **Early development:** Button is the first available component. Apple-platform
> compilation and visual validation are pending. APIs may change as the library grows.

## Features

- Six button variants and eight size options.
- Automatic light and dark palettes, with custom theme overrides.
- SF Symbols and custom view-builder labels.
- Loading and disabled states.
- Dynamic Type scaling and support for the Reduce Motion preference.
- Reusable styling for standard SwiftUI buttons.

## Requirements

| Requirement | Minimum |
| --- | --- |
| Swift | 5.9 |
| iOS | 17 |
| macOS | 14 |

## Installation

### Xcode

Clone or download this repository, then:

1. Choose **File → Add Package Dependencies → Add Local**.
2. Select the `shadcn-swift` folder.
3. Add the **ShadcnSwift** product to your application target.

### Swift Package Manager

Add a local dependency to your application's `Package.swift`, adjusting the path
for your checkout:

```swift
dependencies: [
    .package(path: "../shadcn-swift")
],
targets: [
    .target(
        name: "MyApp",
        dependencies: [
            .product(name: "ShadcnSwift", package: "shadcn-swift")
        ]
    )
]
```

## Quick start

```swift
import SwiftUI
import ShadcnSwift

struct ContentView: View {
    var body: some View {
        SHButton("Get started") {
            print("Let's build something.")
        }
    }
}
```

## Button

### Variants

```swift
SHButton("Default") {}
SHButton("Secondary", variant: .secondary) {}
SHButton("Outline", variant: .outline) {}
SHButton("Ghost", variant: .ghost) {}
SHButton("Delete", variant: .destructive, role: .destructive) {}
SHButton("Learn more", variant: .link) {}
```

The `.destructive` variant controls appearance; `role: .destructive` supplies the
native button role. The `.link` variant remains an action button. Use SwiftUI `Link`
for URL navigation.

### Sizes

| Size | Icon-only equivalent | Base height |
| --- | --- | --- |
| `.xs` | `.iconXS` | 24 pt |
| `.sm` | `.iconSM` | 32 pt |
| `.default` | `.icon` | 36 pt |
| `.lg` | `.iconLG` | 40 pt |

```swift
SHButton("Small", size: .sm) {}
SHButton("Continue", size: .lg) {}
```

Heights scale with Dynamic Type, and text labels can wrap. Compact sizes are intended
for dense layouts; provide sufficient touch targets and spacing in mobile interfaces.

### Icons and custom labels

```swift
SHButton(variant: .outline, action: {}) {
    Label("Send email", systemImage: "envelope")
}

SHButton(size: .icon, action: {}) {
    Image(systemName: "plus")
}
.accessibilityLabel("Add item")
```

Always provide an accessible name for icon-only buttons.

### Loading and disabled states

```swift
SHButton("Saving", isLoading: true) {}

SHButton("Unavailable") {}
    .disabled(true)
```

Loading displays a spinner over the label, preserves its layout, and disables
activation. The original label remains in the view hierarchy, with a `Loading`
accessibility value. Verify announcements with VoiceOver in your app.

### Style a native button

```swift
Button("Continue") {}
    .buttonStyle(SHButtonStyle(variant: .outline, size: .lg))
    .keyboardShortcut(.defaultAction)
```

## Theming

Components follow the system color scheme by default. Override any view hierarchy
with `.shadcnTheme(_:)`:

```swift
struct BrandedView: View {
    @Environment(\.colorScheme) private var colorScheme

    private var theme: SHTheme {
        var theme = colorScheme == .dark ? SHTheme.dark : SHTheme.light
        theme.primary = .indigo
        theme.primaryForeground = .white
        theme.radius = 10
        return theme
    }

    var body: some View {
        SHButton("Continue") {}
            .shadcnTheme(theme)
    }
}
```

Themes expose semantic colors for primary, secondary, background, foreground,
destructive, border and ring, plus a shared corner radius. Foreground colors for
filled variants are independently customizable. The ring token is reserved for
future styling.

A custom theme is a fixed palette. Select the light or dark palette explicitly,
as above, when your theme should follow the system appearance.

## Component status

| Component | Status |
| --- | --- |
| Button | Implemented; Apple-platform validation pending |
| Shared theme | Initial light/dark palettes and custom overrides |
| Additional components | Planned |

The goal is to expand coverage of shadcn/ui components while adapting interactions
to Apple platforms. Current functionality is limited to the components listed above.

## Examples and development

The [Button Gallery](Examples/ButtonGallery.swift) includes light/dark Xcode previews,
variants, sizes, icons, and loading and disabled states. Copy it into an application
target linked to `ShadcnSwift` to explore the component.

On macOS with Xcode installed:

```sh
swift build
```

Build a consuming iOS app to validate the iOS target. Before shipping, check your
supported devices with both appearances, large Dynamic Type, VoiceOver and keyboard
navigation.

## Contributing

Bug reports, API feedback and component proposals are welcome. For a new component,
start with an issue describing the intended API, variants and platform behavior.
Keep changes focused and include a usage example and any validation performed.

## Acknowledgments

Inspired by the design and composition principles of [shadcn/ui](https://ui.shadcn.com).
ShadcnSwift is an independent project and is not affiliated with or endorsed by shadcn/ui.
