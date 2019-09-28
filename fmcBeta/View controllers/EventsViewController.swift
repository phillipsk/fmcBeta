//
//  EventsViewController.swift
//  fmcBeta
//
//  Created by Xcode Mac on 8/9/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EventsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    @IBOutlet weak var tableView: UITableView!
    
    var eventsRef: DatabaseReference?
    var eventsDatabaseHandle:DatabaseHandle?
    
    
    var eventsTitles = [String]()
    var eventTimestamps = [String]()
    var eventsLocations = [String]()
    
    
    @IBOutlet weak var addEventsButton: UIBarButtonItem!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    
    var imgArr = [  UIImage(named:"1"),
                    UIImage(named:"2"),
                    UIImage(named:"3"),
                    UIImage(named:"4"),
                    UIImage(named:"5"),
                    UIImage(named:"6"),
                    UIImage(named:"7"),
                    UIImage(named:"8"),
                    UIImage(named:"9"),
                    UIImage(named:"10") ]
    
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        eventsRef = Database.database().reference()
        
        tableView.reloadData()
        
  tableView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    eventsDatabaseHandle = eventsRef?.child("Church Events").observe(.childAdded, with: { (snaphot) in
        
         let eventPost = snaphot.value as! [String: Any]
        
        
      self.eventTimestamps.append(eventPost["eventdate"] as! String)
        
        
        self.eventsTitles.append(eventPost["eventtitle"] as! String)
        
self.eventsLocations.append(eventPost["eventlocation"] as! String)
        
        
        self.tableView.reloadData()
        
        })
        
//**************************************************************************
        
        
        if (Auth.auth().currentUser!.displayName != "Neil Leon")  {
            self.addEventsButton.tintColor = UIColor.clear
            self.addEventsButton.isEnabled = false
            
        }
        else{
            
            self.addEventsButton.isEnabled = true
        }
    
}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "events") as! EventsTableViewCell
        
        cell.eventTitle.text! = eventsTitles[indexPath.row]
        
        cell.eventDate.text! =  eventTimestamps[indexPath.row]
        
        cell.eventLocation.text! = eventsLocations[indexPath.row]
        
        
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        
        
        return cell
    }

}

