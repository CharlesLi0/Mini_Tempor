//
//  Plan+CoreDataClass.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 8/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Plan)
public class Plan: NSManagedObject {
    
    public func refreshTasks(by tasks: [Task]) {
        self.tasks = NSSet(array: tasks)
    }
}

//Plan type enumeration
enum PlanType: String {
    
    case study = "Study"
    case work = "Work"
    case shopping = "Shopping"
    case travel = "Travel"
    case game = "Game"
    case other = "Others"
    
    static var all: [PlanType] {
        return [.study, .work, .shopping, .travel, .game, .other]
    }
}
