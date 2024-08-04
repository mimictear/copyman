import SwiftUI

public struct Border: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    let backgroundColor: Color
    let cardCornerRadius: CGFloat
    let borderColor: Color
    
    private var elevationColor: Color {
        colorScheme == .dark ? Color.gray : Color.black.opacity(0.2)
    }
    
    public func body(content: Content) -> some View {
        content
            .background(backgroundColor)
            .cornerRadius(cardCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cardCornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}

public extension View {
    func border(
        color: Color = Color.gray,
        cardCornerRadius: CGFloat = 20,
        borderColor: Color = .black
    ) -> some View {
        modifier(Border(backgroundColor: color, cardCornerRadius: cardCornerRadius, borderColor: borderColor))
    }
}
