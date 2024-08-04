import SwiftUI
import AnticsUI

// TODO: 1 - lock with FaceID; 2 - theme settings (accent color picker); 3 - privacy info; 4 - erase all data; 5 - tip jar (later)

struct SettingsView: View {
    @State private var selectedAccentColor: Color = .red
    
    var body: some View {
        // TODO: Accent color palette
        ClosableSheet {
            Text("Settings")
                .applyTextStyle(model: FontStyleModel(font: .title2, fontWeight: .bold))
        } content: {
            List {
                Section(footer: appVersion) {
                    ColorPicker(
                        "Accent color",
                        selection: $selectedAccentColor,
                        supportsOpacity: false
                    )
                }
            }
        }
    }
    
    private var appVersion: some View {
        Text("App Version \(Bundle.fullAppVersion)")
            .applyTextStyle(model: FontStyleModel(font: .footnote))
    }
}
