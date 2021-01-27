//
//  TaskViewModel.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 20/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct TaskViewModel {
    
    //Singleton Pattern
    static let shared = TaskViewModel()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    //Refer to the Model
    var taskManager = TaskManager.shared
    private (set) var taskList: [Task] = []
    
    //Retrieve the data of tasks
    mutating func loadTaskData(_ tasks: [Task]) {
        taskList = tasks
    } //end of loadTaskData
    
    //Delete the task
    mutating func removeTask(at index: Int) {
        let task = taskList.remove(at: index)
        taskManager.deleteTask(task.taskTitle!)
    } //end of removeTask

    //Add new task
    mutating func addTask(_ task: Task) {
        taskList.append(task)
    } //end of addTask
    
    //Update the task
    mutating func replace(with task: Task, at index: Int) {
        taskList[index] = task
    } //end of replace
}
