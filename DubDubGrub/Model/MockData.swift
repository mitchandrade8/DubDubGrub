//
//  MockData.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/23/23.
//

import CloudKit
import SwiftUI

struct MockData {
    
    static var location: CKRecord {
        let record = CKRecord(recordType: "DDGLocation")
        record[DDGLocation.kName] = "Top Hoop Session"
        record[DDGLocation.kAddress] = "123 Bucket Ave"
        record[DDGLocation.kDescription] = "Nothing but former D1, pro and try hard hoopers. Intense"
        record[DDGLocation.kWebsiteURL] = "https://seanallen.co"
        record[DDGLocation.kLocation] = CLLocation(latitude: 40.388274, longitude: -104.716802)
        
        return record
    }
    
}
