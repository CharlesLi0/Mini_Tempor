//
//  SelectTaskPriorityTableViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 20/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class SelectTaskPriorityTableViewController: UITableViewController {
    
    //Refer to the select task priority delegate
    weak var delegate: SelectTaskPriorityTableViewControllerDelegate?
    
    var taskPriority: TaskPriority?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskPriority.all.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskPriorityCell", for: indexPath)
        
        let taskPriority = TaskPriority.all[indexPath.row]

        // Configure the cell...
        cell.textLabel?.text = taskPriority.rawValue
        
        if taskPriority == self.taskPriority {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        taskPriority = TaskPriority.all[indexPath.row]
        delegate?.didSelect(taskPriority: taskPriority!)
        tableView.reloadData()
    }
}

//Select Task Priority Delegate
protocol SelectTaskPriorityTableViewControllerDelegate: class {
    func didSelect(taskPriority: TaskPriority)
}
