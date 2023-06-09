//
//  LocationDetailViewModel.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 6/1/23.
//

import CloudKit
import MapKit
import SwiftUI

enum CheckInStatus {
    case checkedIn, checkedOut
}

final class LocationDetailViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [DDGProfile] = []
    @Published var alertItem: AlertItem?
    @Published var isCheckedIn = false
    @Published var isLoading = false
    @Published var isShowingProfileModal = false
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())
    ]
    
    var location: DDGLocation
    
    init(location: DDGLocation) {
        self.location = location
    }
    
    
    func getDirectionsToLocation() {
        let placemark = MKPlacemark(coordinate: location.location.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.name
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    
    func callLocation() {
        guard let url = URL(string: "tel://\(location.phoneNumber)") else {
            alertItem = AlertContext.invalidPhoneNumber
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    
    func getCheckedInStatus() {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let record):
                    if let reference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                        isCheckedIn = reference.recordID == location.id
                    } else {
                        isCheckedIn = false
                    }
                    
                case .failure(_):
                    alertItem = AlertContext.unableToGetCheckInStatus
                }
            }
        }
    }
    
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        // Retrieve the DDGProfile
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            alertItem = AlertContext.unableToGetProfile
            return
        }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            switch result {
            case .success(let record):
                // Create a reference to the location
                switch checkInStatus {
                case .checkedIn:
                    record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                    record[DDGProfile.kIsCheckedInNilCheck] = 1
                case .checkedOut:
                    record[DDGProfile.kIsCheckedIn] = nil
                    record[DDGProfile.kIsCheckedInNilCheck] = nil
                }
                
                // Save the updatedd profile to CloudKit
                CloudKitManager.shared.save(record: record) { result in
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let record):
                            let profile = DDGProfile(record: record)
                            switch checkInStatus {
                            case .checkedIn:
                                checkedInProfiles.append(profile)
                            case .checkedOut:
                                checkedInProfiles.removeAll(where: { $0.id == profile.id })
                            }
                            
                            isCheckedIn = checkInStatus == .checkedIn
                            
                        case .failure(let failure):
                            alertItem = AlertContext.unableToCheckInOrOut
                        }
                    }
                }
                
            case .failure(_):
                alertItem = AlertContext.unableToCheckInOrOut
            }
        }
    }
    
    func getCheckedInProfiles() {
        showLoadingView()
        CloudKitManager.shared.getCheckedInProfiles(for: location.id) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let profiles):
                    checkedInProfiles = profiles
                case .failure(_):
                    alertItem = AlertContext.unableToGetCheckedInProfiles
                }
                
                hideLoadingView()
            }
        }
    }
    
    // MARK: - Helper functions
    
    /// Fucntions for loading view
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
    
}
