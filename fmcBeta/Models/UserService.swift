//
//  UserService.swift
//  fmcBeta
//
//  Created by Neil Leon on 8/4/19.
//  Copyright © 2019 Neil Leon. All rights reserved.
//

import Foundation
import GoogleSignIn

struct guid {
    var fullName: String!
    //var email: String!
    mutating func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            fullName = user.profile.name as String
           // email = user.profile.email as String
    
}

}
}
