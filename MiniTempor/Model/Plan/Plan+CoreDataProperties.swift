//
//  Plan+CoreDataProperties.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 8/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//
//

import Foundation
import CoreData


extension Plan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plan> {
        return NSFetchRequest<Plan>(entityName: "Plan")
    }

    @NSManaged public var planName: String?
    @NSManaged public var planImage: Data?
    @NSManaged public var planType: String?
    @NSManaged public var planDescription: String?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension Plan {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
