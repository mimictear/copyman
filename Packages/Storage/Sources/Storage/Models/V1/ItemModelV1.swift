import SwiftData
import Foundation

public typealias ItemModel = SchemaV1.ItemModel

extension SchemaV1 {
    @Model
    public final class ItemModel {
        var title: String?
        var content: String?
        var pinned: Bool = false
        var secured: Bool = false
        var isURL: Bool = false //if the content is URL we can open it just by click
        var timestamp: Date = Date.now
        var items: [TagModel]?
        
        init(title: String?, content: String?, pinned: Bool = false, secured: Bool = false, isURL: Bool = false, timestamp: Date = .now) {
            self.title = title
            self.content = content
            self.pinned = pinned
            self.secured = secured
            self.isURL = isURL
            self.timestamp = timestamp
        }
    }
}
