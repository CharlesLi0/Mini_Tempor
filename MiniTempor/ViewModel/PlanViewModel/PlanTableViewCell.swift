//
//  PlanTableViewCell.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 19/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    
    @IBOutlet var planImage: UIImageView!
    @IBOutlet var planNameLabel: UILabel!
    @IBOutlet var planTypeLabel: UILabel!
    @IBOutlet var planDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Configure the custom cell in the tableview
    func updateCell(with plan: Plan) {
        if let image = plan.planImage {
            planImage.image = UIImage(data: image)
        } else {
            planImage.image = UIImage(named: "default")
        }
        
        planNameLabel.text = plan.planName
        planTypeLabel.text = plan.planType
        planDescLabel.text = plan.planDescription
    } //end of updateCell
}
