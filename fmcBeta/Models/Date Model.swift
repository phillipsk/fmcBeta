//
//  Date Model.swift
//  fmcBeta
//
//  Created by Neil Leon on 7/18/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import Foundation
extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }else if secondsAgo < month {
            return "\(secondsAgo / week) weeks ago"
        }else if secondsAgo < month / week {
            return "\(secondsAgo / week) week ago"
        }
         return "\(secondsAgo / month) months ago"
    }
 
}


