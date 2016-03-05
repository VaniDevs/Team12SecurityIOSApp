//
//  AVPreviewView.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import AVFoundation
import UIKit

final class AVPreviewView: UIView {
    override class func layerClass() -> AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    func session() -> AVCaptureSession {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else { fatalError() }
        return layer.session
    }
    
    func setSession(session: AVCaptureSession) {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else { fatalError() }
        layer.session = session
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
    }
}