import Foundation

public extension Array {
    /// Replaces the last element of the array with the specified element.
    /// If the array is empty, no action is performed.
    ///
    /// - Parameter element: The element to replace the last element with.
    mutating func replaceLast(with element: Element) {
        guard !isEmpty else { return }
        self[count - 1] = element
    }
}
