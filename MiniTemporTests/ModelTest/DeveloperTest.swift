//
//  DeveloperTest.swift
//  MiniTemporTests
//
//  Created by Charles on 19/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest
import UIKit
@testable import MiniTempor

class DeveloperTest: XCTestCase {

    
    override func setUp() {
    }

    override func tearDown() {
    }

    func testInitial() {
        // new a object of developer
        let name: String = "Tester"
        let uiImage: UIImage = UIImage()
        let developer: Developer = Developer(name: name, image: uiImage)
        
        // check the parameter of the new object
        XCTAssertEqual(developer.name, name)
        XCTAssertNotNil(developer.name)
        
    }
}
