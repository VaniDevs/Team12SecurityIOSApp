//
//  Server.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import Firebase

final class Server {
    static let sharedInstance = Server()
    private init() {}
    
    private let firebaseRootRef = Firebase(url: "https://dwabit.firebaseio.com")
    
    private enum SubDirectories: String {
        case UserInfo, DistressSignal
    }
    
    func sendFirebaseCoordinates(locationInfo: DistressSignal) {
        let distressRef = firebaseRootRef.childByAppendingPath(SubDirectories.DistressSignal.rawValue)
        let json = locationInfo.toJson()
        distressRef.setValue(json)
    }
    
    func purgeFirebase() {
        firebaseRootRef.removeValue()
    }
    
    func saveUserInfo(userInfo: UserInfo) {
        let userInfoRef = firebaseRootRef.childByAppendingPath(SubDirectories.UserInfo.rawValue)
        let currentUserRef = userInfoRef.childByAppendingPath("Meryl")
        currentUserRef.setValue(userInfo.toJson())
    }
}