import SwiftUI

public struct CapsuleButtonStyle: ButtonStyle {
    private let backgroundColor: Color
    private let labelInsets: EdgeInsets
    private let disabled: Bool
    
    public init(
        backgroundColor: Color = .blue,
        labelInsets: EdgeInsets = .init(horizontal: 24, vertical: Padding.medium),
        disabled: Bool = false
    ) {
        self.backgroundColor = backgroundColor
        self.labelInsets = labelInsets
        self.disabled = disabled
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(labelInsets)
            .background(disabled ? .gray : backgroundColor)
            .foregroundColor(disabled ? .gray : .white)
            .clipShape(.capsule)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
