//
//  PlanTypeSceneUITests.swift
//  MiniTemporUITests
//
//  Created by Charles on 22/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest

class PlanTypeSceneUITests: XCTestCase {
    
    var app : XCUIApplication!
    
    
    /// test on the plan type scene
    override func setUp() {
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
        
        // jump to the plan type scene
        app.navigationBars["Plan"].buttons["Add"].tap()
        app.staticTexts["Type"].tap()
    }
    
    /// app = nil
    override func tearDown() {
         app = nil
    }

    func testComponentOfType() {
        let tables = app.tables
        
        // have type "Study", "Work", "Shopping", "Travel", "Game", "Other"
        XCTAssert(tables/*@START_MENU_TOKEN@*/.staticTexts["Study"]/*[[".cells.staticTexts[\"Study\"]",".staticTexts[\"Study\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssert(tables.staticTexts["Work"].exists)
        XCTAssert(tables.staticTexts["Shopping"].exists)
        XCTAssert(tables.staticTexts["Travel"].exists)
        XCTAssert(tables.staticTexts["Game"].exists)
        XCTAssert(tables.staticTexts["Others"].exists)
        
        // navigationbar and it have a button "New Plan"
        let navigationbar = app.navigationBars["Plan Type"]
        XCTAssert(navigationbar.exists)
        XCTAssert(navigationbar.buttons["New Plan"].exists)
        
    }
    
    func testQuitTheTypeSelectedScene() {
       let navigationbar = app.navigationBars["Plan Type"]
        
        // quit the plan type scene
        navigationbar.buttons["New Plan"].tap()
        
        // the navigationbar will not exists any more
        XCTAssert(!navigationbar.exists)
    }
    
    
    /// #Action: change the priority and the choice will be changed follow the setting
    func testChangePriority() {
        let table = app.tables
        let studyCell = table.cells.containing(.staticText, identifier: "Study")
        let workCell = table.cells.containing(.staticText, identifier: "Work")
        let shoppingCell = table.cells.containing(.staticText, identifier: "Shopping")
        let travelCell = table.cells.containing(.staticText, identifier: "Travel")
        let gameCell = table.cells.containing(.staticText, identifier: "Game")
        let othersCell = table.cells.containing(.staticText, identifier: "Others")
        
        // the dafault is setting low
        XCTAssert(!studyCell.buttons["More Info"].exists)
        XCTAssert(!workCell.buttons["More Info"].exists)
        XCTAssert(!shoppingCell.buttons["More Info"].exists)
        XCTAssert(!travelCell.buttons["More Info"].exists)
        XCTAssert(!gameCell.buttons["More Info"].exists)
        XCTAssert(othersCell.buttons["More Info"].exists)
        
        
        // change to medium
        studyCell.element.tap()
        
        // check the value should be set to the medium
        XCTAssert(studyCell.buttons["More Info"].exists)
        XCTAssert(!workCell.buttons["More Info"].exists)
        XCTAssert(!shoppingCell.buttons["More Info"].exists)
        XCTAssert(!travelCell.buttons["More Info"].exists)
        XCTAssert(!gameCell.buttons["More Info"].exists)
        XCTAssert(!othersCell.buttons["More Info"].exists)
    }
    

}
