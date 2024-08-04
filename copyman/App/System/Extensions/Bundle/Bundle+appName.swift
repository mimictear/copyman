import Foundation

public extension Bundle {
    var appName: String? {
        object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    var appDisplayName: String? {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    static var appDisplayName: String {
        Bundle.main.appDisplayName ?? "Pmtool"
    }
}
