//
//  UserService.swift
//  fmcBeta
//
//  Created by Neil Leon on 8/4/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
      var GIDUser =    user.profile.name as String
            
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { (GIDUser, error) in
                if let err = error {
                    print("Failed Auth",err)
                    return
                }
                
            }
}
    
    

}


