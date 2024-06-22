import SwiftUI

public struct CustomRoundedBorderTextFieldStyle: TextFieldStyle {
    private let font: Font?
    private let fontWeight: Font.Weight?
    private let fontColor: Color
    private let borderColor: Color
    private let borderCornerRadius: CGFloat
    private let borderLineWidth: CGFloat
    
    public init(
        font: Font? = .body,
        fontWeight: Font.Weight? = .regular,
        fontColor: Color = Color.primary,
        borderColor: Color = Color.gray,
        borderCornerRadius: CGFloat = 14,
        borderLineWidth: CGFloat = 1
    ) {
        self.font = font
        self.fontWeight = fontWeight
        self.fontColor = fontColor
        self.borderColor = borderColor
        self.borderCornerRadius = borderCornerRadius
        self.borderLineWidth = borderLineWidth
    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(font)
            .fontWeight(fontWeight)
            .foregroundStyle(fontColor)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: borderCornerRadius)
                    .stroke(borderColor, lineWidth: borderLineWidth)
            )
    }
}

