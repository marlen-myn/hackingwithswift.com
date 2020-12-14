//
//  RollingDiceApp.swift
//  RollingDice
//
//  Created by Marlen Mynzhassar on 14.12.2020.
//

import SwiftUI

@main
struct RollingDiceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
