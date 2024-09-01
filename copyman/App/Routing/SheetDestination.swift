import Foundation

enum SheetDestination: Identifiable {
    case settings
    case add
    case addNewTag
    case edit
    case pins
    case filter
    
    var id: String {
        switch self {
        case .settings: "sheet.settings"
        case .add: "sheet.add"
        case .addNewTag: "sheet.addNewTag"
        case .edit: "sheet.edit"
        case .pins: "sheet.pins"
        case .filter: "sheet.filter"
        }
    }
}
