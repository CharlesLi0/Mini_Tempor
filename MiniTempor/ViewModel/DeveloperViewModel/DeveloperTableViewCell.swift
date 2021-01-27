//
//  DeveloperTableViewCell.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 12/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class DeveloperTableViewCell: UITableViewCell {

    @IBOutlet var developerImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var subjectLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(with developer: Developer) {
        developerImage.image = developer.image
        nameLabel.text = "Name: \(developer.name)"
        subjectLabel.text = "Subject: iPhone SE"
    }
}
