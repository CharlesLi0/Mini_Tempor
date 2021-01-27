//
//  SelectTaskProgressTableViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 20/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class SelectTaskProgressTableViewController: UITableViewController {
    
    weak var delegate: SelectTaskProgressTableViewControllerDelegate?
    
    var taskProgress: TaskProgress?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskProgress.all.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskProgressCell", for: indexPath)
        
        let taskProgress = TaskProgress.all[indexPath.row]

        // Configure the cell
        cell.textLabel?.text = taskProgress.rawValue
        
        if taskProgress == self.taskProgress {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        taskProgress = TaskProgress.all[indexPath.row]
        delegate?.didSelect(taskProgress: taskProgress!)
        tableView.reloadData()
    }
}

protocol SelectTaskProgressTableViewControllerDelegate: class {
    func didSelect(taskProgress: TaskProgress)
}
