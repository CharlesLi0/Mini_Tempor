//
//  DeveloperTableViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 12/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class DeveloperTableViewController: UITableViewController {
    
    var developerViewModel = DeveloperViewModel.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return developerViewModel.developerList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperCell", for: indexPath) as! DeveloperTableViewCell
        let developer = developerViewModel.developerList[indexPath.row]

        // Configure the cell...
        cell.updateUI(with: developer)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            developerViewModel.removeDeveloper(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func unwindToDeveloperList(segue: UIStoryboardSegue) {
        guard segue.identifier == "AddDeveloper",
            let sourceViewController = segue.source as? NewDeveloperTableViewController,
            let developer = sourceViewController.developer else { return }
        
        let indexPath = IndexPath(row: developerViewModel.developerList.count, section: 0)
        developerViewModel.addDeveloper(developer)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
