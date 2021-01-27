//
//  PlanViewModel.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 18/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct PlanViewModel {
    
    //Singleton Pattern
    static let shared = PlanViewModel()
    
    //Refer to the Model
    var planManager = PlanManager.shared
    var planList: [Plan] = []
    
    //Initializer
    private init() {
        if planManager.planList.count == 0 {
            firstLaunch()
        } else {
            planList = planManager.planList
        }
    } //end of init
    
    //Delete plan
    mutating func removePlan(at index: Int) {
        let plan = planList.remove(at: index)
        
        planManager.deletePlan(plan.planName!)
    } //end of removePlan

    //Add new plan
    mutating func addPlan(_ plan: Plan) {
        planList.append(plan)
    } //end of addPlan

    //Update plan
    mutating func refreshPlan(with tasks: [Task], at index: Int) {
        let plan = planList[index]
        plan.refreshTasks(by: tasks)
        planManager.updatePlan(plan.planName!, tasks)
    } //end of refreshPlan
    
    /*
     *  For assignment demonstration, this method will add some hardcoded model datas
     *  when launching the app at the first time it is installed in which case
     *  there is no datas in the local database.
     */
    mutating func firstLaunch() {
        let plans: [Plan] = [
            planManager.createPlan("Swift", UIImage(named: "swift"), PlanType.study, "iPhone Development"),
            planManager.createPlan("Shopping", UIImage(named: "shopping"), PlanType.shopping, "Weekly Shopping Plan"),
            planManager.createPlan("Java", UIImage(named: "java"), PlanType.study, "Java Advanced Tech"),
            planManager.createPlan("Travel Plan", UIImage(named: "travel"), PlanType.travel, "Monthly Travelling"),
            planManager.createPlan("Clash of Clans", UIImage(named: "COC"), PlanType.game, "My Mobile Game"),
            planManager.createPlan("Others", UIImage(named: "others"), PlanType.other, "The trivia of life")
        ]
        
        let swiftTasks: [Task] = [
            TaskManager.shared.createTask("Lesson 2.7 Introduction to UIKit", UIImage(named: "swift"), Date(), Date().addingTimeInterval(86400.0), TaskPriority.high, TaskProgress.done, "1, Learning different types of View and Control in Swfit.\n2, Using Developer Document to become familiar with UIView.\n3, Finish Lab exercises at the end of this section.\n4, Finish short answers after finishing the lab exercises.", plans[0]),
            TaskManager.shared.createTask("Lesson 2.8 Displaying Data", UIImage(named: "swift"), Date(), Date().addingTimeInterval(172800.0), TaskPriority.medium, TaskProgress.doing, "1, Learning UIImage View.\n2, Learning UILabel\n3, Finish Lab exercises\n4, Search for different images for later use", plans[0]),
            TaskManager.shared.createTask("Lesson 2.9 Controls In Action", UIImage(named: "swift"), Date(), Date().addingTimeInterval(259200.0), TaskPriority.low, TaskProgress.doing, "1, Learning different UI Controls.\n2, Difference between IBOutlet and IBAction.\n3, How to connect controls to actions programmatically.\n4, Lab exercises.", plans[0])
        ]
        
        let shoppingTasts: [Task] = [
            TaskManager.shared.createTask("Monday shopping list", UIImage(named: "shopping"), Date(), Date().addingTimeInterval(86400.0), TaskPriority.medium, TaskProgress.todo, "1, Steak\n2, Chicken Wings\n3, Broccoli\n4, Orange Juice", plans[1])
        ]
        
        let javaTasks: [Task] = [
            TaskManager.shared.createTask("BINARY I/O", UIImage(named: "java"), Date(), Date().addingTimeInterval(86400.0), TaskPriority.low, TaskProgress.todo, "1, To discover how I/O is processed in Java\n2, To distinguish between text I/O and binary I/O\n3, To read and write bytes using FileInputStream and FileOutputStream", plans[2]),
            TaskManager.shared.createTask("MULTITHREADING PROGRAMMING", UIImage(named: "java"), Date(), Date().addingTimeInterval(86400.0), TaskPriority.low, TaskProgress.todo, "1, To get an overview of multithreading\n2, To develop task classes by implementing the Runnable interface\n3, To create threads to run tasks using the Thread class\n4, To execute tasks in a thread pool", plans[2])
        ]
        
        let travelTasks: [Task] = [
            TaskManager.shared.createTask("Sydney Travel", UIImage(named: "travel"), Date(), Date().addingTimeInterval(259200.0), TaskPriority.medium, TaskProgress.todo, "1, Visit Sydney Opera House.\n2, Have a walk to Sydney Harbour Bridge.\n3, Have a look at Whale Beach", plans[3])
        ]
        
        let cocTasks: [Task] = [
            TaskManager.shared.createTask("Upgrade Troops", UIImage(named: "wizard"), Date(), Date().addingTimeInterval(86400.0), TaskPriority.high, TaskProgress.todo, "Research new level of Wizard.", plans[4]),
            TaskManager.shared.createTask("Attend Clan War Leagues", UIImage(named: "clan war leagues"), Date(), Date().addingTimeInterval(259200.0), TaskPriority.high, TaskProgress.todo, "Attend the Clan War Leagues of November", plans[4]),
            TaskManager.shared.createTask("Finish the Clan Game Missions", UIImage(named: "bowler"), Date(), Date().addingTimeInterval(86400.0), TaskPriority.medium, TaskProgress.doing, "1, Choose missions\n2, Get 5000 points\n3, Get the reward from each tier", plans[4]),
            TaskManager.shared.createTask("Season Challenges", UIImage(named: "baby dragon"), Date(), Date().addingTimeInterval(24 * 60 * 60 * 10), TaskPriority.medium, TaskProgress.doing, "1, Finish Daily Challenges\n2, Achieve the max points\n3, Get rewards at the end of month", plans[4])
        ]
        
        let otherTasks: [Task] = [
            TaskManager.shared.createTask("Halloween", UIImage(named: "Halloween"), Date(), Date().addingTimeInterval(24 * 60 * 60 * 10), TaskPriority.high, TaskProgress.todo, "1, Prepare the gift to my girlfriend\n2, Attend the party with my girlfriend", plans[5]),
            TaskManager.shared.createTask("Graduation Ceremony", UIImage(named: "RMIT"), Date(), Date().addingTimeInterval(24 * 60 * 60 * 7), TaskPriority.high, TaskProgress.todo, "1, Apply to graduate this month\n2, Invite my parents\n3, Attend the Graduation Ceremony at 18th December", plans[5])
        ]
        
        planManager.updatePlan("Swift", swiftTasks)
        planManager.updatePlan("Shopping", shoppingTasts)
        planManager.updatePlan("Java", javaTasks)
        planManager.updatePlan("Travel Plan", travelTasks)
        planManager.updatePlan("Clash of Clans", cocTasks)
        planManager.updatePlan("Others", otherTasks)
        
        planList = plans
    } //end of firstLaunch
}
