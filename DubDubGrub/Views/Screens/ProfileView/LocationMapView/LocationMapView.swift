//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/19/23.
//

import MapKit
import SwiftUI

struct LocationMapView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationMapViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true , annotationItems: locationManager.locations) { location in
                MapAnnotation(coordinate: location.location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    DDGAnnotation(location: location)
                        .onTapGesture {
                            locationManager.selectedLocation = location
                            viewModel.isShowingDetailView = true
                        }
                }
            }
            .accentColor(.grubRed)
            .ignoresSafeArea()
            
            VStack {
                LogoView(frameWidth: 125)
                    .shadow(radius: 10)
                
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.isShowingDetailView) {
            NavigationView {
                LocationDetailView(viewModel: LocationDetailViewModel(location: locationManager.selectedLocation!))
                    .toolbar {
                        Button("Dismiss", action: { viewModel.isShowingDetailView = false })
                    }
            }
            .accentColor(.brandPrimary)
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .onAppear {
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
        }
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
    }
}


