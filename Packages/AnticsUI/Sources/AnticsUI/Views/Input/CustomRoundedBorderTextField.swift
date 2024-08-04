import SwiftUI

public struct CustomRoundedBorderTextField: View {
    private let placeholder: String
    private let borderColor: Color
    private let keyboardType: UIKeyboardType
    @Binding private var text: String
    
    public var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(
                CustomRoundedBorderTextFieldStyle(
                    borderColor: borderColor
                )
            )
            .keyboardType(keyboardType)
    }
    
    public init(
        placeholder: String,
        borderColor: Color = Color.primary,
        keyboardType: UIKeyboardType = .default,
        text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.borderColor = borderColor
        self.keyboardType = keyboardType
        self._text = text
    }
}

#Preview {
    CustomRoundedBorderTextField(
        placeholder: "Project name",
        text: .constant("")
    )
}

