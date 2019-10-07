//
//  EventsTableViewCell.swift
//  fmcBeta
//
//  Created by Xcode Mac on 8/27/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class EventsTableViewCell: UITableViewCell {
    @IBOutlet weak var eventLocation: UITextView!
    @IBOutlet weak var eventDate: UITextView!
    @IBOutlet weak var eventTitle: UITextView!
    @IBOutlet weak var flyerImages: UIImageView!
    
    
    
    
    
    
    func detector() {
    
    eventLocation.dataDetectorTypes = (UIDataDetectorTypes.all)
        
    eventDate.dataDetectorTypes = (UIDataDetectorTypes.all)
        
    eventTitle.dataDetectorTypes = (UIDataDetectorTypes.all)
    
    eventTitle.isEditable = false
    eventTitle.isSelectable = true
    eventTitle.isUserInteractionEnabled = true
    
    eventDate.isEditable = false
    eventDate.isSelectable = true
    eventDate.isUserInteractionEnabled = true
    
    eventLocation.isEditable = false
    eventLocation.isSelectable = true
    eventLocation.isUserInteractionEnabled = true
    
    
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
   
}
