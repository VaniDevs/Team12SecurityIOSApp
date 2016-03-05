//
//  InitialViewController.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit
import CoreLocation


final class InitialViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private let debug = true
    
    @IBOutlet private var purgeFirebaseButton: UIBarButtonItem! { didSet {
        if !debug { navigationItem.leftBarButtonItem = nil }
    }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        
        let userInfo = UserInfo(name: "Meryl", age: "32", gender: "Male", phone: "878-848-4838", sin: "213 3234 554", address: "1 Infinite Loop, Cupertino")
        Server.sharedInstance.saveUserInfo(userInfo)
    }
}

// MARK: - CLLocationManagerDelegate
extension InitialViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.first?.coordinate else { fatalError() }
        Server.sharedInstance.sendFirebaseCoordinates(DistressSignal(coordinates: coordinates))
    }
}

// MARK: - @IBActions
private extension InitialViewController {
    @IBAction func purgeFirebaseTapped(sender: AnyObject) {
        Server.sharedInstance.purgeFirebase()
    }
}

// MARK: - Private Helper Methods
private extension InitialViewController {
    func setupLocationManager() {
        guard CLLocationManager.locationServicesEnabled() else { fatalError() }
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
}