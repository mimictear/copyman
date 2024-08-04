@preconcurrency import SwiftData
import Foundation

public protocol Database {
    var container: ModelContainer { get }
    
    func create<T>(_ item: T) throws where T: PersistentModel
    func create<T>(_ items: [T], autosave: Bool) throws where T: PersistentModel
    
    func read<T>(
        predicate: Predicate<T>?,
        sortBy sortDescriptors: SortDescriptor<T>...
    ) async throws -> [T] where T: PersistentModel
    
    func update<T>(_ item: T) throws where T: PersistentModel
    func delete<T>(_ item: T) throws where T: PersistentModel
    func delete<T>(predicate: Predicate<T>, autosave: Bool) throws where T: PersistentModel
}

public extension Database {
    func create<T: PersistentModel>(_ items: [T], autosave: Bool = true) throws {
        let context = ModelContext(container)
        for item in items {
            context.insert(item)
        }
        if autosave {
            try context.save()
        }
    }
    
    func create<T: PersistentModel>(_ item: T) throws {
        let context = ModelContext(container)
        context.insert(item)
        try context.save()
    }
    
    func read<T: PersistentModel>(predicate: Predicate<T>? = nil, sortBy sortDescriptors: SortDescriptor<T>...) throws -> [T] {
        let context = ModelContext(container)
        let fetchDescriptor = FetchDescriptor<T>(
            predicate: predicate,
            sortBy: sortDescriptors
        )
        return try context.fetch(fetchDescriptor)
    }
    
    func update<T: PersistentModel>(_ item: T) throws {
        let context = ModelContext(container)
        context.insert(item)
        try context.save()
    }
    
    func delete<T: PersistentModel>(_ item: T) throws {
        let context = ModelContext(container)
        let idToDelete = item.persistentModelID
        try context.delete(model: T.self, where: #Predicate { item in
            item.persistentModelID == idToDelete
        })
        try context.save()
    }
    
    func delete<T: PersistentModel>(predicate: Predicate<T>, autosave: Bool = true) throws {
        let context = ModelContext(container)
        try context.delete(model: T.self, where: predicate)
        if autosave {
            try context.save()
        }
    }
}
