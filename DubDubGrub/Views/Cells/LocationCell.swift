//
//  LocationCell.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/21/23.
//

import SwiftUI

struct LocationCell: View {
    
    var location: DDGLocation
    
    var body: some View {
        HStack {
            Image(uiImage: location.createSquareImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 170)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                HStack {
                    AvatarView(image: PlaceholderImage.avatar, size: 35)
                    AvatarView(image: PlaceholderImage.avatar, size: 35)
                    AvatarView(image: PlaceholderImage.avatar, size: 35)
                    AvatarView(image: PlaceholderImage.avatar, size: 35)
                    AvatarView(image: PlaceholderImage.avatar, size: 35)
                }
            }
            .padding(.leading)
        }
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location: DDGLocation(record: MockData.location))
    }
}
