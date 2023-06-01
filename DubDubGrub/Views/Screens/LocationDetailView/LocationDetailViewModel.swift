//
//  LocationDetailViewModel.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 6/1/23.
//

import SwiftUI

final class LocationDetailViewModel: ObservableObject {
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())
    ]
    
    var location: DDGLocation
    
    init(location: DDGLocation) {
        self.location = location
    }
}
