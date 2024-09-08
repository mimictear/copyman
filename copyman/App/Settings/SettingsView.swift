import SwiftUI
import AnticsUI

// TODO: 1 - lock with FaceID; 2 - theme settings (accent color picker); 3 - privacy info; 4 - erase all data; 5 - tip jar (later)

enum AppTheme: String, CaseIterable, Identifiable {
    case system, light, dark
    var id: Self { self }
}

struct SettingsView: View {
    @State private var selectedAccentColor: Color = .red
    @State private var appTheme: AppTheme = .system
    
    var body: some View {
        // TODO: Accent color palette
        ClosableSheet {
            Text("Settings")
                .applyTextStyle(model: FontStyleModel(font: .title2, fontWeight: .bold))
        } content: {
            List {
                Section {
                    Picker("Theme", selection: $appTheme) {
                        ForEach(AppTheme.allCases) { item in
                            Text(item.rawValue)
                                .tag(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    ColorPicker(
                        "Accent color",
                        selection: $selectedAccentColor,
                        supportsOpacity: false
                    )
                } header: {
                    Text("Appearance")
                } footer: {
                    appVersion
                }
            }
        }
    }
    
    private var appVersion: some View {
        Text("App Version \(Bundle.fullAppVersion)")
            .applyTextStyle(model: FontStyleModel(font: .footnote))
    }
}
