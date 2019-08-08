//
//  FeedViewController.swift
//  fmcBeta
//
//  Created by Neil Leon on 6/6/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAnalytics
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
// @IBOutlet weak var timeStamp: UILabel!
       var ref: DatabaseReference?
       var databaseHandle:DatabaseHandle?

       var notifications = [String]()
       var timestamps:[NSDate] = []
    
@IBOutlet weak var tableView: UITableView!
    
override func viewDidLoad() {
        super.viewDidLoad()
        
//Set the Firebase reference
    ref = Database.database().reference()
        
        tableView.delegate = self
        tableView.dataSource = self
    
     tableView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        
//Retrieve the post and listen for changes
       databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snaphot) in
            print(snaphot)
            print(snaphot.value)
    
        
        let post = snaphot.value as! [String: Any]
        print(post["date"])
//        print(post["text"])
        
        let timestamp = post["date"] as! TimeInterval
        let timeDate:NSDate = NSDate(timeIntervalSince1970: timestamp/1000)
    
        print(timeDate)
        self.timestamps.append(timeDate)
        
        
        self.notifications.append(post["text"] as! String)
        print(self.notifications)
        
        
        self.tableView.reloadData()
        
       
        
})
        
    
}
    


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return notifications.count
    
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! CustomTableViewCell
        

        
        cell.mainTextLabel.text = notifications[indexPath.row]
    
//Code to turn an NSDate into a String so it can be displayed in the label.
        let tempTimestamp:NSDate = timestamps[indexPath.row]
        let timestampDate:Date = tempTimestamp as Date
        
     cell.timestampLabel.text = timestampDate.timeAgoDisplay()
    
    cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
    
        return cell
}
}


