//
//  SelectPlanTypeTableViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 19/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit
import CoreData

class SelectPlanTypeTableViewController: UITableViewController {
    
    //Refer to the select plan type delegate
    weak var delegate: SelectPlanTypeTableViewControllerDelegate?
    
    var planType: PlanType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlanType.all.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTypeCell", for: indexPath)
        
        let planType = PlanType.all[indexPath.row]

        // Configure the cell
        cell.textLabel?.text = planType.rawValue
        
        if planType == self.planType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        planType = PlanType.all[indexPath.row]
        delegate?.didSelect(planType: planType!)
        
        tableView.reloadData()
    }
}

//Select plan type delegate
protocol SelectPlanTypeTableViewControllerDelegate: class {
    func didSelect(planType: PlanType)
}
