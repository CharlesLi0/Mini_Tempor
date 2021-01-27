//
//  TaskTableViewCell.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 20/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet var taskImage: UIImageView!
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskDateLabel: UILabel!
    @IBOutlet var taskDescTextView: UITextView!
    @IBOutlet var taskPriorityLabel: UILabel!
    @IBOutlet var taskProgressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Configure the custom cell in the tableview
    func updateCell(with task: Task) {
        
        if let image = task.taskImage {
            taskImage.image = UIImage(data: image)
        } else {
            taskImage.image = UIImage(named: "default")
        }
        
        taskTitleLabel.text = task.taskTitle
        taskDateLabel.text = TaskViewModel.dateFormatter.string(from: task.startDate!) + " - " + TaskViewModel.dateFormatter.string(from: task.dueDate!)
        taskDescTextView.text = task.taskDescription
        taskPriorityLabel.text = "Priority: \(task.taskPriority!)"
        taskProgressLabel.text = "Progress: \(task.taskProgress!)"
    } //end of updateCell
}
