import UIKit
import CoreHaptics

@MainActor
public class HapticManager {
    public enum HapticType {
        case buttonPress
        case dataRefresh(intensity: CGFloat)
        case notification(_ type: UINotificationFeedbackGenerator.FeedbackType)
        case tabSelection
    }
    
    public static let shared: HapticManager = .init()
    
    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    private let notificationGenerator = UINotificationFeedbackGenerator()
    
    private init() {
        selectionGenerator.prepare()
        impactGenerator.prepare()
    }
    
    @MainActor
    public func fireHaptic(_ type: HapticType) {
        guard supportsHaptics else { return }
        
        switch type {
        case .buttonPress:
            impactGenerator.impactOccurred()
        case let .dataRefresh(intensity):
            impactGenerator.impactOccurred(intensity: intensity)
        case let .notification(type):
            notificationGenerator.notificationOccurred(type)
        case .tabSelection:
            selectionGenerator.selectionChanged()
        }
    }
    
    public var supportsHaptics: Bool {
        CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }
}
