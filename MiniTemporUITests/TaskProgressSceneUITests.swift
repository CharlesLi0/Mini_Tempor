//
//  TaskProgressSceneUITests.swift
//  MiniTemporUITests
//
//  Created by Charles on 22/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest

class TaskProgressSceneUITests: XCTestCase {
    
    var app : XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
        
        // jump to the Task priority Scene
        app.tables.children(matching: .cell).element(boundBy: 0).tap()
        app.navigationBars.buttons["Add"].tap()
        app.tables.staticTexts["Progress"].tap()
    }
    
    /// app = nil
    override func tearDown() {
        app = nil
    }

    func testComponentOfProgressScene() {
        // navigation bar "Task Priority"
        let navigationBar = app.navigationBars["Task Progress"]
        XCTAssert(navigationBar.exists)
        
        // navigation bar have a button "New Task"
        XCTAssert(navigationBar.buttons["New Task"].exists)
        
        // table have three label: "Low", "Medium"m "High"
        let table = app.tables;
        XCTAssert(table.staticTexts["To Do"].exists)
        XCTAssert(table.staticTexts["Doing"].exists)
        XCTAssert(table.staticTexts["Done"].exists)
    }
    
    
    /// #Action: chaning the priority and the choice will be changed follow the setting
    func testChangePriority() {
        let table = app.tables
        let toDoCell = table.cells.containing(.staticText, identifier: "To Do")
        let doingCell = table.cells.containing(.staticText, identifier: "Doing")
        let doneCell = table.cells.containing(.staticText, identifier: "Done")
        
        // the dafault is setting low
        XCTAssert(toDoCell.buttons["More Info"].exists)
        XCTAssert(!doingCell.buttons["More Info"].exists)
        XCTAssert(!doneCell.buttons["More Info"].exists)
        
        // change to medium
        doingCell.element.tap()
        
        // check the value should be set to the medium
        XCTAssert(!toDoCell.buttons["More Info"].exists)
        XCTAssert(doingCell.buttons["More Info"].exists)
        XCTAssert(!doneCell.buttons["More Info"].exists)
    }
}
