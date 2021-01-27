//
//  SummarySceneUITest.swift
//  MiniTemporUITests
//
//  Created by Charles on 19/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest

class SummarySceneUITest: XCTestCase {
    var app : XCUIApplication!
    
    
    
    /// # the test start on the Summary Scene
    override func setUp() {
        app = XCUIApplication()
        
        continueAfterFailure = false
        
        app.launch()
        
        app.tabBars.buttons["Summary"].tap()
        
        
    }
    
    /// # postcondition: app = nil
    override func tearDown() {
        app = nil
    }
    
    
    /// # action: count the component on the plan scene
    func testComponentOfTheSummaryScene() {
        // it has two imgages
        let numText = app.images.count
        XCTAssertEqual(numText, 2)
        
        // have two plain text with "Task Overall" and "Plan Overall" respectively
        let t = app.staticTexts["Task Overall"].exists
        let p = app.staticTexts["Plan Overall"].exists
        XCTAssertTrue(t)
        XCTAssertTrue(p)
    }

}
