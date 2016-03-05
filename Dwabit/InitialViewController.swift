//
//  InitialViewController.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit
import CoreLocation

struct LocationInfo {
    let longitude: Double
    let latitude: Double
    
    init(coordinates: CLLocationCoordinate2D) {
        longitude = coordinates.longitude
        latitude = coordinates.latitude
    }
    
    func toJson() -> [String: String] {
        return [
            "longitude": "\(longitude)",
            "latitude": "\(latitude)"
        ]
    }
}

final class InitialViewController: UIViewController {
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }
}

// MARK: - CLLocationManagerDelegate
extension InitialViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.first?.coordinate else { fatalError() }
        Server.sharedInstance.sendFirebaseCoordinates(LocationInfo(coordinates: coordinates))
    }
}

private extension InitialViewController {
    func setupLocationManager() {
        guard CLLocationManager.locationServicesEnabled() else { fatalError() }
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
}