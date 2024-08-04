import SwiftData
import Foundation

@Model
final class Tag {
    var title: String?
    var items: [Item]?
    var timestamp: Date = Date.now
    
    init(title: String?, items: [Item]?, timestamp: Date = .now) {
        self.title = title
        self.items = items
        self.timestamp = timestamp
    }
}
