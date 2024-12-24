//
//  nplusoneTests.swift
//  nplusoneTests
//
//  Created by clutchcoder on 11/4/24.
//

import Testing
import CoreData
@testable import nplusone

struct nplusoneTests {
    
    var auth: Auth!
    var moc: NSManagedObjectContext!

    @Test func testUserNotLoggedIn() async throws {
        let moc = PersistenceController(inMemory: true).container.viewContext
        let auth = Auth(context: moc)
        // Verify that the loggedIn property is set correctly based on the mock data
        assert(!auth.loggedIn, "loggedIn should be false if there is not at least one user")
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test func testUserLoggedIn() async throws {
       let moc = PersistenceController(inMemory: true).container.viewContext
       
       
       let newUser = User(context: moc)
       newUser.username = "testUser"
       do {
           try moc.save()
       } catch {
           assert(false,"Failed to save managed object context: \(error)")
       }
       let auth = Auth(context: moc)
       sleep(1)
       // Verify that the loggedIn property is set correctly based on the mock data
       assert(auth.loggedIn, "loggedIn should be true if there is at least one user")
    }

}
