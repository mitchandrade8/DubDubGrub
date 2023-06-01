//
//  ProfileModalView.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 6/1/23.
//

import SwiftUI

struct ProfileModalView: View {
    
    @Binding var isShowingProfileModel: Bool
    var profile: DDGProfile
    
    var body: some View {
        ZStack {
            VStack {
                
                Spacer().frame(height: 30)
                
                Text(profile.firstName + " " + profile.lastName)
                    .fontWeight(.bold)
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                Text(profile.companyName)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.secondary)
                
                Text(profile.bio)
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                    .padding()
            }
            .frame(width: 300, height: 230)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .overlay(
                Button {
                    withAnimation {
                        isShowingProfileModel = false
                    }
                } label: {
                    XDismissButton()
                },alignment: .topTrailing
            )
            
            Image(uiImage: PlaceholderImage.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6)
                .offset(y: -125)
        }
    }
}

struct ProfileModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalView(isShowingProfileModel: .constant(true), profile: DDGProfile(record: MockData.profile))
    }
}
