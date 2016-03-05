//
//  UserData.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import Foundation

struct UserData {
    let username: String
    let phoneNumber: String
    let address: String
    
    static func sampleUserData() -> NSDictionary {
        return [
            "username": "Daryl",
            "phoneNumber": "604-888-8888",
            "address": "Atlanta"
        ]
    }
}
