import Foundation

extension Array {
    mutating func replaceLast(with element: Element) {
        guard !isEmpty else { return }
        self[count - 1] = element
    }
}
