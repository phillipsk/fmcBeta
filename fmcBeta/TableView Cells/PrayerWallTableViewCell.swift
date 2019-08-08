//
//  PrayerWallTableViewCell.swift
//  fmcBeta
//
//  Created by Neil Leon on 8/1/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit

class PrayerWallTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var prayerRequestLabel: UILabel!
    @IBOutlet weak var wallTimeStamp: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var prayingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
