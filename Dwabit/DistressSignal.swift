//
//  LocationInfo.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import CoreLocation

struct DistressSignal {
    let longitude: Double
    let latitude: Double
    
    init(coordinates: CLLocationCoordinate2D) {
        longitude = coordinates.longitude
        latitude = coordinates.latitude
    }
    
    func toJson() -> NSDictionary {
        return [
            "longitude": "\(longitude)",
            "latitude": "\(latitude)"
        ]
    }
}