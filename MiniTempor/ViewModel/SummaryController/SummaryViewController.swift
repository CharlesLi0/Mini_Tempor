//
//  SummaryViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 8/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    //Reference to the ViewModel
    var summaryViewModel = SummaryViewModel()
    var summaryController = SummaryController.shared

    @IBOutlet var taskImageView: UIImageView!
    @IBOutlet var planImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    //Update the views
    func updateUI() {
        summaryController.requestSummaryImage(forJsonString: summaryViewModel.getTaskJsonString()) { (url) in
            
            self.summaryController.fetchImage(url: url) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.taskImageView.image = image
                }
            }
        }
        
        summaryController.requestSummaryImage(forJsonString: summaryViewModel.getPlanJsonString()) { (url) in
            
            self.summaryController.fetchImage(url: url) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.planImageView.image = image
                }
            }
        }
    } //end of updateUI
}
