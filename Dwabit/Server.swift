//
//  Server.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import Firebase

final class Server {
    private let username = "Meryl"
    static let sharedInstance = Server()
    private init() {}
    
    private let firebaseRootRef = Firebase(url: "https://dwabit.firebaseio.com")
    
    private enum SubDirectories: String {
        case UserInfo, DistressSignals, DistressImages
    }
    
    func sendFirebaseCoordinates(locationInfo: DistressSignal) {
        let distressRef = firebaseRootRef.childByAppendingPath(SubDirectories.DistressSignals.rawValue)
        let userRef = distressRef.childByAppendingPath(username)
        let json = locationInfo.toJson()
        userRef.setValue(json)
    }
    
    func cancelDistressSignal() {
        let distressRef = firebaseRootRef.childByAppendingPath(SubDirectories.DistressSignals.rawValue)
        let userRef = distressRef.childByAppendingPath(username)
        userRef.removeValue()
    }
    
    func saveUserInfo(userInfo: UserInfo) {
        let userInfoRef = firebaseRootRef.childByAppendingPath(SubDirectories.UserInfo.rawValue)
        let currentUserRef = userInfoRef.childByAppendingPath(username)
        currentUserRef.setValue(userInfo.toJson())
    }
    
    func sendDistressImages(distressImage: DistressImage) {
        let distressImagesRef = firebaseRootRef.childByAppendingPath(SubDirectories.DistressImages.rawValue)
        let userRef = distressImagesRef.childByAppendingPath(username)
        let autoRef = userRef.childByAutoId()
        
        autoRef.setValue(distressImage.imageString)
    }
    
    func purgeImages() {
        let distressImagesRef = firebaseRootRef.childByAppendingPath(SubDirectories.DistressImages.rawValue)
        let userRef = distressImagesRef.childByAppendingPath(username)
        
        userRef.removeValue()
    }
}