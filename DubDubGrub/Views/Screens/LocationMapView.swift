//
//  LocationMapView.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/19/23.
//

import MapKit
import SwiftUI

struct LocationMapView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.388274,
                                longitude: -104.716802),
        span: MKCoordinateSpan(latitudeDelta: 0.03,
                               longitudeDelta: 0.03))
    
    @State private var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
            
            VStack {
                LogoView()
                    .shadow(radius: 10)
                
                Spacer()
            }
        }
        .alert(item: $alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })
        .onAppear {
            CloudKitManager.getLocations { result in
                switch result {
                case .success(let locations):
                    print(locations)
                case .failure(_):
                    alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
    }
}

struct LogoView: View {
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(height: 70)
    }
}
