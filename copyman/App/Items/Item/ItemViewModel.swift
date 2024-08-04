import SwiftUI
import Foundation

@Observable
final class ItemViewModel {
    func copyTextToClipboard(_ text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
//        if withConfirmation {
//            showConfirmationSheet = .copy
//        }
    }
}
