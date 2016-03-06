//
//  SecurityViewController.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

final class SecurityViewController: UIViewController {
    private let locationManager = CLLocationManager()
    
    private let session = AVCaptureSession()
    private let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    private let output = AVCaptureStillImageOutput()
    private var input: AVCaptureDeviceInput!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        
        let userInfo = UserInfo(name: "Meryl", age: "32", gender: "Male", phone: "878-848-4838", sin: "213 3234 554", address: "1 Infinite Loop, Cupertino")
        Server.sharedInstance.saveUserInfo(userInfo)
        
        setupCamera()
        session.startRunning()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        captureImages()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        session.stopRunning()
    }
}

// MARK: - CLLocationManagerDelegate
extension SecurityViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.first?.coordinate else { fatalError() }
        Server.sharedInstance.sendFirebaseCoordinates(DistressSignal(coordinates: coordinates, name: "Meyrl"))
    }
}

// MARK: - Private Helper Methods
private extension SecurityViewController {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func setupCamera() {
        input = try! AVCaptureDeviceInput(device: device)
        
        session.addInput(input)
        session.addOutput(output)
        session.sessionPreset = AVCaptureSessionPresetMedium
    }
    
    func captureImages() {
        guard let connection = output.connections.first as? AVCaptureConnection else { fatalError() }
        output.captureStillImageAsynchronouslyFromConnection(connection) { buffer, error in
            if let error = error {
                fatalError("Error Capturing Image: \(error)")
            } else {
                let data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)
                guard let image = UIImage(data: data) else { fatalError() }
                let distressImage = DistressImage(image: image)
                Server.sharedInstance.sendDistressImages(distressImage)
            }
        }
    }
}