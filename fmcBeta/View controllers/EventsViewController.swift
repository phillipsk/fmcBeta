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
        
        
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func changeImage() {
        
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
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

extension EventsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = imgArr[indexPath.row]
        }
        return cell
    }
    
    
}

extension EventsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
   
    
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
