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
    
    func sendFirebaseCoordinates(locationInfo: LocationInfo) {
        let json = locationInfo.toJson()
        firebaseRootRef.setValue(json)
    }
}