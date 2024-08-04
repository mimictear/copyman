import SwiftData
import Foundation
import Observation

@Observable
public final class StorageProvider: @unchecked Sendable, Database {
    public static let shared = StorageProvider()
    public let container: ModelContainer
    
    /// Use an in-memory store to store non-persistent data when unit testing
    private init(useInMemoryStore: Bool = false) {
        let schema = Schema(CurrentScheme.models)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: useInMemoryStore)
        do {
            container = try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
