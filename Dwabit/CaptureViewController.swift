//
//  CaptureViewController.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import AVFoundation
import UIKit

protocol CaptureViewDelegate {
    func imageCaptured(image: UIImage)
}

final class CaptureViewController: UIViewController {
    @IBOutlet private var previewView: AVPreviewView!
    
    private let session = AVCaptureSession()
    private let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    private let output = AVCaptureStillImageOutput()
    private var input: AVCaptureDeviceInput!
    
    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        session.startRunning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        session.stopRunning()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        captureImages()
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
        // TODO: do the 30 picture evidence stuff
        guard let connection = output.connections.first as? AVCaptureConnection else { fatalError() }
        output.captureStillImageAsynchronouslyFromConnection(connection) { buffer, error in
            if let error = error {
                fatalError("Error capturing image: \(error)")
            } else {
                let data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)
                guard let image = UIImage(data: data) else { fatalError() }
                dispatch_async(dispatch_get_main_queue()) {
                    self.imageView.image = image
                }
            }
        }
    }
}