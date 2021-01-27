//
//  NewTaskSceneUITests.swift
//  MiniTemporUITests
//
//  Created by Charles on 22/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest

class NewTaskSceneUITests: XCTestCase {
    
    var app : XCUIApplication!
    
    
    /// # precondition: should on the new Task scene
    override func setUp() {
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
        
        // to the newTask scene
        app.tables.children(matching: .cell).element(boundBy: 0).tap()
        app.navigationBars.buttons["Add"].tap()
    }
    
    /// # postcondition: app = nil
    override func tearDown() {
        app = nil
    }

    func testComponentOfNewTaskScene() {
        // hava a navigation bar "New Task"
        let navigationbar = app.navigationBars["New Task"]
        XCTAssert(navigationbar.exists)
        
        // navigation have two buttons: "Cancel", "Save"
        XCTAssert(navigationbar.buttons["Cancel"].exists)
        XCTAssert(navigationbar.buttons["Save"].exists)
        
        // get the table
        let table = app.tables
        
        // hava a image and a button for adding image
        XCTAssert(table.images.count == 1)
        XCTAssert(table.children(matching: .button).element.exists)
        
        // have "TITLE" and "DESCRIPTION"
        XCTAssert(table.children(matching: .other)["TITLE"].exists)
        XCTAssert(table.children(matching: .other)["DESCRIPTION"].exists)
        
        // have two textField
        let firstCell = table.children(matching: .cell).element(boundBy: 0)
        let secordCell = table.children(matching: .cell).element(boundBy: 1)
        XCTAssert(firstCell.textFields.element.exists)
        XCTAssert(secordCell.textViews.element.exists)
        
        // have "Start Date", "Due Date"
        XCTAssert(table.staticTexts["Start Date"].exists)
        XCTAssert(table.staticTexts["Due Date"].exists)
        
        // have "Priority", and have a button["More Infor"]
        XCTAssert(table.staticTexts["Priority"].exists)
        XCTAssert(table.cells.containing(.staticText, identifier:"Priority").buttons["More Info"].exists)
        
        // have "Progress" , and have a button["More Infor"]
        XCTAssert(table.staticTexts["Progress"].exists)
        XCTAssert(table.cells.containing(.staticText, identifier:"Progress").buttons["More Info"].exists)
    }
    
    
    /// # action: change the priority and the priority of the task should be changed
    func testChangePriority() {
        let table = app.tables.element(boundBy: 0)
        
        // now the value
        let low = table.staticTexts["Low"]
        XCTAssert(low.exists)
        
        // expect value
        let high = table.staticTexts["High"]
        XCTAssert(!high.exists)
        
        // change the priority
        low.tap()
        table.staticTexts["High"].tap()
        app.navigationBars.buttons["New Task"].tap()
        
        // check the value, low is didappear, high is appear
        XCTAssert(!low.exists)
        XCTAssert(high.exists)
        
    }
    
    func testChangeProgress() {
        let table = app.tables.element(boundBy: 0)
        
        // now the value
        let toDo = table.staticTexts["To Do"]
        XCTAssert(toDo.exists)
        
        // expected value
        let doing = table.staticTexts["Doing"]
        XCTAssert(!doing.exists)
        
        // change the progress
        toDo.tap()
        table.staticTexts["Doing"].tap()
        app.navigationBars.buttons["New Task"].tap()
        
        // check the value , todo is disappear, doing is appear
        XCTAssert(!toDo.exists)
        XCTAssert(doing.exists)
        
        
    }
    
    
    /// # action: tap the button of adding picture and a sheet pop up
    func testAddPicture1() {
        // the button for adding the picture
        let button = app.tables.children(matching: .button).element
        button.tap()
        
        // chooseImageSheet exit
        let chooseImageSheet = app.sheets["Choose Image"]
        XCTAssert(chooseImageSheet.exists)
        
        // hava  buttons "Photo Library", "Cancel", text: "Choose Image"
        XCTAssert(chooseImageSheet.staticTexts["Choose Image"].exists)
        XCTAssert(chooseImageSheet.buttons["Photo Library"].exists)
        XCTAssert(chooseImageSheet.buttons["Cancel"].exists)
        
    }

}
