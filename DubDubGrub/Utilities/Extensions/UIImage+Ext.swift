//
//  UIImage+Ext.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/26/23.
//

import CloudKit
import UIKit


extension UIImage {
    
    func convertToCKAsset() -> CKAsset? {
        
        // 1. Get our apps base document directory url
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        // 2. Append some unique identifier for our profile image
        let fileUrl = urlPath.appendingPathComponent("selectedAvatarImage")
        
        // 3. Write the image data to the location the address points to
        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }
        
        // 4. Create our CKAsset with that fileURL
        do {
            try imageData.write(to: fileUrl)
            return CKAsset(fileURL: fileUrl)
        } catch {
            return nil
        }
        
        return nil
    }
}
