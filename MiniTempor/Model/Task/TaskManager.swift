//
//  TaskManager.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 8/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct TaskManager {
    
    //Singleton
    static let shared = TaskManager()
    
    //Reference to the Model objects
    private (set) var taskList: [Task] = []
    
    //Refer to the AppDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //C.R.U.D - Create
    public func createTask(_ taskTitle: String, _ taskImage: UIImage?, _ startDate: Date, _ dueDate: Date, _ taskPriority: TaskPriority, _ taskProgress: TaskProgress, _ taskDescription: String, _ plan: Plan) -> Task {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        
        let task = NSManagedObject(entity: taskEntity, insertInto: managedContext) as! Task
        
        //Set values to the attributes of the object
        task.setValue(taskTitle, forKey: "taskTitle")
        
        if let taskImage = taskImage {
            task.setValue(taskImage.pngData(), forKey: "taskImage")
        } else {
            task.setValue(UIImage(named: "default")?.pngData(), forKey: "taskImage")
        }
        
        task.setValue(startDate, forKey: "startDate")
        task.setValue(dueDate, forKey: "dueDate")
        task.setValue(taskPriority.rawValue, forKey: "taskPriority")
        task.setValue(taskProgress.rawValue, forKey: "taskProgress")
        task.setValue(taskDescription, forKey: "taskDescription")
        task.setValue(plan, forKey: "plan")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return task
    } //end of createTask
    
    //C.R.U.D - Retrieve
    mutating private func retrieveTask() {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            taskList = result as! [Task]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    } //end of retrieveTask
    
    //C.R.U.D - Update
    public func updateTask(_ oldTitle: String, _ newTitle: String, _ taskImage: UIImage?, _ startDate: Date, _ dueDate: Date, _ taskPriority: TaskPriority, _ taskProgress: TaskProgress, _ taskDescription: String) -> Task {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        fetchRequest.predicate = NSPredicate(format: "taskTitle = %@", oldTitle)
        var tempTask: Task? = nil
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let task = result[0] as! Task
            
            //Update the attributes' value of the object
            if let taskImage = taskImage {
                task.setValue(taskImage.pngData(), forKey: "taskImage")
            } else {
                task.setValue(UIImage(named: "default")?.pngData(), forKey: "taskImage")
            }
            
            task.setValue(newTitle, forKey: "taskTitle")
            task.setValue(startDate, forKey: "startDate")
            task.setValue(dueDate, forKey: "dueDate")
            task.setValue(taskPriority.rawValue, forKey: "taskPriority")
            task.setValue(taskProgress.rawValue, forKey: "taskProgress")
            task.setValue(taskDescription, forKey: "taskDescription")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            tempTask = task
            return task
            
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
        
        return tempTask!
    } //end of updateTask
    
    //C.R.U.D - Delete
    public func deleteTask(_ taskTitle: String) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        fetchRequest.predicate = NSPredicate(format: "taskTitle = %@", taskTitle)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            //Check if the task exists and delete it
            if !result.isEmpty {
                let task = result[0] as! Task
                managedContext.delete(task)
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    } //end of deleteTask
}
