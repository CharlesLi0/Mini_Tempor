//
//  TaskManagerTest.swift
//  MiniTemporTests
//
//  Created by Charles on 19/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import XCTest
import CoreData
@testable import MiniTempor

class TaskManagerTest: XCTestCase {
    var planManager: PlanManager!
    var plan: Plan? = nil
    var taskManager: TaskManager!
    
    //Refer to the AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // data
    let taskName = "Charles"
    let taskImage = UIImage()
    let taskProgress = TaskProgress.doing
    let taskPriority = TaskPriority.high
    let taskDescription = "HaHa"
    // new data
    let newImage = UIImage()
    let newPriority = TaskPriority.medium
    let newProgress = TaskProgress.done
    let newDescription = "new description"
    
    class MockPlan: Plan {}
    
    /// <#Description#>
    override func setUp() {
        self.taskManager = TaskManager.shared
        
        // precondition: have a plan do not have plan called "Charles" in the plan list
        planManager = PlanManager.shared
        planManager.deletePlan(taskName)
        plan = planManager.createPlan(taskName, nil, PlanType.game, "haha")
    }
    
    /// * taskManager = nil
    override func tearDown() {
        // delete the plan call charles and task call "Charles"
        planManager.deletePlan(taskName)
        let numtask = tasksOnDatabase(taskName: taskName)?.count
        for _ in 0...numtask! {
            taskManager.deleteTask(taskName)
        }
        
        taskManager = nil
    }
    
    private func tasksOnDatabase(taskName: String) -> [Task]?{
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        fetchRequest.predicate = NSPredicate(format: "taskTitle = %@", taskName)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let tasks = result as! [Task]
            return tasks
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    /// #action: crete a task and check the new one is on the list
    func testCreateTask() {
        // precondition: have a plan called "Charles", and do not have plan called "Charles" in the task list
        // already done on the setUp()
        for task in taskManager.taskList {
            XCTAssertNotEqual(task.taskTitle, taskName)
        }
        
        // action: create task
        let task = taskManager.createTask(taskName, taskImage, Date(), Date(), taskPriority, taskProgress, taskDescription, plan!)
        
        // postcondition: check the values of the new task
        XCTAssertEqual(task.taskTitle, taskName)
        XCTAssertEqual(task.taskPriority, taskPriority.rawValue)
        XCTAssertEqual(task.taskProgress, taskProgress.rawValue)
        XCTAssertEqual(task.taskImage, taskImage.pngData())
        XCTAssertEqual(task.taskDescription, taskDescription)
    }
    
    
    /// performance of create task
    func testPerformanceOfCreateTask() {
        // precondition: do not have plan called "Charles" in the task list
        // already done on the setUp()
        for task in taskManager.taskList {
            XCTAssertNotEqual(task.taskTitle, taskName)
        }
        
        self.measure {
            // action: create task
            let _ = taskManager.createTask(taskName, taskImage, Date(), Date(), taskPriority, taskProgress, taskDescription, plan!)
        }
    }
    
    
    
    /// #action: delect a task and check the task is not on the list
    func testDeleteTask() {
        // precondition only have a task's name is "Charles"
        // delete all the "Charles" in list is already done on the setUP()
        let _ = taskManager.createTask(taskName, taskImage, Date(), Date(), taskPriority, taskProgress, taskDescription, plan!)
        var tasks = tasksOnDatabase(taskName: taskName)
        XCTAssertEqual(tasks?.count, 1)
        
        // action: delete ""Charles"
        taskManager.deleteTask(taskName)
        
        // postcondition: check do not have charles in the database
        tasks = tasksOnDatabase(taskName: taskName)
        XCTAssertEqual(tasks?.count, 0)
    }
    
    /// performance of delect task
    func testPerformanceOfDeleteTask() {
        // precondition only have a task's name is "Charles"
        // delete all the "Charles" in list is already done on the setUP()
        let newTask = taskManager.createTask(taskName, taskImage, Date(), Date(), taskPriority, taskProgress, taskDescription, plan!)
        XCTAssert((plan?.tasks?.contains(newTask))!)
        
        self.measure {
            // action: delete ""Charles"
            taskManager.deleteTask(taskName)
        }
    }
    
    /// #action: update task and check the task in the task list has been update
    func testUpdateTask() {
        // precondition only have a task's name is "Charles"
        // delete all the "Charles" in list is already done on the setUP()
        // check plan list have a "Charles" and it's size of task list equal to 0
        let _ = taskManager.createTask(taskName, taskImage, Date(), Date(), taskPriority, taskProgress, taskDescription, plan!)
        var tasks = tasksOnDatabase(taskName: taskName)
        var task = tasks![0] as! Task
        XCTAssertEqual(task.taskProgress, taskProgress.rawValue)
        XCTAssertEqual(task.taskPriority, taskPriority.rawValue)
        XCTAssertEqual(task.taskDescription, taskDescription)
        
        // action: update task for the "Charles"
        let _ = taskManager.updateTask(taskName, taskName, newImage, Date(), Date(), newPriority, newProgress, newDescription)
        
        // postcondition: check the tasks on the "Charles" has been update
        tasks = tasksOnDatabase(taskName: taskName)
        task = tasks![0] as! Task
        XCTAssertEqual(task.taskProgress, newProgress.rawValue)
        XCTAssertEqual(task.taskPriority, newPriority.rawValue)
        XCTAssertEqual(task.taskDescription, newDescription)
    }
    
    /// performance of updating plan
    func testPerformanceOfUdateTask() {
        // precondition only have a task's name is "Charles"
        // delete all the "Charles" in list is already done on the setUP()
        // check plan list have a "Charles" and it's size of task list equal to 0
        let _ = taskManager.createTask(taskName, taskImage, Date(), Date(), taskPriority, taskProgress, taskDescription, plan!)
//        let lastTask = taskManager.taskList.last
//        XCTAssertEqual(taskName, lastTask?.taskTitle)
        
        // action: update task for the "Charles"
        
        
        self.measure {
            let _ = taskManager.updateTask(taskName, taskName, newImage, Date(), Date(), newPriority, newProgress, newDescription)
        }
    }

}
