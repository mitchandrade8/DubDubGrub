//
//  DDGProfile.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/23/23.
//

import CloudKit
import SwiftUI

struct DDGProfile: Identifiable {
    
    static let kFirstName = "firstName"
    static let kLastName = "lastName"
    static let kAvatar = "avatar"
    static let kCompanyName = "companyName"
    static let kBio = "bio"
    static let kIsCheckedIn = "isCheckedIn"
    static let kIsCheckedInNilCheck = "isCheckedInNilCheck"
    
    let id: CKRecord.ID
    let firstName: String
    let lastName: String
    let avatar: CKAsset!
    let companyName: String
    let bio: String
    let isCheckedIn: CKRecord.Reference?
    
    init(record: CKRecord) {
        id = record.recordID
        firstName = record[DDGProfile.kFirstName] as? String ?? "N/A"
        lastName = record[DDGProfile.kLastName] as? String ?? "N/A"
        avatar = record[DDGProfile.kAvatar] as? CKAsset
        companyName = record[DDGProfile.kCompanyName] as? String ?? "N/A"
        bio = record[DDGProfile.kBio] as? String ?? "N/A"
        isCheckedIn = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference
    }
    
    
    func createAvatarImage() -> UIImage {
        guard let avatar = avatar else { return PlaceholderImage.avatar }
        return avatar.convertToUIImage(in: .square)
    }
}
