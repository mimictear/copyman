import SwiftUI

enum ItemSwipeAction {
    case none, pin, edit, delete
    
    var tintColor: Color {
        switch self {
        case .none: .clear
        case .pin: .blue
        case .edit: .yellow
        case .delete: .red
        }
    }
}
