//
//  PlanSceneUITests.swift
//  MiniTemporUITests
//
//  Created by Charles on 22/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest

class PlanSceneUITests: XCTestCase {
    
    var app : XCUIApplication!
    
    
    /// # precondition: the test start on the plan scene
    /// # some test should enable the keyboard displayed on the simulator
    override func setUp() {
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
    }
    
    
    /// # postcondition: app = nil
    override func tearDown() {
        app = nil
    }
    
  
    /// # action: count the component on the plan scene
    func testComponentOfPlanScene() {
        // have a navigation bar
        let navigationbar = app.navigationBars["Plan"]
        XCTAssert(navigationbar.exists)
        
        // have a edit button on the navigation bar
        XCTAssert(navigationbar.buttons["Edit"].exists)
        
        // have a add button on the navigation bar
        XCTAssert(navigationbar.buttons["Add"].exists)
        
        // have a table
        let tables = app.tables
        XCTAssertEqual(tables.count, 1)
        
        // the cell in the tabel have a image and tree label
        let firstCell = tables.children(matching: .cell).element(boundBy: 0)
        XCTAssertEqual(firstCell.images.count, 1)
    
        // tab bar hava a button "plan", "Summary" and "About us"
        let tabBar = app.tabBars
        XCTAssert(tabBar.buttons["Plan"].exists)
        XCTAssert(tabBar.buttons["Summary"].exists)
        XCTAssert(tabBar.buttons["About us"].exists)
    }
    
    
    /// # action: check the tab Bar can be clicked to transger to other scene
    func testTabBar() {
        // to the scene of the "summary"
        app.tabBars.buttons["Summary"].tap()
        let t = app.staticTexts["Task Overall"].exists
        XCTAssertTrue(t)
        
        // to the scene of the "About us"
        app.tabBars.buttons["About us"].tap()
        let n = app.navigationBars["Developers"].exists
        XCTAssertTrue(n)
        
    }
    
    
    /// # action: tap the edit button, the edit button will disappear, done button appear, and have some button appear on the table
    func testTapingEditButtonChangeTheView() {
        
        let table = app.tables
        let button  = table.buttons.element
        
        // do not have button on the table
        XCTAssert(!button.exists)
        
        // tap the edit button on the left of the navigationn bar
        let editButton = app.navigationBars.buttons["Edit"]
        editButton.tap()
        
        
        let doneButton = app.navigationBars.buttons["Done"]
        // edit buttion do not exit and Done button exist
        XCTAssert(!editButton.exists)
        XCTAssert(doneButton.exists)
        
        // have buttons on the table
        XCTAssert(button.exists)
    }
    
     /// # action: edit plans and delete the first plan and count the difference of the number of plans
    func testDelectAPlan() {
        
        // tap the edit button on the left of the navigationn bar
        app.navigationBars.buttons["Edit"].tap()
        
        // record the num of row before delete it
        let table  = app.tables
        let numRowBefore = table.cells.count
        
        // delele the first row of the plan list
        table.buttons.element(boundBy: 0).tap()
        app.buttons["Delete"].tap()
        
        // record the num of row after delete it
        let numRowAfter = table.cells.count
        
        // the numRowAfter + 1 == numrowBefore
        XCTAssertEqual(numRowBefore, numRowAfter + 1)
    }
    
    
    /// # Important: should allow the keyboard displayed on the screen
    /// # action: add a plan and fill the name with "Charles", descrition with "forever" and type with "Game", and check the new plan exists on the plan list
    func testAddPlan() {
    
        // tap the add button on the right of the navigation bar
        app.navigationBars["Plan"].buttons["Add"].tap()
        
        // tap the name textField and type "Charles"
        app.tables.children(matching: .cell).element(boundBy: 0).children(matching: .textField).element.tap()
        let name = "charles"
        for x in name {
            let key = app.keys[String(x)]
            key.tap()
        }
        
        // tap the description textfield and type "forever"
        app.tables.children(matching: .cell).element(boundBy: 1).children(matching: .textField).element.tap()
        let description = "forever"
        for x in description {
            let key = app.keys[String(x)]
            key.tap()
        }
        
        // tap the type to choose the game for the type of the plan
        app.tables.staticTexts["Others"].tap()
        app.tables.staticTexts["Game"].tap()
        
        // back to the page of the new plan than save the new plan
        app.navigationBars["Plan Type"].buttons["New Plan"].tap()
        app.navigationBars["New Plan"].buttons["Save"].tap()
        
        // check the new plan is created and exist on the plan list scence
        app.tables.element.swipeUp()
        let numCells = app.tables.cells.count
        let lastCell = app.tables.children(matching: .cell).element(boundBy: numCells - 1)
        
        // check the last cell have "Charles", "Game", "forever"
        XCTAssert(lastCell.staticTexts["Charles"].exists)
        XCTAssert(lastCell.staticTexts["Game"].exists)
        XCTAssert(lastCell.staticTexts["forever"].exists)
        
        // delete the new Item
        app.navigationBars.buttons["Edit"].tap()
        let numButtons = app.tables.buttons.count
        print(numButtons)
        app.tables.buttons.element(boundBy: numButtons - 1).tap()
        lastCell.buttons["Delete"].tap()
    }
    
    
    /// #action tap a plan will jump to the Task Scene
    func testTapPlanToTask() {
        // get the first cell of the table view
        let tabel = app.tables
        let firstCell = tabel.children(matching: .cell).element(boundBy: 0)
        
        // get the label of the first plan and record its label
        let firstPlan = firstCell.staticTexts.element(matching: .any, identifier: "planName_planScene")
        let firstLabel = firstPlan.label
        
        // tap the first plan
        firstPlan.tap()
        
        // jump to the task and the navigation should have the name same will the plan's title
        let navigation = app.navigationBars[firstLabel]
        XCTAssert(navigation.exists)
        
    }

}
