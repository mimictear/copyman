import Foundation

public extension Bundle {
    var shortAppVersion: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
    
    var buildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? "0"
    }

    static var appVersion: String {
        Bundle.main.shortAppVersion
    }
    
    static var fullAppVersion: String {
        "\(Bundle.main.shortAppVersion) (\(Bundle.main.buildNumber))"
    }
}
