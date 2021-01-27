//
//  TaskPrioritySceneUITests.swift
//  MiniTemporUITests
//
//  Created by Charles on 22/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest

class TaskPrioritySceneUITests: XCTestCase {
    
    var app : XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
        
        // jump to the Task priority Scene
        app.tables.children(matching: .cell).element(boundBy: 0).tap()
        app.navigationBars.buttons["Add"].tap()
        app.tables.staticTexts["Priority"].tap()
    }
    
    /// app = nil
    override func tearDown() {
        app = nil
    }
    
    
    /// #Action: count the component on the priority scene
    func testComponentOfPriorityScene() {
        // navigation bar "Task Priority"
        let navigationBar = app.navigationBars["Task Priority"]
        XCTAssert(navigationBar.exists)
        
        // navigation bar have a button "New Task"
        XCTAssert(navigationBar.buttons["New Task"].exists)
        
        // table have three label: "Low", "Medium"m "High"
        let table = app.tables;
        XCTAssert(table.staticTexts["Low"].exists)
        XCTAssert(table.staticTexts["Medium"].exists)
        XCTAssert(table.staticTexts["High"].exists)
    }
    
    
    /// #Action: change the priority and the choice will be changed follow the setting
    func testChangePriority() {
        let table = app.tables
        let lowCell = table.cells.containing(.staticText, identifier: "Low")
        let mediunCell = table.cells.containing(.staticText, identifier: "Medium")
        let highCell = table.cells.containing(.staticText, identifier: "high")
        
        // the dafault is setting low
        XCTAssert(lowCell.buttons["More Info"].exists)
        XCTAssert(!mediunCell.buttons["More Info"].exists)
        XCTAssert(!highCell.buttons["More Info"].exists)
        
        // change to medium
        mediunCell.element.tap()
        
        // check the value should be set to the medium
        XCTAssert(!lowCell.buttons["More Info"].exists)
        XCTAssert(mediunCell.buttons["More Info"].exists)
        XCTAssert(!highCell.buttons["More Info"].exists)
    }

}
