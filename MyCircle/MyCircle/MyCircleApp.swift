//
//  MyCircleApp.swift
//  MyCircle
//
//  Created by Marlen Mynzhassar on 30.11.2020.
//

import SwiftUI
import CoreData

@main
struct MyCircleApp: App {
    let persistenceController = PersistenceController.shared
    let viewContext: NSManagedObjectContext
    
    init() {
        viewContext = persistenceController.container.viewContext
        //viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
