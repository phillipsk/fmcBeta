//
//  TestViewController.swift
//  fmcBeta
//
//  Created by Xcode Mac on 8/30/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var output: UITextView!
    @IBOutlet weak var output2: UILabel!
    
    @IBOutlet weak var input2: UILabel!
    @IBOutlet weak var input: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

 input.dataDetectorTypes = (UIDataDetectorTypes.all)
 
        output.isEditable = true
        input.isSelectable = true
        input.isUserInteractionEnabled = true
        
        output.isEditable = false
        output.isSelectable = true
        output.isUserInteractionEnabled = true
        
    }
  
    @IBAction func action(_ sender: Any) {
        if input.text != nil {
            output.text = input.text
        }
    }
}
