import SwiftUI

public enum Padding {
    /// Small padding value (4 points).
    public static let extremelySmall: CGFloat = 4
    
    /// Small padding value (8 points).
    public static let small: CGFloat = 8
    
    /// Medium padding value (16 points).
    public static let medium: CGFloat = 16
    
    /// Large padding value (24 points).
    public static let large: CGFloat = 24
    
    /// Large padding value (32 points).
    public static let extremelyLarge: CGFloat = 32
}

public extension View {
    /// - Returns: A view that's padded by the 16 points on the top edge.
    @inlinable func withTopMediumPadding() -> some View {
        self.padding(.top, Padding.medium)
    }
    
    /// - Returns: A view that's padded by 16 points on each horizontal edge.
    @inlinable func withHorizontalMediumPadding() -> some View {
        self.padding(.horizontal, Padding.medium)
    }
}

