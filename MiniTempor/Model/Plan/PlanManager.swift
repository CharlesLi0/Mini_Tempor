//
//  PlanManager.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 8/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PlanManager {
    
    //Singleton
    static let shared = PlanManager()
    
    //Reference to Model object
    private (set) var planList: [Plan] = [] {
        didSet{
            print()
        }
    }
    
    //Refer to the AppDelegate and the ManagedContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    
    //Initializaion
    private init() {
        managedContext = appDelegate.persistentContainer.viewContext
        retrievePlan()
        print()
    } //end of init
    
    public func newPLan() -> Plan {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let newPlan = NSEntityDescription.insertNewObject(forEntityName: "Plan", into: managedContext) as! Plan
        newPlan.planName = "haha"
        
        let newTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managedContext) as! Task
        newTask.taskTitle = "dd"
        newTask.plan = newPlan
        
        appDelegate.saveContext()
        
        var plans = [Plan]()
        let planRequest : NSFetchRequest<Plan> = Plan.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "$k==%@", "Plan.name", "hhaa")
        planRequest.predicate = predicate
        
        do {
            plans = try managedContext.fetch(planRequest)
        } catch {
            print()
        }
        return newPlan
    }
    
    //C.R.U.D - Create
    public func createPlan(_ planName: String, _ planImage: UIImage?, _ planType: PlanType, _ planDescription: String) -> Plan {
        
        let planEntity = NSEntityDescription.entity(forEntityName: "Plan", in: managedContext)!
        
        let plan = NSManagedObject(entity: planEntity, insertInto: managedContext) as! Plan
        
        //Set values to attributes of the object
        plan.setValue(planName, forKey: "planName")
        if let planImage = planImage {
            plan.setValue(planImage.pngData(), forKey: "planImage")
        } else {
            plan.setValue(UIImage(named: "default")?.pngData(), forKey: "planImage")
        }
        plan.setValue(planType.rawValue, forKey: "planType")
        plan.setValue(planDescription, forKey: "planDescription")
        
        do {
            try managedContext.save()
            retrievePlan()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return plan
    } //end of createPlan
    
    //C.R.U.D - Retrieve
    private func retrievePlan() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            planList = result as! [Plan]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    } //end of retrievePlan
    
    //C.R.U.D - Update
    public func updatePlan(_ planName: String, _ tasks: [Task]) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        
        fetchRequest.predicate = NSPredicate(format: "planName = %@", planName)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let plan = result[0] as! Plan
            
            let taskList = plan.mutableSetValue(forKey: "tasks")
            
            for task in taskList {
                taskList.remove(task)
            }
            
            for task in tasks {
                taskList.add(task)
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    } //end of updatePlan
    
    //C.R.U.D - Delete
    public func deletePlan(_ planName: String) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        
        fetchRequest.predicate = NSPredicate(format: "planName = %@", planName)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            //Delete plan if the plan object exists 
            if !result.isEmpty {
                let plan = result[0] as! Plan
                managedContext.delete(plan)
            }
                
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    } //end of deletePlan
}
