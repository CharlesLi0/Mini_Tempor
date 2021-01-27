//
//  TaskTableViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 18/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    //Refer to the ViewModel
    var taskViewModel = TaskViewModel.shared
    
    var previousTVC: UITableViewController?
    var selectedIndexPath: IndexPath?
    var plan: Plan?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let previousTableViewController = previousTVC as? PlanTableViewController,
            let indexPath = selectedIndexPath {
            previousTableViewController.planViewModel.refreshPlan(with: self.taskViewModel.taskList, at: indexPath.row)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskViewModel.taskList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        
        let task = taskViewModel.taskList[indexPath.row]

        // Configure the cell
        cell.updateCell(with: task)

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            taskViewModel.removeTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditTask",
            let navController = segue.destination as? UINavigationController,
            let taskDetailTableViewController = navController.topViewController as? TaskDetailTableViewController {
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTask = taskViewModel.taskList[indexPath.row]
            taskDetailTableViewController.task = selectedTask
        } else if segue.identifier == "CreateTask",
            let navController = segue.destination as? UINavigationController,
            let taskDetailTableViewController = navController.topViewController as? TaskDetailTableViewController {
            taskDetailTableViewController.plan = self.plan
        }
    }
    
    @IBAction func unwindToTaskList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveTask" else {
            return
        }
        
        let source = segue.source as! TaskDetailTableViewController
        
        if let task = source.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                taskViewModel.replace(with: task, at: selectedIndexPath.row)
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: taskViewModel.taskList.count, section: 0)
                taskViewModel.addTask(task)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
}
