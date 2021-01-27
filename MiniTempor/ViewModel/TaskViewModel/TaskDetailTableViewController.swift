//
//  TaskDetailTableViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 18/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SelectTaskPriorityTableViewControllerDelegate, SelectTaskProgressTableViewControllerDelegate {
    
    var task: Task?
    var plan: Plan?
    var taskPriority: TaskPriority?
    var taskProgress: TaskProgress?
    
    let startDateLabelCellIndexPath = IndexPath(row: 0, section: 2)
    let startDatePickerCellIndexPath = IndexPath(row: 1, section: 2)
    let dueDateLabelCellIndexPath = IndexPath(row: 2, section: 2)
    let dueDatePickerCellIndexPath = IndexPath(row: 3, section: 2)
    let taskDescCellIndexPath = IndexPath(row: 0, section: 1)
    
    var isStartDatePickerShown: Bool = false {
        didSet {
            startDatePicker.isHidden = !isStartDatePickerShown
        }
    }
    
    var isDueDatePickerShown: Bool = false {
        didSet {
            dueDatePicker.isHidden = !isDueDatePickerShown
        }
    }
    
    var isTitleEmpty: Bool = true
    var isDescEmpty: Bool = true
    
    @IBOutlet var taskImage: UIImageView!
    @IBOutlet var taskTitleTextField: UITextField!
    @IBOutlet var taskDescTextView: UITextView!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet var taskPriorityLabel: UILabel!
    @IBOutlet var taskProgressLabel: UILabel!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if the task is under editing or is to be created
        //If the task is under editing, then set the attributes' value to each corresponding view
        //If not, only set the datepicker's date to a default value
        if let task = task {
            navigationItem.title = "Task"
            taskImage.image = UIImage(data: task.taskImage!)
            taskTitleTextField.text = task.taskTitle
            taskDescTextView.text = task.taskDescription
            startDatePicker.date = task.startDate!
            dueDatePicker.date = task.dueDate!
            taskPriority = task.taskPriority.map { TaskPriority(rawValue: $0) }!
            taskProgress = task.taskProgress.map { TaskProgress(rawValue: $0) }!
            isTitleEmpty = false
            isDescEmpty = false
        } else {
            startDatePicker.date = Date()
            dueDatePicker.date = startDatePicker.date.addingTimeInterval(24 * 60 * 60)
        }
        
        updateSaveButtonState()
        updateTextViewKeboard()
        updateDateViews(startDate: startDatePicker.date, dueDate: dueDatePicker.date)
        updateTaskPriority()
        updateTaskProgress()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //Update the cell's height according to which cell being selected
        switch indexPath {
        case startDatePickerCellIndexPath:
            return isStartDatePickerShown ? startDatePicker.frame.height : 0
        case dueDatePickerCellIndexPath:
            return isDueDatePickerShown ? dueDatePicker.frame.height : 0
        case taskDescCellIndexPath :
            return 200
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Check if the datepicker should be shown according to the selected cell
        switch indexPath {
        case startDateLabelCellIndexPath:
            if isStartDatePickerShown {
                isStartDatePickerShown = false
            } else if isDueDatePickerShown {
                isDueDatePickerShown = false
                isStartDatePickerShown = true
            } else {
                isStartDatePickerShown = true
            }
            
            startDateLabel.textColor = isStartDatePickerShown ? tableView.tintColor : .black
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case dueDateLabelCellIndexPath:
            if isDueDatePickerShown {
                isDueDatePickerShown = false
            } else if isStartDatePickerShown {
                isStartDatePickerShown = false
                isDueDatePickerShown = true
            } else {
                isDueDatePickerShown = true
            }
            
            dueDateLabel.textColor = isDueDatePickerShown ? tableView.tintColor : .black
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: segue)
        
        if segue.identifier == "SelectTaskPriority" {
            let destinationTableViewController = segue.destination as? SelectTaskPriorityTableViewController
            destinationTableViewController?.delegate = self
            destinationTableViewController?.taskPriority = taskPriority
        } else if segue.identifier == "SelectTaskProgress" {
            let destinationTableViewController = segue.destination as? SelectTaskProgressTableViewController
            destinationTableViewController?.delegate = self
            destinationTableViewController?.taskProgress = taskProgress
        } else if segue.identifier == "saveTask" {
            let taskImage = self.taskImage.image
            let taskTitle = self.taskTitleTextField.text!
            let taskDesc = self.taskDescTextView.text!
            let taskStartDate = self.startDatePicker.date
            let taskDueDate = self.dueDatePicker.date
            let taskPriority = self.taskPriority!
            let taskProgress = self.taskProgress!
            
            if self.task != nil {
                self.task = TaskManager.shared.updateTask(self.task!.taskTitle!, taskTitle, taskImage, taskStartDate, taskDueDate, taskPriority, taskProgress, taskDesc)
            } else {
                self.task = TaskManager.shared.createTask(taskTitle, taskImage, taskStartDate, taskDueDate, taskPriority, taskProgress, taskDesc, plan!)
            }
        }
    } //end of prepare
    
    //Update the text of date label
    private func updateDateViews(startDate: Date, dueDate: Date) {
        startDateLabel.text = TaskViewModel.dateFormatter.string(from: startDate)
        dueDateLabel.text = TaskViewModel.dateFormatter.string(from: dueDate)
    } //end of updateDateViews
    
    //Update the save button's state according to the TextField and TextView's content
    private func updateSaveButtonState() {
        saveButton.isEnabled = !isTitleEmpty && !isDescEmpty
    } //end of updateSaveButtonState
    
    //Update task priority label
    func updateTaskPriority() {
        if let taskPriority = taskPriority {
            taskPriorityLabel.text = taskPriority.rawValue
        } else {
            self.taskPriority = TaskPriority.low
            taskPriorityLabel.text = taskPriority?.rawValue
        }
    } //end of updateTaskPriority
    
    //Update task progress label
    func updateTaskProgress() {
        if let taskProgress = taskProgress {
            taskProgressLabel.text = taskProgress.rawValue
        } else {
            self.taskProgress = TaskProgress.todo
            taskProgressLabel.text = taskProgress?.rawValue
        }
    } //end of updateTaskProgress
    
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        //Take picture from camera if the Camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        //Choose image from photo libaray if the PhotoLibarary is available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        present(alertController, animated: true, completion: nil)
    } //end of addImageButtonTapped
    
    //UIImagePickerControllerDelegate method implementation
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        taskImage.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews(startDate: startDatePicker.date, dueDate: dueDatePicker.date)
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        let taskTitle = taskTitleTextField.text ?? ""
        isTitleEmpty = taskTitle.isEmpty
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        taskTitleTextField.resignFirstResponder()
    }
    
    func didSelect(taskPriority: TaskPriority) {
        self.taskPriority = taskPriority
        updateTaskPriority()
    }
    
    func didSelect(taskProgress: TaskProgress) {
        self.taskProgress = taskProgress
        updateTaskProgress()
    }
    
    //Customize a Done button on the top of the keyboard
    func updateTextViewKeboard() {
        
        //Create a toolBar for the Done button
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.frame = CGRect(x: 0, y: 0, width: 320, height: 35)
        
        //Create the Done button item
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: Selector(("doneButtonPressed")))
        
        keyboardToolBar.setItems([barButtonItem], animated: true)
        
        taskDescTextView.inputAccessoryView = keyboardToolBar
    } //end of updateTextViewKeboard
    
    //Dismiss the keyboard when the Done button was tapped
    @objc func doneButtonPressed() {
        let taskDesc = taskDescTextView.text ?? ""
        isDescEmpty = taskDesc.isEmpty
        updateSaveButtonState()
        taskDescTextView.resignFirstResponder()
    } //end of doneButtonPressed
}
