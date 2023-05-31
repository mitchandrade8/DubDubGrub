//
//  LocationMapViewModel.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/23/23.
//

import MapKit
import SwiftUI

final class LocationMapViewModel: NSObject, ObservableObject {
    
    @Published var isShowingOnboardView = false
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.388274,
                                longitude: -104.716802),
        span: MKCoordinateSpan(latitudeDelta: 0.03,
                               longitudeDelta: 0.03))
    @Published var alertItem: AlertItem?
    
    var deviceLocationManager: CLLocationManager?
    let kHasSeenOnboardView = "hasSeenOnboardView"
    
    var hasSeenOnboardView: Bool {
        return UserDefaults.standard.bool(forKey: kHasSeenOnboardView)
    }
    
    func runStartupChecks() {
        if !hasSeenOnboardView {
            isShowingOnboardView = true
            UserDefaults.standard.set(true, forKey: kHasSeenOnboardView)
        } else {
            checkIfLocationServiceIsEnabled()
        }
    }
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            deviceLocationManager = CLLocationManager()
            deviceLocationManager?.delegate = self
        } else {
            alertItem = AlertContext.locationDisabled
        }
    }
    
    private func checkLocationAuthorization() {
        guard let deviceLocationManager = deviceLocationManager else { return }
        
        switch deviceLocationManager.authorizationStatus {
        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
        case .denied:
            alertItem = AlertContext.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func getLocations(for locationManager: LocationManager) {
        CloudKitManager.shared.getLocations { [self] result in
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

extension LocationMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
