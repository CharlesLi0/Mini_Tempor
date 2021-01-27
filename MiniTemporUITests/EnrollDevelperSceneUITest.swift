//
//  EnrollDevelperSceneUITest.swift
//  MiniTemporUITests
//
//  Created by Charles on 19/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest

class EnrollDevelperSceneUITest: XCTestCase {
    var app : XCUIApplication!
    
    /// * Important: some test need the simulator be enable to show the keyboard
    /// # The test starts on the scene of enrolling the Developers
    override func setUp() {
        app = XCUIApplication()
        
        continueAfterFailure = false

        XCUIApplication().launch()

        app.tabBars.buttons["About us"].tap()
        app.navigationBars["Developers"].buttons["Enroll"].tap()
    }

    
    /// # postcondition: app = nil
    override func tearDown() {
        app = nil
    }
    
    /// # count the component
    func testComponentsOfTheSceneOfEnrolling() {
        // navigation bar and have two buttons "Developers" and "Done"
        let navigation = app.navigationBars["Enroll"]
        XCTAssertTrue(navigation.exists)
        let backToDevelopers = navigation.buttons["Developers"]
        XCTAssertTrue(backToDevelopers.exists)
        let done = navigation.buttons["Done"]
        XCTAssertTrue(done.exists)
        
        // table
        let tables = app.tables
        
        // has a button and image
        let hasButton = app.tables.cells.containing(.image, identifier:"placeholder").children(matching: .button).element.exists
        XCTAssert(hasButton)
        XCTAssert(tables.images.element.exists)
        
        // have "DEVELOPER IMAGE", "DEVELOPER NAME"
        XCTAssert(tables.children(matching: .other)["DEVELOPER IMAGE"].exists)
        XCTAssert(tables.children(matching: .other)["DEVELOPER NAME"].exists)
        
        
        // have a textField to enter the name
        XCTAssert(tables.textFields["Enter the name"].exists)
    }
    
    /// # action: adding picture should have a sheet popup
    func testAddingPicture() {
        // click the button of adding image
        app.tables.cells.containing(.image, identifier: "placeholder").children(matching: .button).element.tap()
        
        // have sheets called "Chooce Image"
        let sheets = app.sheets["Choose Image"]
        XCTAssertTrue(sheets.exists)
        
        // have buttons called "Photo Library" and "Cancel"
        XCTAssertTrue(sheets.buttons["Photo Library"].exists)
        XCTAssertTrue(sheets.buttons["Cancel"].exists)
    }
    
    /// # action: click the "develops" button to back to the scene of "developers"
    func testBackToTheSceneOfDevelopers() {
        // click "Developers" button on the navigation bar
        app.navigationBars.buttons["Developers"].tap()
        XCTAssertTrue(app.navigationBars["Developers"].exists)
    }
    
    /// # important: shold enable to show the keyboard on the simulator
    /// # action: type name and click "Done", a popup with failure should show.
    func testDoneWithFailure() {
        // click "enther the name" textField
        app.tables.textFields["Enter the name"].tap()
        // type name
        let name = "charles"
        for x in name {
            let key = app.keys[String(x)]
            key.tap()
        }
        //finish typing
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // click the "Done" button
        app.navigationBars.buttons["Done"].tap()
    
        // waitting for the error alert with 5 second in maximum
        let errorAlert = app.alerts["Error"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: errorAlert, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        // check the text on the error and cancel button
        XCTAssertTrue(errorAlert.staticTexts["Error"].exists)
        XCTAssertTrue(errorAlert.staticTexts["No faces found in the image"].exists)
        XCTAssertTrue(errorAlert.buttons["Cancel"].exists)
    }

}
