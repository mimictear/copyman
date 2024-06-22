import SwiftUI

public extension View {
    func applyTheme(_ theme: Theme) -> some View {
        modifier(ThemeApplier(theme: theme))
    }
}

@MainActor
struct ThemeApplier: ViewModifier {
    
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    
    var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .tint(theme.tintColor)
    }
}
