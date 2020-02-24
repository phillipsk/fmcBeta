//
//  CustomTableViewCell.swift
//  fmcBeta
//
//  Created by Neil Leon on 7/11/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var mainTextLabel: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
mainTextLabel.textContainer.lineBreakMode = .byCharWrapping
mainTextLabel.textContainer.maximumNumberOfLines = 5
    mainTextLabel.delegate = self
        
}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
}


}
extension CustomTableViewCell : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
        let size = CGSize(width: 345, height: 0.50)
        
        
        
        mainTextLabel.sizeThatFits(size)
        
    }
}
