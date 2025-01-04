//
//  CoreDataStorage.swift
//  StyleCast
//
//  Created by kyusok.lee on 2024/12/25.
//

import CoreData

private enum Const {
    static let appName = "StyleCast"
}

final class CoreDataStorage {

    static let shared = CoreDataStorage()
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Const.appName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                assertionFailure("CoreDataStorage has Error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                assertionFailure("CoreDataStorage has Error: \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

