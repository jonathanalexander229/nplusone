//
//  nplusoneApp.swift
//  nplusone
//
//  Created by clutchcoder on 11/4/24.
//

import SwiftUI

@main
struct nplusoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
