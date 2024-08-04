import SwiftUI

public extension View {
    func frame(squared: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(
            width: squared,
            height: squared,
            alignment: alignment
        )
    }
}
