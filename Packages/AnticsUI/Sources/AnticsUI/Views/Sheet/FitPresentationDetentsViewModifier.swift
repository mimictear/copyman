import SwiftUI

public struct FitPresentationDetentsViewModifier: ViewModifier {
    @State private var height: CGFloat = 100
    
    public func body(content: Content) -> some View {
        bodyDetents(content: content)
    }
    
    private func bodyDetents(content: Content) -> some View {
        VStack(spacing: .zero) {
            content.readSize { size in
                height = size.height.isNaN ? .zero : size.height
            }
            Spacer(minLength: 0)
        }
        .presentationDetents([.height(height)])
    }
}

public extension View {
    func fitPresentationDetents() -> some View {
        modifier(FitPresentationDetentsViewModifier())
    }
}
