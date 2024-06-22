import SwiftUI

public protocol StyledText {
    var font: Font { get }
    var fontWeight: Font.Weight { get }
    var textColor: Color { get }
}

public struct FontStyleModel: StyledText {
    public let font: Font
    public let fontWeight: Font.Weight
    public let textColor: Color
    
    public init(font: Font = .callout, fontWeight: Font.Weight = .regular, textColor: Color = .primary) {
        self.font = font
        self.fontWeight = fontWeight
        self.textColor = textColor
    }
}

public extension FontStyleModel {
    static var `default`: Self {
        .init(font: .callout, fontWeight: .regular, textColor: .primary)
    }
}

public struct TextStyleModel: StyledText {
    public let text: String
    public let font: Font
    public let fontWeight: Font.Weight
    public let textColor: Color
    
    public init(text: String, font: Font = .callout, fontWeight: Font.Weight = .regular, textColor: Color = .primary) {
        self.text = text
        self.font = font
        self.fontWeight = fontWeight
        self.textColor = textColor
    }
}

