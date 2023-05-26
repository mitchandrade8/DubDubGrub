//
//  UIImage+Ext.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/26/23.
//

import ClockKit
import UIKit

extension UIImage {
    
    func convertToCKAsset() -> CKAsset? {
        
        // 1. Get our apps base document directory url
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        // 2. Append some unique identifier for our profile image
        
        
        // 3. Write the image data to the location the address points to
        
        
        // 4. Create our CKAsset with that fileURL
        
        
        return nil
    }
}
