//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Marlen Mynzhassar on 29.11.2020.
//

import SwiftUI
import CoreData

@main
struct CoreDataProjectApp: App {
    let persistenceController = PersistenceController.shared
    let viewContext: NSManagedObjectContext
    
    init() {
        viewContext = persistenceController.container.viewContext
        viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
