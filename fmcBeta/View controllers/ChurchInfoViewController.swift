//
//  ChurchInfoViewController.swift
//  fmcBeta
//
//  Created by Neil Leon on 7/31/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
class ChurchInfoViewController: UIViewController {
    
    
    @IBOutlet weak var faceBook: UIImageView!
    
    @IBOutlet weak var instaGram: UIImageView!
    
    @IBOutlet weak var churchWebsite: UIImageView!
    
    
    
    
    @IBAction func churchLocation(_ sender: Any)
    {
        //Defining destination
        let latitude:CLLocationDegrees = 42.3284719
        let longitude:CLLocationDegrees = -71.097651
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Fellowship Mission Church"
        mapItem.openInMaps(launchOptions: options)
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func instagramDidGetTouch(_ sender: Any) {
   UIApplication.shared.openURL(URL(string: "https://www.instagram.com/fellowshipmissionchurch/?hl=en")!)
        
    }
    
    @IBAction func facebookDidGetTapped(_ sender: Any) {
     UIApplication.shared.openURL(URL(string: "https://www.facebook.com/fellowshipmission.church/")!)
    
    }
    
    @IBAction func churchSiteDidGetTapped(_ sender: Any) {
    
        UIApplication.shared.openURL(URL(string: "http://fellowshipmission.church/")!)
    
    }
    
    @IBAction func userDidSignOut(_ sender:Any ) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let welcomVC = self.storyboard?.instantiateViewController(withIdentifier: "welcome")
        self.present(welcomVC!, animated: true, completion: nil)
        
        
    }
    
}

