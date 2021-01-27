//
//  NewPlanScenUITests.swift
//  MiniTemporUITests
//
//  Created by Charles on 22/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest

class NewPlanScenUITests: XCTestCase {
    
    var app : XCUIApplication!
    
    
    /// test on the adding plan scene
    override func setUp() {
        
        app = XCUIApplication()
        
        continueAfterFailure = false

        app.launch()
        
        // jump to the adding plan scene
        app.navigationBars["Plan"].buttons["Add"].tap()
    }
    
    
    /// app = nil
    override func tearDown() {
        app = nil
    }
    
    
    /// # action: count the component on the new plan scene
    func testComponentsOfNewPlanScene() {
        // navigationbars exist
        let navigationBar = app.navigationBars["New Plan"]
        XCTAssert(navigationBar.exists)
        
        // navigation bar have two button "save" and "cancel"
        XCTAssert(navigationBar.buttons["Save"].exists)
        XCTAssert(navigationBar.buttons["Cancel"].exists)
        
        // table
        let tablesQuery = app.tables
        
        // have a image and a button
        XCTAssert(tablesQuery.children(matching: .button).element.exists)
        XCTAssert(tablesQuery.images.element.exists)
    
        // have "NAME", "decription"
        XCTAssert(tablesQuery.children(matching: .other)["NAME"].exists)
        XCTAssert(tablesQuery.children(matching: .other)["DESCRIPTION"].exists)
        
       // have two textField
        let firstCell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        let secornCell = tablesQuery.children(matching: .cell).element(boundBy: 1)
        XCTAssert(firstCell.textFields.element.exists)
        XCTAssert(secornCell.textFields.element.exists)
        
        // have "Type" and "Others"
        XCTAssert(tablesQuery.staticTexts["Type"].exists)
        XCTAssert(tablesQuery.staticTexts["Others"].exists)
    }
    
    
    /// # action: tap the button of adding picture and a sheet pop up
    func testAddPicture1() {
        // the button for adding the image
        let button = app.tables.children(matching: .button).element
        
        button.tap()
        
        // chooseImageSheet exist
        let chooseImageSheet = app.sheets["Choose Image"]
        XCTAssert(chooseImageSheet.exists)
        
        // hava  buttons "Photo Library", "Cancel", text: "Choose Image"
        XCTAssert(chooseImageSheet.staticTexts["Choose Image"].exists)
        XCTAssert(chooseImageSheet.buttons["Photo Library"].exists)
        XCTAssert(chooseImageSheet.buttons["Cancel"].exists)
    }
    
    
    /// # action: change the type of a plan
    func testChangeType(){
        let table = app.tables.element(boundBy: 0)
        let type = table.staticTexts["Type"]
        let other = table.staticTexts["Other"]
        let game = table.staticTexts["Game"]
        
        // the tyoe is not game at the begining
        XCTAssert(!game.exists)
        
        // change the type to be the game
        type.tap()
        table/*@START_MENU_TOKEN@*/.staticTexts["Game"]/*[[".cells.staticTexts[\"Game\"]",".staticTexts[\"Game\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Plan Type"].buttons["New Plan"].tap()
        
        // have game at the end
        XCTAssert(game.exists)
    }
}
