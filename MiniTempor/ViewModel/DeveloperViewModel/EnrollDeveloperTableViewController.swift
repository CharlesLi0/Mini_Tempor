//
//  EnrollDeveloperTableViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 12/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class EnrollDeveloperTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var developerController = DeveloperController.shared
    
    @IBOutlet var developerImage: UIImageView!
    @IBOutlet var developerNameTextField: UITextField!
    @IBOutlet var doneBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDoneButtonState()
    }
    
    func updateDoneButtonState() {
        let nameText = developerNameTextField.text ?? ""
        
        doneBarButtonItem.isEnabled = !nameText.isEmpty
    }
    
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }

    //UIImagePickerControllerDelegate method implementation
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        developerImage.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        developerController.enrollImage(image: developerImage.image!, name: developerNameTextField.text!) { (isEnrolled) in
            if isEnrolled {
                DispatchQueue.main.sync {
                    let alertController = UIAlertController(title: "Enrolled Successfully", message: "You have enrolled the developer.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        self.performSegue(withIdentifier: "EnrollDeveloper", sender: action)
                    }
                    alertController.addAction(alertAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.sync {
                    let alertController = UIAlertController(title: "Error", message: "No faces found in the image", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    alertController.addAction(alertAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        developerNameTextField.resignFirstResponder()
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateDoneButtonState()
    }
}
