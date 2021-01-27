//
//  Task+CoreDataClass.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 8/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {

}

//Task priority enumeration
enum TaskPriority: String {
    case low = "Low", medium = "Medium", high = "High"
    
    static var all: [TaskPriority] {
        return [.low, .medium, .high]
    }
}

//Task progress enumeration
enum TaskProgress: String {
    case todo = "To Do", doing = "Doing", done = "Done"
    
    static var all: [TaskProgress] {
        return [.todo, .doing, .done]
    }
}
