//
//  LocationInfo.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import CoreLocation
import UIKit

struct DistressSignal {
    let longitude: Double
    let latitude: Double
    let name: String
    
    init(coordinates: CLLocationCoordinate2D, name: String) {
        longitude = coordinates.longitude
        latitude = coordinates.latitude
        self.name = name
    }
    
    func toJson() -> NSDictionary {
        return [
            "longitude": "\(longitude)",
            "latitude": "\(latitude)",
            "name": "\(name)"
        ]
    }
}