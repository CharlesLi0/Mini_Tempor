//
//  TaskSceneUITests.swift
//  MiniTemporUITests
//
//  Created by Charles on 22/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest

class TaskSceneUITests: XCTestCase {
    
    var app : XCUIApplication!
    
    /// record the title of the tapped plan
    var title : String!
    
    /// test on the Task scene and should using the plan's title in the task scene
    override func setUp() {
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
        
        // record the title of the plan
        let firstPlan = app.tables.children(matching: .cell).element(boundBy: 0).staticTexts.element(matching: .any, identifier: "planName_planScene")
        self.title = firstPlan.label
        
        // jump to the Task scene
        firstPlan.tap()
    }
    
    /// app = nil
    override func tearDown() {
        if (app != nil) {
            app = nil
        }
    }
    
    
    /// # action: count the component of the task scene
    func testComponentOfTaskScene() {
        // navigation bar
        let navigationBar = app.navigationBars[title]
        XCTAssert(navigationBar.exists)
        
        // navigation has three button: "Plan", "Edit", "Add"
        XCTAssert(navigationBar.buttons["Plan"].exists)
        XCTAssert(navigationBar.buttons["Edit"].exists)
        XCTAssert(navigationBar.buttons["Add"].exists)
       
        // a table
        let table = app.tables
        
        // the task have an image, task title, task date, task description, priority, progress
        let firstTask = table.children(matching: .cell)
        .element(boundBy: 0)
        
        XCTAssertEqual(firstTask.images.count, 1)
        
        XCTAssertNotEqual(firstTask.staticTexts.element(matching: .any, identifier: "TaskTitle").label, "")
        
        XCTAssertNotEqual(firstTask.staticTexts.element(matching: .any, identifier: "TaskDate").label, "")
        
        XCTAssert(firstTask.textViews["TaskDescription"].exists)
        
        XCTAssertNotEqual(firstTask.staticTexts.element(matching: .any, identifier: "Priority").label, "")
        
        XCTAssertNotEqual(firstTask.staticTexts.element(matching: .any, identifier: "Progress").label, "")
        
    }
    
    /// # precondition: should have a least one task on the task list
    /// # action: delete a task from the task list, and the number of the tasks should be reduced
    func testDeleteTask() {
        
        // tap the edit button
        let editButton = app.navigationBars.buttons["Edit"]
        editButton.tap()
        
        // record the num of task before deleting the task
        let table = app.tables
        let numTaskBefore = table.cells.count
        
        // delete the first plan
        table.buttons.element(boundBy: 0).tap()
        table.buttons["Delete"].tap()
        
        // record the num of task after deleting the task
        let numTaskAfter = table.cells.count
        
        // numTaskbefore = numTaskAfter + 1
        XCTAssertEqual(numTaskBefore, numTaskAfter + 1)
    }
    
    
    /// #important: enable the keyboard display on the simulator
    /// #Action: add a task and the new one should be found on the task list
    func testAddTask() {
        // the content of the new task
        let newTitle = "charles"
        let newDesc = "Haha"
    
        // to the add task scene
        app.navigationBars.buttons["Add"].tap()
        
        // tab the title text flied
        let tables = app.tables
        tables.children(matching: .cell).element(boundBy: 0).children(matching: .textField).element.tap()
        
        // input value new title
        for c in newTitle {
            let key = app.keys[String(c)]
            key.tap()
        }
        
        // tap the textView for the description
        tables.children(matching: .cell).element(boundBy: 1).children(matching: .textView).element.tap()
        
        // input value new Description
        for c in newDesc {
            let key = app.keys[String(c)]
            key.tap()
        }
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        // select the priority
        tables.staticTexts["Priority"].tap()
        tables.staticTexts["High"].tap()
        app.navigationBars["Task Priority"].buttons["New Task"].tap()
        
        // set the progress
        tables.staticTexts["Progress"].tap()
        tables.staticTexts["Doing"].tap()
        app.navigationBars["Task Progress"].buttons["New Task"].tap()
        
        // save the new Task
        app.navigationBars["New Task"].buttons["Save"].tap()
        
        // get the lask task from the task list
        app.tables.element.swipeUp()
        let numTaskAfter = app.tables.children(matching: .cell).count
        let lastCell = app.tables.children(matching: .cell).element(boundBy: numTaskAfter - 1)
        
        // assert the title should same with the new one
        XCTAssertEqual(lastCell.staticTexts.element(matching: .any, identifier: "TaskTitle").label, "Charles")
    
        // assert the description should same with the new one
        let finalDesc = lastCell.textViews["TaskDescription"].value as! String
        XCTAssertEqual(finalDesc, newDesc)
    }
    
    
}
