//
//  LocationDetailView.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/19/23.
//

import SwiftUI

struct LocationDetailView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("default-banner-asset")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                
                Spacer()
            }
            .navigationTitle("Location Name")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView()
    }
}
