import Storage
import Foundation

enum SheetDestination: Identifiable {
    case settings
    case add
    case edit(ItemModel)
    case addNewTag
    case pins
    case filter
    
    var id: String {
        switch self {
        case .settings: "sheet.settings"
        case .add: "sheet.add"
        case .edit: "sheet.edit"
        case .addNewTag: "sheet.addNewTag"
        case .pins: "sheet.pins"
        case .filter: "sheet.filter"
        }
    }
}
