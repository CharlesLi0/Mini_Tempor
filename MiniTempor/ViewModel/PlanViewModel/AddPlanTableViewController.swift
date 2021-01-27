//
//  AddPlanTableViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 19/9/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class AddPlanTableViewController: UITableViewController, SelectPlanTypeTableViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var planType: PlanType?
    var plan: Plan?
    
    @IBOutlet var planImage: UIImageView!
    @IBOutlet var planNameTextField: UITextField!
    @IBOutlet var planDescTextField: UITextField!
    @IBOutlet var planTypeLabel: UILabel!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSaveButtonState()
        updatePlanType()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SelectPlanType" {
            let destination = segue.destination as? SelectPlanTypeTableViewController
            destination?.delegate = self
            destination?.planType = planType
        } else if segue.identifier == "savePlan" {
            let planImage = self.planImage.image
            let planName = planNameTextField.text!
            let planDesc = planDescTextField.text!
            let planType = self.planType!
            
            plan = PlanManager.shared.createPlan(planName, planImage, planType, planDesc)
        }
    } //end of prepare
    
    //Update the save button's state according to the TextFields' contents
    func updateSaveButtonState() {
        let nameText = planNameTextField.text ?? ""
        let descText = planDescTextField.text ?? ""
        
        saveButton.isEnabled = !nameText.isEmpty && !descText.isEmpty
    } //end of updateSaveButtonState
    
    //Update the plan type
    func updatePlanType() {
        if let planType = self.planType {
            planTypeLabel.text = planType.rawValue
        } else {
            planType = PlanType.other
            planTypeLabel.text = planType?.rawValue
        }
    } //end of updatePlanType
    
    //delegate method implementation
    func didSelect(planType: PlanType) {
        self.planType = planType
        updatePlanType()
    } //end of didSelect
    
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
        
        planImage.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    //Dismiss the keyboard when the 'Return' button was pressed
    @IBAction func returnPressed(_ sender: UITextField) {
        planNameTextField.resignFirstResponder()
        planDescTextField.resignFirstResponder()
    } //end of returnPressed
    
    //Update the save button's state according to the TextFields' contents
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    } //end of textEditingChanged
}
