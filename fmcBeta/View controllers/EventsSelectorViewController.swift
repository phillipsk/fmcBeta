//
//  EventsSelectorViewController.swift
//  fmcBeta
//
//  Created by Xcode Mac on 8/10/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class EventsSelectorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate {
    

    var eventsRef: DatabaseReference!
    var eventImagesRef : DatabaseReference!
    
   
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var eventsTitleTextField: UITextView!
    @IBOutlet weak var eventDateSelector: UIDatePicker!
    
    @IBOutlet weak var eventTimePicker: UIDatePicker!
    @IBOutlet weak var eventsLocation: UITextView!
    
    
    @IBAction func eventsDateSelector(_ sender: Any) {
        
        
        
        
    }
    @IBOutlet weak var eventsFlyerImagePicker:
      UIImageView!
    @IBAction func imageSelector(_ sender: Any) {
        
//
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .photoLibrary
//
//        present(imagePicker, animated: true, completion: nil)
//
//
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 eventsRef = Database.database().reference()
  
 eventImagesRef = Database.database().reference()
        
      

        
        
      
        imagePicker.delegate = self
        
     eventsLocation.dataDetectorTypes = (UIDataDetectorTypes.all)
        
     eventsTitleTextField.dataDetectorTypes = (UIDataDetectorTypes.all)
        
        
        eventsTitleTextField.isEditable = true
        eventsTitleTextField.isSelectable = true
        eventsTitleTextField.isUserInteractionEnabled = true
        
        eventsLocation.isEditable = true
        eventsLocation.isSelectable = true
        eventsLocation.isUserInteractionEnabled = true
        
        
        
        
        
    }
    
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
    
    @IBAction func saveEventsButton(_ sender: Any) {
        let randomID = UUID.init().uuidString
        let imageRef = Storage.storage().reference(withPath: "Events/\(randomID).jpg")
        guard let eventsImageData = eventsFlyerImagePicker.image?.jpegData(compressionQuality: 0.75) else {return}
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        
        imageRef.putData(eventsImageData, metadata: uploadMetadata) { (downloadMetadata, error) in
            if let error = error {
                
                print("Something went wrong! \(error.localizedDescription)")
            }
            
            
        }
        
      
            
        let A = DateFormatter.localizedString(from: eventDateSelector.date, dateStyle: DateFormatter.Style.full, timeStyle: DateFormatter.Style.none) as String
        
        let B = DateFormatter.localizedString(from: eventTimePicker.date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short) as String
        
        let eventsDates = "\(A) @\(B)"
        
        print(eventsDates.description)
        
        let eventSaved:[String: Any] = ["eventdate": eventsDates,"eventtitle":eventsTitleTextField.text!,"eventlocation":eventsLocation.text!]
        
        eventsRef.child("Church Events").childByAutoId().setValue(eventSaved)
        
        
        
        self.dismiss(animated: true, completion: nil)
    
    }
    

}


