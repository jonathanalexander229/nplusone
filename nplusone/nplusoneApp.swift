//
//  nplusoneApp.swift
//  nplusone
//
//  Created by clutchcoder on 11/4/24.
//

import SwiftUI
import CoreData

@main
struct nplusoneApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var auth = Auth(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            if auth.loggedIn {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(auth)
            }
            else{
                LoginView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(auth)
            }
        }
    }
}

class UseInMemoryStoreEnvironmentObject: ObservableObject {
    @Published var useInMemoryStore: Bool = false
}
