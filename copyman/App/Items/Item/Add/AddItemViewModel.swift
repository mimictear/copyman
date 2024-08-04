import UIKit
import Observation

@Observable
final class AddItemViewModel {
    var title: String = ""
    var content: String = ""
    var applyValidation = false
    
    var keyboardType: UIKeyboardType = .default
    
    var keyboardTypeIcon: String {
        keyboardType == .default ? "123.rectangle" : "keyboard"
    }
    
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
    
    func switchKeyboardType(onSubmit: () -> Void) {
        keyboardType = keyboardType == .default ? .decimalPad : .default
        onSubmit()
    }
}
