//
//  PlanTableViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 18/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class PlanTableViewController: UITableViewController {
    
    //Reference to ViewModel
    var planViewModel = PlanViewModel.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Enable the editing mode
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planViewModel.planList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanCell", for: indexPath) as! PlanTableViewCell
        
        let plan = planViewModel.planList[indexPath.row]
        
        // Configure the cell...
        cell.updateCell(with: plan)

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            planViewModel.removePlan(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlanDetail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let plan = planViewModel.planList[indexPath.row]
            //test
            print(plan)
            let tasks = plan.tasks
            //test
            print(tasks?.allObjects as! [Task])
            
            let destination = segue.destination as! TaskTableViewController
            destination.navigationItem.title = plan.planName
            destination.taskViewModel.loadTaskData(tasks?.allObjects as! [Task])
            destination.previousTVC = self
            destination.selectedIndexPath = indexPath
            destination.plan = plan
        }
    } //end of prepare
    
    @IBAction func unwindToPlanList(segue: UIStoryboardSegue) {
        guard segue.identifier == "savePlan",
            let sourceViewController = segue.source as? AddPlanTableViewController,
            let plan = sourceViewController.plan else { return }
        
        let indexPath = IndexPath(row: planViewModel.planList.count, section: 0)
        planViewModel.addPlan(plan)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
