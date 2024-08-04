import SwiftUI

// MARK: - Validation PreferenceKey

@MainActor
struct ValidationPreferenceKey : PreferenceKey {
    static var defaultValue: [Bool] = []
    
    static func reduce(value: inout [Bool], nextValue: () -> [Bool]) {
        value += nextValue()
    }
}

// MARK: - Validation modifier

struct ValidationModifier : ViewModifier  {
    let validation: () -> Bool
    func body(content: Content) -> some View {
        content
            .preference(
                key: ValidationPreferenceKey.self,
                value: [validation()]
            )
    }
}

public extension CustomRoundedBorderTextField {
    func validate(_ flag: @escaping () -> Bool) -> some View {
        self.modifier(ValidationModifier(validation: flag))
    }
}

// MARK: - Validation form

struct InputFormView<Content : View> : View {
    @State var validationSeeds: [Bool] = []
    @ViewBuilder var content: (( @escaping () -> Bool)) -> Content
    
    public var body: some View {
        content(validate)
            .onPreferenceChange(ValidationPreferenceKey.self) { value in
                validationSeeds = value
            }
    }
    
    private func validate() -> Bool {
        for seed in validationSeeds {
            if !seed { return false}
        }
        return true
    }
}

