//
//  ComposeViewController.swift
//  fmcBeta
//
//  Created by Neil Leon on 6/6/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import GoogleSignIn

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var ref:DatabaseReference?
    
    struct postRef {
        var textView: UITextView?
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
ref = Database.database().reference()
        
       
        
}
   

    
    
    
    @IBAction func addPost(_ sender: Any) {
        
    
        
        let objectToSave: [String: Any] = ["date": [".sv":"timestamp"], "text": textView.text, ]
        
        
        
        ref?.child("Posts").childByAutoId().setValue(objectToSave)
        
        //Dismiss popover
        presentingViewController?.dismiss(animated: true, completion: nil)
}
    
    @IBAction func cancelPost(_ sender: Any) {
        //Dismiss popover
        presentingViewController?.dismiss(animated: true, completion: nil)
}
    
    
    
}
