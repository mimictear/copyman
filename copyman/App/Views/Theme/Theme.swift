import SwiftUI

@Observable
public final class Theme: @unchecked Sendable {
    public static let shared = Theme()
    
    class ThemeStorage {
        enum ThemeKey: String {
            case colorScheme, tint, label, primaryBackground, secondaryBackground
            case selectedSet, selectedScheme
        }
        
        @AppStorage(ThemeKey.selectedScheme.rawValue) public var selectedScheme: ColorScheme = .dark
        @AppStorage(ThemeKey.tint.rawValue) public var tintColor: Color = .black
        @AppStorage(ThemeKey.primaryBackground.rawValue) public var primaryBackgroundColor: Color = Color.contentBackground
        @AppStorage(ThemeKey.secondaryBackground.rawValue) public var secondaryBackgroundColor: Color = .gray
        
        init() {}
    }
    
    let themeStorage = ThemeStorage()
    
    public var selectedScheme: ColorScheme {
        didSet {
            themeStorage.selectedScheme = selectedScheme
        }
    }
    
    public var tintColor: Color {
        didSet {
            themeStorage.tintColor = tintColor
        }
    }
    
    public var primaryBackgroundColor: Color {
        didSet {
            themeStorage.primaryBackgroundColor = primaryBackgroundColor
        }
    }
    
    public var secondaryBackgroundColor: Color {
        didSet {
            themeStorage.secondaryBackgroundColor = secondaryBackgroundColor
        }
    }
    
    private init() {
        selectedScheme = themeStorage.selectedScheme
        tintColor = themeStorage.tintColor
        primaryBackgroundColor = themeStorage.primaryBackgroundColor
        secondaryBackgroundColor = themeStorage.secondaryBackgroundColor
    }
}
