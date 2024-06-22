import SwiftUI

public struct TextModelStyle: ViewModifier {
    let model: any StyledText
    
    public func body(content: Content) -> some View {
        content
            .foregroundStyle(model.textColor)
            .font(model.font)
            .fontWeight(model.fontWeight)
    }
}

public extension Text {
    func applyTextStyle(
        model: any StyledText
    ) -> some View {
        modifier(TextModelStyle(model: model))
    }
}

