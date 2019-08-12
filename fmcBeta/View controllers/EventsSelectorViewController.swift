//
//  EventsSelectorViewController.swift
//  fmcBeta
//
//  Created by Xcode Mac on 8/10/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit

class EventsSelectorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let imagePicker = UIImagePickerController()
    
    @IBAction func eventTitleTextField(_ sender: Any) {
    }
    @IBAction func eventsDateSelector(_ sender: Any) {
    }
    @IBOutlet weak var eventsFlyerImagePicker:
      UIImageView!
    @IBAction func imageSelector(_ sender: Any) {
        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
//            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
//            imagePicker.allowsEditing = true
//            self.present(imagePicker, animated: true, completion: nil)
//    }
        
        
        
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

      
        imagePicker.delegate = self
    }
    

    @IBAction func dismissEventsOrganizer(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            eventsFlyerImagePicker.contentMode = .scaleAspectFit
            eventsFlyerImagePicker.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

