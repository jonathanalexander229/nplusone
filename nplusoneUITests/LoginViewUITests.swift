//
//  LoginViewUITests.swift
//  nplusone
//
//  Created by clutchcoder on 12/22/24.
//


import XCTest

final class LoginViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchEnvironment["USE_IN_MEMORY_STORE"] = "true"
        app.launch()
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func login() {
        let usernameTextField = app.textFields["UsernameTextField"]
        
        XCTAssertTrue(usernameTextField.exists, "Username TextField should be visible")
        
        usernameTextField.tap()
        usernameTextField.typeText("testUser")
        
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        
        let contentView = app.otherElements["ContentView"]
        XCTAssertTrue(contentView.waitForExistence(timeout: 5), "Content View should be visible")
    }
    
    func logout() {
        let overflowMenuButton = app.navigationBars["N plus ONE"].buttons["More"]
        XCTAssertTrue(overflowMenuButton.exists, "Overflow Menu Button should exist")
        overflowMenuButton.tap()
        
        let logoutButton = app.buttons["Logout"]
      
        XCTAssertTrue(logoutButton.exists, "Logout Button should be visible")
        
        logoutButton.tap()
        
        XCTAssertTrue(app.textFields["UsernameTextField"].waitForExistence(timeout: 5), "Username TextField should be visible")
    }
    
    func addItem(){
        let nPlusOneNavigationBar = app/*@START_MENU_TOKEN@*/.navigationBars["N plus ONE"]/*[[".otherElements[\"ContentView\"].navigationBars[\"N plus ONE\"]",".navigationBars[\"N plus ONE\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let addItemButton = nPlusOneNavigationBar.buttons["Add Item"]
        XCTAssertTrue(nPlusOneNavigationBar.waitForExistence(timeout: 5), "Content View should be visible")
        XCTAssertTrue(addItemButton.waitForExistence(timeout: 5), "Content View should be visible")
        
        let tableView = self.app.otherElements["ContentView"]
        XCTAssertTrue(tableView.waitForExistence(timeout: 5), "Content View should be visible")
        
        let count = tableView.cells.count
        
        let expectation = expectation(description: "Item added")
        expectation.expectedFulfillmentCount = 1
        
        addItemButton.tap()
        
        debugPrint("cells count %s", tableView.cells.count)
        
        if tableView.cells.count == count + 1 {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testLoginFlow() {
        
        login()
        logout()
        
    }
    
    func testAddItem() {
        
        login()
        
        addItem()
        
        logout()
        
    }
    func testDeleteItem() {
        login()
        // Select an item to delete
        
        addItem()
        addItem()
        
        let tableView = self.app.otherElements["ContentView"]
        XCTAssertTrue(tableView.waitForExistence(timeout: 5), "Content View should be visible")
        
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "First Row should be visible")
        let count = tableView.cells.count
        
        firstCell.swipeLeft()
        
        let deleteButton = tableView.buttons["Delete"]
        deleteButton.tap()
        
        // Wait for the item to be deleted
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        
        if tableView.cells.count == count - 1 {
            expectation.fulfill()
        } else {
            
        }
        
        wait(for: [expectation], timeout: 2)
        logout()
        
    }
    
    func testViewItem() {
        login()
        // Select an item to delete
        
        addItem()
        addItem()
        
        let tableView = self.app.otherElements["ContentView"]
        XCTAssertTrue(tableView.waitForExistence(timeout: 5), "Content View should be visible")
        
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "First Row should be visible")
        
        //open the first item in the list
        firstCell.tap()
        
        debugPrint(app.staticTexts)
        XCTAssertTrue(app.staticTexts.firstMatch.waitForExistence(timeout: 5), "")
        
        app.buttons["N plus ONE"].tap()
     
        logout()
        
    }
    
}
