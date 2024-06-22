import SwiftUI

public struct CheckboxToggleStyle: ToggleStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                    .frame(squared: 20)
            }
        }
    }
}

public extension ToggleStyle where Self == SwitchToggleStyle {
    static var checkboxToggle: CheckboxToggleStyle {
        CheckboxToggleStyle()
    }
}
