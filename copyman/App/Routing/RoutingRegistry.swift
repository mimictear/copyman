import SwiftUI

// TODO: Build views via some factory (and inject all necessary dependencies inhere)

@MainActor
extension View {
    func withSheetDestinations(sheetDestinations: Binding<SheetDestination?>) -> some View {
        sheet(item: sheetDestinations) { destination in
            Group {
                switch destination {
                case .settings: SettingsView()
                case .add: AddItemSheet()
                case .addNewTag: AddNewTagView()
                case .pins: AllPinsView()
                case .filter, .edit: EmptyView()
                }
            }
        }
    }
}
