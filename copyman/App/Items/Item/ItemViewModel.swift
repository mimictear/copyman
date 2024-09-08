import Storage
import SwiftUI
import Foundation

enum ItemAction: Equatable {
    case idle
    case edit(item: ItemModel)
    case copy(content: String)
    case pinOrUnpin(item: ItemModel)
    case delete
}

@Observable
final class ItemViewModel {
    private(set) var event = ItemAction.idle
    var showDeleteConfirmation = false
    
    func copyTextToClipboard(_ text: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }
    
    func dispatch(event: ItemAction) {
        switch event {
        case .edit:
            break
        case .pinOrUnpin:
            break
        case let .copy(content):
            copyTextToClipboard(content)
        case .delete:
            showDeleteConfirmation.toggle()
        default: break
        }
        self.event = event
    }
}
