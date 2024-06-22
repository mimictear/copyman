import SwiftUI

public struct CustomRoundedBorderTextField: View {
    private let placeholder: String
    private let borderColor: Color
    @Binding private var text: String
    
    public var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(
                CustomRoundedBorderTextFieldStyle(
                    borderColor: borderColor
                )
            )
    }
    
    public init(
        placeholder: String,
        borderColor: Color = Color.primary,
        text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.borderColor = borderColor
        self._text = text
    }
}

#Preview {
    CustomRoundedBorderTextField(
        placeholder: "Project name",
        text: .constant("")
    )
}

