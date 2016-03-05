//
//  CaptureViewController.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import AVFoundation
import UIKit

final class CaptureViewController: UIViewController {
    @IBOutlet private var previewView: AVPreviewView!
    
    private let session = AVCaptureSession()
    private let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    private let output = AVCaptureStillImageOutput()
    private var input: AVCaptureDeviceInput!
    
    private var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        session.startRunning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        session.stopRunning()
    }
}

// MARK: - Private Helper Functions
private extension CaptureViewController {
    func setupCamera() {
        input = try! AVCaptureDeviceInput(device: device)

        session.addInput(input)
        session.addOutput(output)
        session.sessionPreset = AVCaptureSessionPresetMedium
        previewView.setSession(session)
    }
    
    func captureImages() {

    }
}