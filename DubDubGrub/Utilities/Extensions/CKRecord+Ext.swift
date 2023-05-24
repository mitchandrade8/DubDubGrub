//
//  CKRecord+Ext.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/23/23.
//

import CloudKit

extension CKRecord {
    func convertToDDGLocation() -> DDGLocation { DDGLocation(record: self) }
    func convertToDDGProfile() -> DDGProfile { DDGProfile(record: self) }
}
