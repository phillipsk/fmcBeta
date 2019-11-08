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
    
//
//    var eventsTitles = [String]()
//    var eventTimestamps = [String]()
//    var eventsLocations = [String]()
//    var eventsImages = [UIImage]()
//
    
    
    struct Event {
        let title, timestamp, location : String
        var image : UIImage?
    }
    
    
    var events = [Event]()
    
    
    @IBOutlet weak var addEventsButton: UIBarButtonItem!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    adminAuth()
        
    eventsRef = Database.database().reference()

    tableView.reloadData()
        
    tableView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
        
    tableView.delegate = self
    tableView.dataSource = self
        
//    eventsDatabaseHandle = eventsRef?.child("Church Events").observe(.childAdded, with: { (snaphot) in
//
//    let eventPost = snaphot.value as! [String: Any]
//
//
//    self.eventTimestamps.append(eventPost["eventdate"] as! String)
//
//
//    self.eventsTitles.append(eventPost["eventtitle"] as! String)
//
//    self.eventsLocations.append(eventPost["eventlocation"] as! String)
//
//    let task = URLSession.shared.dataTask(with: URL(string: eventPost["ImageUrl"] as! String)!) {(data, response, error) in
//
//    if let image: UIImage = UIImage(data: data!) {
//    self.eventsImages.append(image)
//            }
//
//        }
//
//        task.resume()
//        self.tableView.reloadData()
//        })
        
        
        eventsDatabaseHandle = eventsRef?.child("Church Events").observe(.childAdded, with: { (snaphot) in
            let eventPost = snaphot.value as! [String: Any]
            var event = Event(title: eventPost["eventtitle"] as! String,
                              timestamp: eventPost["eventdate"] as! String,
                              location: eventPost["eventlocation"] as! String,
                              image: nil)
            
            let task = URLSession.shared.dataTask(with: URL(string: eventPost["ImageUrl"] as! String)!) { data, _, error in
                
                if let image: UIImage = UIImage(data: data!) {
                    event.image = image
                    DispatchQueue.main.async {
                        self.events.append(event)
                        self.tableView.reloadData()
                    }
                }
            }
            task.resume()

        })

     
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "events", for: indexPath) as! EventsTableViewCell
        let event = events[indexPath.row]
        cell.flyerImages.image = event.image
        cell.eventTitle.text = event.title
        cell.eventDate.text =  event.timestamp
        cell.eventLocation.text = event.location
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        return cell
    }
    

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return eventsTitles.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "events") as! EventsTableViewCell
//
//       // let image = eventsImages[indexPath.row]
//
//     cell.flyerImages.image? = eventsImages[indexPath.row]
//
//        cell.eventTitle.text! = eventsTitles[indexPath.row]
//
//        cell.eventDate.text! =  eventTimestamps[indexPath.row]
//
//        cell.eventLocation.text! = eventsLocations[indexPath.row]
//
//
//        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//
//
//        return cell
//    }
    
    
    func adminAuth() {
        
        if (Auth.auth().currentUser!.displayName != "Neil Leon")  {
            self.addEventsButton.tintColor = UIColor.clear
            self.addEventsButton.isEnabled = false
            
        }
        else{
            
            self.addEventsButton.isEnabled = true
        }
        
    }

}

