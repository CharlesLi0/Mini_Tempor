//
//  PlanManagerTests.swift
//  MiniTemporTests
//
//  Created by Charles on 19/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest
import UIKit
@testable import MiniTempor

class PlanManagerTests: XCTestCase {
    
    var planManager: PlanManager!
    
    // data
    let planName = "Charles"
    let image = UIImage()
    let planType = PlanType.game
    let planDescription = "HaHa"
    
    
    override func setUp() {
        // initial the planManager
        planManager = PlanManager.shared
        
        // precondition: do not have plan called "Charles" in the plan list
        for plan in planManager.planList {
            if plan.planName == planName {
                planManager.deletePlan(planName)
            }
        }
    }
    
    /// * planManager = nil
    override func tearDown() {
        planManager = nil
    }
    
    /// #action: crete a plan and check the new one is on the list
    func testCreatePlan() {
        // precondition: do not have plan called "Charles" in the plan list
        // already done on the setUp()
        for plan in planManager.planList {
            XCTAssertNotEqual(plan.planName, planName)
        }
        
        // action: create plan
        let _ = planManager.createPlan(planName, image, planType, planDescription)

        // postcondition: check the values of the new plan
        let planList = planManager.planList
        let plan = planList[planList.count - 1]
        XCTAssertEqual(plan.planName, planName)
        XCTAssertEqual(plan.planType, planType.rawValue)
        XCTAssertEqual(plan.planDescription, planDescription)
        XCTAssertEqual(plan.planImage, image.pngData())
    }
    
    
    /// performance of create plan
    func testPerformanceOfCreatePlan() {
        // precondition: do not have plan called "Charles" in the plan list
        // already done on the setUp()
        for plan in planManager.planList {
            XCTAssertNotEqual(plan.planName, planName)
        }
        
        self.measure {
            // action: create plan
            let _ = planManager.createPlan(planName, image, planType, planDescription)
        }
    }
    
    /// #action: delect a plan and check the plan is not on the list
    func testDeletePlan() {
        // precondition only have a plan's name is "Charles"
        // delete all the "Charles" in list is already done on the setUP()
        let _ = planManager.createPlan(planName, image, planType, planDescription)
        XCTAssertEqual(planName, planManager.planList.last?.planName)
        
        // action: delete ""Charles"
        planManager.deletePlan(planName)
        
        // postcondition: check do not have charles in the list
        for plan in planManager.planList {
            XCTAssertNotEqual(plan.planName, planName)
        }
    }
    
    /// performance of delect plan
    func testPerformanceOfDeletePlan() {
        // precondition only have a plan's name is "Charles"
        // delete all the "Charles" in list is already done on the setUP()
        let _ = planManager.createPlan(planName, image, planType, planDescription)
        XCTAssertEqual(planName, planManager.planList.last?.planName)
        
        self.measure {
            // action: delete ""Charles"
            planManager.deletePlan(planName)
        }
    }
    
    /// #action: update plan and check the task list in the plan has been update
    func testUpdatePlan() {
        // precondition only have a plan's name is "Charles"
        // delete all the "Charles" in list is already done on the setUP()
        // check plan list have a "Charles" and it's size of task list equal to 0
        let _ = planManager.createPlan(planName, image, planType, planDescription)
        let lastPlan = planManager.planList.last
        XCTAssertEqual(planName, lastPlan?.planName)
        XCTAssertTrue(lastPlan?.tasks?.count == 0)
    
        // action: update task for the "Charles"
        let charlesTasks: [Task] = [
            TaskManager.shared.createTask("charles task", nil, Date(), Date().addingTimeInterval(86400.0), TaskPriority.high, TaskProgress.done, "charles test", lastPlan!)
        ]
        planManager.updatePlan(planName, charlesTasks)
        
        // postcondition: check the tasks on the "Charles" has been update
        XCTAssertEqual(lastPlan?.tasks?.count, 1)
        let testTask = lastPlan?.tasks?.allObjects[0] as! Task
        XCTAssertEqual(testTask.taskTitle, "charles task")
        XCTAssertNotNil(testTask.taskImage)
        XCTAssertEqual(testTask.taskPriority, TaskPriority.high.rawValue)
        XCTAssertEqual(testTask.taskProgress, TaskProgress.done.rawValue)
        XCTAssertEqual(testTask.taskDescription, "charles test")
    }
    
    /// performance of updating plan
    func testPerformanceOfUdatePlan() {
        // precondition only have a plan's name is "Charles"
        // delete all the "Charles" in list is already done on the setUP()
        // check plan list have a "Charles" and it's size of task list equal to 0
        let _ = planManager.createPlan(planName, image, planType, planDescription)
        let lastPlan = planManager.planList.last
        XCTAssertEqual(planName, lastPlan?.planName)
        
        let charlesTasks: [Task] = [
            TaskManager.shared.createTask("charles task1", nil, Date(), Date().addingTimeInterval(86400.0), TaskPriority.high, TaskProgress.done, "charles test", lastPlan!),
            TaskManager.shared.createTask("charles task2", nil, Date(), Date().addingTimeInterval(86400.0), TaskPriority.high, TaskProgress.done, "charles test", lastPlan!),
        ]
        
        self.measure {
            planManager.updatePlan(planName, charlesTasks)
        }
    }
}
