import Storage
import SwiftData
import Foundation

@Model
final class Tag {
    var title: String?
    var items: [ItemModel]?
    var timestamp: Date = Date.now
    
    init(title: String?, items: [ItemModel]?, timestamp: Date = .now) {
        self.title = title
        self.items = items
        self.timestamp = timestamp
    }
}
