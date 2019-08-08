//
//  AudioFeedTableViewCell.swift
//  fmcBeta
//
//  Created by Neil Leon on 7/12/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit

class AudioFeedTableViewCell: UITableViewCell {
    

    @IBOutlet weak var mp3ImageLabel: UIImageView!
    @IBOutlet weak var mp3TitleLabel: UILabel!
    @IBOutlet weak var mp3Timestamp: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
