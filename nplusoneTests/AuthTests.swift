//
//  AuthTests.swift
//  nplusone
//
//  Created by clutchcoder on 12/15/24.
//

import XCTest
import CoreData
@testable import nplusone

class AuthTests: XCTestCase {
    
    var auth: Auth!
    var moc: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        // Create a new instance of PersistenceController with an in-memory store
        moc = PersistenceController(inMemory: true).container.viewContext
        //moc = PersistenceController.shared.container.viewContext
        }
    
    override func tearDown() {
        super.tearDown()
  
    }
    
    func testUserNotLoggedIn() {
       // let newUser = User(context: moc)
        self.auth = Auth(context: moc)
        // Verify that the loggedIn property is set correctly based on the mock data
        XCTAssertFalse(auth.loggedIn, "loggedIn should be false if there is not at least one user")
    }
    
    func testUserLoggedIn() {
        // Insert mock user data into the managed object context
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: moc) as! User
        newUser.username = "testUser"
        self.auth = Auth(context: moc)
        
        // Verify that the loggedIn property is set correctly based on the mock data
        XCTAssertTrue(auth.loggedIn, "loggedIn should be true if there is at least one user")
    }
    

}
