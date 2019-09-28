//
//  TestViewController.swift
//  fmcBeta
//
//  Created by Xcode Mac on 8/30/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import Firebase


var prayRef:DatabaseReference!



class TestViewController: UIViewController {
    @IBOutlet weak var im1: UIImageView!
    @IBOutlet weak var im2: UIImageView!
    @IBOutlet weak var output: UITextView!
    @IBOutlet weak var output2: UILabel!
    
    @IBOutlet weak var input2: UILabel!
    @IBOutlet weak var input: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

prayRef = Database.database().reference()
        
   
        
    }
  
    @IBAction func action(_ sender: Any) {
     
        prayRef.child("test").observe(.value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let orderID = child.key
                    print(orderID)
                }
            }
        })
        
        prayRef = Database.database().reference().child("tt")
        incrementLikes(forRef: prayRef)
    }
    
    func incrementLikes(forRef ref:DatabaseReference){
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
                var stars: Dictionary<String, Bool>
                stars = post["stars"] as? [String : Bool] ?? [:]
                var starCount = post["starCount"] as? Int ?? 0
                if let _ = stars[uid] {
                    // Unstar the post and remove self from stars
                    starCount -= 1
                    stars.removeValue(forKey: uid)
                } else {
                    // Star the post and add self to stars
                    starCount += 1
                    stars[uid] = true
                }
                post["starCount"] = starCount as AnyObject?
                post["stars"] = stars as AnyObject?
                
                // Set value and report transaction success
                currentData.value = post
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
        
    
        
    
    }
    
    

    
    
    
    
    

