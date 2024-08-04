import SwiftData
import Foundation

public typealias TagModel = SchemaV1.TagModel

extension SchemaV1 {
    @Model
    public final class TagModel {
        var title: String?
        var items: [ItemModel]?
        var timestamp: Date = Date.now
        
        init(title: String?, items: [ItemModel]?, timestamp: Date = .now) {
            self.title = title
            self.items = items
            self.timestamp = timestamp
        }
    }
}
