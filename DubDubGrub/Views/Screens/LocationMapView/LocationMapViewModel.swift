//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/23/23.
//

import MapKit
import SwiftUI

final class LocationMapViewModel: ObservableObject {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.388274,
                                longitude: -104.716802),
        span: MKCoordinateSpan(latitudeDelta: 0.03,
                               longitudeDelta: 0.03))
    
    @Published var alertItem: AlertItem?
    
    func getLocations(for locationManager: LocationManager) {
        CloudKitManager.getLocations { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    locationManager.locations = locations
                case .failure(_):
                    alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }
}
