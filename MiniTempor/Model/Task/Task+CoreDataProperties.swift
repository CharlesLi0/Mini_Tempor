//
//  Task+CoreDataProperties.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 8/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var taskTitle: String?
    @NSManaged public var taskImage: Data?
    @NSManaged public var startDate: Date?
    @NSManaged public var dueDate: Date?
    @NSManaged public var taskPriority: String?
    @NSManaged public var taskProgress: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var plan: Plan?

}
