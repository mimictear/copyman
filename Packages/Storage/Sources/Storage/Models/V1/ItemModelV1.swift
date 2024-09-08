import SwiftData
import Foundation

public typealias ItemModel = SchemaV1.Item

extension SchemaV1 {
    @Model
    public final class Item {
        public var title: String?
        public var content: String?
        public var pinned: Bool = false
        public var secured: Bool = false
        public var isURL: Bool = false //if the content is URL we can open it just by click
        public var timestamp: Date = Date.now
        public var items: [Tag]?
        
        public init(
            title: String?,
            content: String?,
            pinned: Bool = false,
            secured: Bool = false,
            isURL: Bool = false,
            timestamp: Date = .now
        ) {
            self.title = title
            self.content = content
            self.pinned = pinned
            self.secured = secured
            self.isURL = isURL
            self.timestamp = timestamp
        }
    }
}
