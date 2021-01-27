//
//  NewDeveloperTableViewController.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 12/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import UIKit

class NewDeveloperTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var developerController = DeveloperController.shared
    
    var developer: Developer?
    
    @IBOutlet var developerImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        developerImageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        developerController.recognizeImage(image: developerImageView.image!) { (isRecognized, developerName) in
            if isRecognized {
                DispatchQueue.main.sync {
                    let alertController = UIAlertController(title: "Recognized Successfully", message: "You have added the developer to the list.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        let image = self.developerImageView.image!
                        self.developer = Developer(name: developerName, image: image)
                        self.performSegue(withIdentifier: "AddDeveloper", sender: action)
                    }
                    alertController.addAction(alertAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.sync {
                    let alertController = UIAlertController(title: "Error", message: "Can not recognize faces in the image, please enroll the image first", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    alertController.addAction(alertAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}
