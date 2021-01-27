//
//  PlanViewModelTest.swift
//  MiniTemporTests
//
//  Created by Charles on 20/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest
@testable import MiniTempor

class PlanViewModelTest: XCTestCase {
    var planViewModel: PlanViewModel!
    var planManager: PlanManager!
    // data
    let planName = "Charles"
    
    /// initial the plan view model
    override func setUp() {
        planViewModel = PlanViewModel.shared
        planManager = PlanManager.shared

    }
    
    
    /// plan view model = nil
    override func tearDown() {
        // clear the plan called "Charles"
        planManager.deletePlan(planName)
        
        planViewModel = nil
        
        
    }
    
    
    /// check the parameters after initial the plan view model
    func testInitial() {
        // precondition: initial the plan view model
        // already done on the setUp()
        
        // check parameters
        XCTAssertNotNil(planViewModel.planList)
        XCTAssertNotNil(planViewModel.planManager)
    }
    
    /// check addPlan()
    func testAddPLan() {
        // precondition: the name of last item of the list is not "Chales"
        var planList = planViewModel.planList
        XCTAssertNotEqual(planList[planList.count - 1].planName, self.planName)
        
        // action add plan called "Charles" to the list
        let newPlan = PlanManager.shared.createPlan(self.planName, UIImage(), PlanType.study, "Charles test")
        planViewModel.addPlan(newPlan)
        
        // check parameters
        planList = planViewModel.planList
        let lastPlan = planList[planList.count - 1]
        XCTAssertEqual(lastPlan.planName, self.planName)
    }
    
    
    /// test the performance of adding plan
    func testPerformanceOfAddingPlan() {
        // new plan
        let newPlan = PlanManager.shared.createPlan(self.planName, UIImage(), PlanType.study, "Charles test")
        
        self.measure {
            // add plan
            planViewModel.addPlan(newPlan)
        }
    }
    
    /// check addPlan()
    func testRemovePLan() {
        // precondition: list have a plan called "Charles"
        let newPlan = PlanManager.shared.createPlan(self.planName, UIImage(), PlanType.study, "Charles test")
        planViewModel.addPlan(newPlan)
        let lastIndex = planViewModel.planList.count - 1
        XCTAssertEqual(planViewModel.planList[lastIndex].planName, planName)
        
        // action add plan called "Charles" to the list
        planViewModel.removePlan(at: lastIndex)
        
        // check parameters
        XCTAssertEqual(planViewModel.planList.count - 1, lastIndex - 1)
        XCTAssertNotEqual(planViewModel.planList[lastIndex - 1].planName, planName)
    }
    
    
}
