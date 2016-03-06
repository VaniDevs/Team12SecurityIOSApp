//
//  DistressImage.swift
//  Dwabit
//
//  Created by Kelvin Lau on 2016-03-05.
//  Copyright © 2016 Dwabit. All rights reserved.
//

import UIKit

struct DistressImage {
    let imageString: String
    
    init(image: UIImage) {
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else { fatalError() }
        guard let imageString = String(data: imageData, encoding: NSUTF8StringEncoding) else { fatalError() }
        
        self.imageString = imageString as String
    }
    
    func toJson() -> NSDictionary {
        return [
            "imageString": imageString
        ]
    }
}