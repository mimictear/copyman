import SwiftUI

struct FocusedModifier<ID: Hashable>: ViewModifier {
    let id: ID
    let scrollViewProxy: ScrollViewProxy
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                withAnimation {
                    scrollViewProxy.scrollTo(id, anchor: anchor)
                }
            }
    }
}

public extension View {
    func focusing<ID: Hashable>(id: ID, scrollViewProxy: ScrollViewProxy, anchor: UnitPoint = .center) -> some View {
        self.modifier(FocusedModifier(id: id, scrollViewProxy: scrollViewProxy, anchor: anchor))
    }
}
