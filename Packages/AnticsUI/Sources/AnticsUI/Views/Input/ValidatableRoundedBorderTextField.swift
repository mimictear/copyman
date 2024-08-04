import SwiftUI

public struct ValidatableRoundedBorderTextField: View {
    private let label: String
    private let placeholder: String
    private let keyboardType: UIKeyboardType
    private let errorText: String
    private let applyValidation: Bool
    @Binding private var text: String
    private let validationCondition: () -> Bool
    
    public var body: some View {
        InputFormView { validate in
            VStack(alignment: .leading, spacing: .zero) {
                
                Text(label)
                    .applyTextStyle(
                        model: FontStyleModel(font: .footnote, fontWeight: .semibold)
                    )
                    .padding(.bottom, Padding.small)
                
                CustomRoundedBorderTextField(
                    placeholder: placeholder,
                    borderColor: validate() ? .gray : .red,
                    keyboardType: keyboardType,
                    text: $text
                )
                .validate {
                    applyValidation ? validationCondition() : true
                }
                
                Text(errorText)
                    .applyTextStyle(
                        model: FontStyleModel(font: .caption2, textColor: .red)
                    )
                    .padding(.top, viewExtremeSmallPadding)
                    .padding(.leading, viewMediumPadding)
                    .opacity(validate() ? 0 : 1)
                    .animation(errorTextInOutAnimation, value: validate())
            }
        }
    }
    
    /// By default, it applies the validation condition immediately.
    /// If you want the validation to fire only under some external condition, set the `applyValidation` parameter to an external @State variable.
    /// When that variable changes its value to `true`, the `validationCondition` will apply.
    public init(
        label: String,
        placeholder: String,
        keyboardType: UIKeyboardType = .default,
        errorText: String,
        applyValidation: Bool = true,
        text: Binding<String>,
        validationCondition: @escaping () -> Bool
    ) {
        self.label = label
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.errorText = errorText
        self.applyValidation = applyValidation
        self._text = text
        self.validationCondition = validationCondition
    }
}

private let errorTextInOutAnimation: Animation = .easeInOut(duration: 0.2)
private let viewMediumPadding: CGFloat = 16
private let viewExtremeSmallPadding: CGFloat = 4

#Preview {
    ValidatableRoundedBorderTextField(
        label: "Title",
        placeholder: "Enter title",
        errorText: "Invalid title",
        applyValidation: false,
        text: .constant(""),
        validationCondition: { true }
    )
}
