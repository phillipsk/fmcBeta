//
//  PrayerWallPostViewController.swift
//  fmcBeta
//
//  Created by Neil Leon on 8/1/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleSignIn
import FirebaseAuth

class PrayerWallPostViewController: UIViewController  {
  
    @IBOutlet weak var prayerPostText: UITextField!
    var prayerRef:DatabaseReference?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        prayerRef = Database.database().reference()
        
     

    }
  
    

    @IBAction func didPostPrayerRequest(_ sender: Any) {
        
      
        
         let userInfo = Auth.auth().currentUser?.displayName
        
        let prayerPosted:[String: Any] = ["praydate": [".sv":"timestamp"], "prayer": prayerPostText.text!,"username":userInfo!]
        
        prayerRef?.child("Prayers").childByAutoId().setValue(prayerPosted)
        
        print("Any")
        
        //Dismiss popover
        presentingViewController?.dismiss(animated: true, completion: nil)
    
    }
    @IBAction func didCancelPrayerRequest(_ sender: Any) {
        
        //Dismiss popover
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
 
}
