import UIKit
import Observation

@Observable
final class AddItemViewModel {
    var title: String = ""
    var content: String = ""
    var applyValidation = false
    
    var isSecured = false
    var isLink = false
    
    var canAddItem: Bool {
        hasAppropriateTitle && hasAppropriateContent
    }
    
    var hasAppropriateTitle: Bool {
        !title.isEmpty
    }
    
    var hasAppropriateContent: Bool {
        !content.isEmpty
    }
    
    var hasValidExternalToolURL: Bool {
        guard let url = URL(string: content), UIApplication.shared.canOpenURL(url) else {
            return false
        }
        return true
    }
}
