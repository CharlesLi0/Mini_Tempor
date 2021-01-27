//
//  DeveloperSceneUITest.swift
//  MiniTemporUITests
//
//  Created by Charles on 19/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest

class DeveloperSceneUITest: XCTestCase {
    var app : XCUIApplication!
    
    
    /// # the test starts on the scene of "About us"
    override func setUp() {
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
        
        app.tabBars.buttons["About us"].tap()
    }
    
    /// # postcondition: app = nil
    override func tearDown() {
        app = nil
    }
    
    /// # count the component
    func testComponentOfTheSceneOfAboutUs() {
        // navigation bar contains "developer"
        let n = app.navigationBars["Developers"].exists
        XCTAssertTrue(n)
        
        // cell have one image and two text
        let table = app.tables
        let cell1 = table.cells.element(boundBy: 0)
        let numImage = cell1.images.count
        let numText = cell1.staticTexts.count
        XCTAssertEqual(numImage, 1)
        XCTAssertEqual(numText, 2)
    }
    
    /// # action: transfer to the scene of Enrolling Developers
    func testToEnrollDevelopers() {
        app.navigationBars["Developers"].buttons["Enroll"].tap()
        XCTAssertTrue(app.navigationBars["Enroll"].exists)
    }
    
    /// # action: transfer to the scene of adding developers
    func testToAddDevelopers() {
        app.navigationBars["Developers"].buttons["Add"].tap()
        XCTAssertTrue(app.navigationBars["New"].exists)
    }
}
