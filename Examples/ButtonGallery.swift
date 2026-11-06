import SwiftUI
import ShadcnSwift

/// Copy into an iOS/macOS app target that depends on ShadcnSwift.
struct ButtonGallery: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Button").font(.largeTitle.bold())

                ForEach(SHButtonVariant.allCases, id: \.self) { variant in
                    SHButton("\(variant.rawValue.capitalized)", variant: variant) {}
                }

                HStack {
                    SHButton("Extra small", size: .xs) {}
                    SHButton("Small", size: .sm) {}
                    SHButton("Large", size: .lg) {}
                }

                SHButton(variant: .outline, action: {}) {
                    Label("Send email", systemImage: "envelope")
                }

                HStack {
                    SHButton(size: .icon, action: {}) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add item")

                    SHButton("Disabled") {}.disabled(true)
                    SHButton("Saving", isLoading: true) {}
                }

                SHButton("Delete", variant: .destructive, role: .destructive) {}

                Button("Standard SwiftUI Button") {}
                    .buttonStyle(SHButtonStyle(variant: .outline))
            }
            .padding(24)
        }
    }
}

#Preview("Light") {
    ButtonGallery().preferredColorScheme(.light)
}

#Preview("Dark") {
    ButtonGallery().preferredColorScheme(.dark)
}
