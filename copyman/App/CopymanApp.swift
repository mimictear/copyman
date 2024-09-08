import Storage
import SwiftUI
import AnticsUI
import SwiftData

@main
struct CopymanApp: App {
    @State var theme = Theme.shared
    @State var storageProvider = StorageProvider.shared

    var body: some Scene {
        WindowGroup {
            ItemsView()
                .environment(theme)
        }
        .modelContainer(storageProvider.container)
    }
}
