//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/24/23.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
    
    var selectedLocation: DDGLocation?
     
}
