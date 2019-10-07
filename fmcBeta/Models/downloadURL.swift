////
////  downloadURL.swift
////  fmcBeta
////
////  Created by Xcode Mac on 9/28/19.
////  Copyright © 2019 Neil Leon. All rights reserved.
////
//
//import Foundation
//import UIKit
//import FirebaseStorage
//import FirebaseDatabase
//
//
//func url()  {
//    
//    
//    var strURL = ""
//    let randomID = UUID.init().uuidString
//    let imageRef = Storage.storage().reference(withPath: "Events/\(randomID).jpg")
//   // guard let eventsImageData = eventsFlyerImagePicker.image?.jpegData(compressionQuality: 0.75) else {return}
//    let uploadMetadata = StorageMetadata.init()
//    uploadMetadata.contentType = "image/jpeg"
//    
//    imageRef.putData(eventsImageData, metadata: uploadMetadata) { (downloadMetadata, error) in
//        if let error = error {
//            print("Something went wrong! \(error.localizedDescription)")
//            
//        }
//        imageRef.downloadURL(completion: { (url, error) in
//            if let urlText = url?.absoluteString {
//                strURL = urlText
//                
//                print("\(strURL)")
//                
//            }
//            else{
//                print("Woops something went wrong! \(error!.localizedDescription)")
//            }
//            
//            
//        })
//        
//    }
//    
//    
//}
