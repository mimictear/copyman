import SwiftUI

public struct CapsuleButton<Label> : View where Label : View {
    private let background: Color
    private let action: () -> Void
    private let label: Label
    private let labelInsets: EdgeInsets
    private let disabled: Bool
    
    public var body: some View {
        Button { action() } label: { label }
            .buttonStyle(CapsuleButtonStyle(backgroundColor: background, labelInsets: labelInsets, disabled: disabled))
            .disabled(disabled)
    }
    
    public init(
        background: Color = .blue,
        labelInsets: EdgeInsets = .init(horizontal: 24, vertical: Padding.medium),
        disabled: Bool = false,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.background = background
        self.labelInsets = labelInsets
        self.disabled = disabled
        self.action = action
        self.label = label()
    }
}

#Preview {
    CapsuleButton(
        action: {},
        label: {
            Text("Add item")
                .applyTextStyle(model: FontStyleModel())
        }
    )
}
