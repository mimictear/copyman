import SwiftUI
import AlertToast
import Observation

public enum ConfirmationAlertKind: String {
    case copied = "Copied"
    case sent = "Sent"
    case saved = "Saved"
}

@Observable
public final class ConfirmationAlertState {
    public var kind: ConfirmationAlertKind = .copied
    public var showing = false
    
    public init() {}
    
    public func toggleAlert(kind: ConfirmationAlertKind) {
        self.kind = kind
        showing = true
    }
}

public struct ConfirmationAlert: ViewModifier {
    let title: String
    @Binding var showing: Bool
    let completion: (() -> Void)?
    
    public func body(content: Content) -> some View {
        content
            .toast(
                isPresenting: $showing,
                duration: 1,
                alert: {
                    AlertToast(
                        displayMode: .alert,
                        type: .complete(.white),
                        title: title,
                        style: .style(
                            backgroundColor: Color.overlaySystemAlertBackground,
                            titleColor: .white
                        )
                    )
                }, completion: {
                    showing = false
                    completion?()
                }
            )
    }
    
    public init(title: String, showing: Binding<Bool>, completion: (() -> Void)?) {
        self.title = title
        self._showing = showing
        self.completion = completion
    }
}

public extension View {
    func withConfirmationAlert(
        title: String,
        showing: Binding<Bool>,
        completion: (() -> Void)? = nil
    ) -> some View {
        modifier(
            ConfirmationAlert(
                title: title,
                showing: showing,
                completion: completion
            )
        )
    }
}
