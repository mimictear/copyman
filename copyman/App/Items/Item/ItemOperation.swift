import Storage
import Foundation

enum ItemOperation {
    case add
    case edit(_ item: ItemModel)
    
    var sheetTitle: String {
        switch self {
        case .add: "Add item"
        case .edit: "Edit item"
        }
    }
    
    var submitButtonTitle: String {
        switch self {
        case .add: "Add item"
        case .edit: "Save"
        }
    }
}
