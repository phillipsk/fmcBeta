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

class PrayerWallPostViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var privacyFilter: UISwitch!
    
    @IBOutlet weak var prayerPostText: UITextView!
    var prayerRef:DatabaseReference?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        prayerRef = Database.database().reference()
        
        prayerPostText.text = "Type yout prayer request here"
        prayerPostText.textColor = UIColor.lightGray
        prayerPostText.font = UIFont(name: "verdana", size: 13.0)
        prayerPostText.returnKeyType = .done
        prayerPostText.delegate = self
     

    }
    //MARK:- UITextViewDelegates
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type yout prayer request here" {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "verdana", size: 16.0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Type yout prayer request here"
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "verdana", size: 13.0)
        }
    }
  
    
//////////////////////////////////
    @IBAction func didPostPrayerRequest(_ sender: Any) {
        
       
        
        var userInfo = Auth.auth().currentUser?.displayName
        
        if privacyFilter.isOn {
            userInfo? = "Anonymous"
        }
        
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
