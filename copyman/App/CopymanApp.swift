import SwiftUI
import AnticsUI
import SwiftData

@main
struct CopymanApp: App {
    @State var theme = Theme.shared
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Tag.self,
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ItemsView()
                .environment(theme)
        }
        .modelContainer(sharedModelContainer)
    }
}
