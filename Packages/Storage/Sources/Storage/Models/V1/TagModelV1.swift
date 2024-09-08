import SwiftData
import Foundation

public typealias TagModel = SchemaV1.Tag

extension SchemaV1 {
    @Model
    final public class Tag {
        var title: String?
        var items: [Item]?
        var timestamp: Date = Date.now
        
        init(title: String?, items: [Item]?, timestamp: Date = .now) {
            self.title = title
            self.items = items
            self.timestamp = timestamp
        }
    }
}
