//
//  SignInViewController.swift
//  fmcBeta
//
//  Created by Neil Leon on 7/29/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        var error: NSError?
        if error != nil {
            print(error)

            return
        }
        
        let buttonFrame : CGRect = CGRect.init(x: 0, y: 0, width: 300, height: 50)
        let signInButton = GIDSignInButton.init(frame:buttonFrame)
        signInButton.center = view.center
        view.addSubview(signInButton)

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().clientID = "14686721816-plr0fibrbap3v8qds70863bj440luio6.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                // Perform any operations on signed in user here.
                let userId = user.userID                  // For client-side use only!
                let idToken = user.authentication.idToken // Safe to send to the server
                let fullName = user.profile.name
                let givenName = user.profile.givenName
                let familyName = user.profile.familyName
                let email = user.profile.email
                // ...
               
               
            }
        

//        if error != nil {
//            print(error)
//            return
//        }
        
        print("success login google")
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
       Auth.auth().signIn(with: credential) { (authResult, error) in
            if let err = error {
                print("Failed Auth",err)
                return
            }
            // User is signed in
            
        }
        
        
        performSegue(withIdentifier: "SignInDidTap", sender: self)
        
        print(user.profile.name)
    }

        
    }
    




