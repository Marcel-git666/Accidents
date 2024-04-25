//
//  CoreDataManager.swift
//  Accidents
//
//  Created by Marcel Mravec on 15.03.2024.
//

import CoreData

class CoreDataManager {

  static let shared = CoreDataManager() // Singleton instance

  private let persistentContainer: NSPersistentContainer

  init() {
    persistentContainer = NSPersistentContainer(name: Constants.containerName)
    persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        // Handle loading errors
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
  }

  func viewContext() -> NSManagedObjectContext {
    return persistentContainer.viewContext
  }
}
