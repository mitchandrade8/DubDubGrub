//
//  OnboardView.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/24/23.
//

import SwiftUI

struct OnboardView: View {
    
    @Binding var isShowingOnboardView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isShowingOnboardView = false
                } label: {
                    XDismissButton()
                }
                .padding()
            }
            
            Spacer()
            LogoView(frameWidth: 250)
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 32) {
                OnboardInfoView(imageName: "building.2.crop.circle", title: "Hoop Locations", description: "Find places to hoop at")
                OnboardInfoView(imageName: "checkmark.circle", title: "Check In", description: "Let other hoopers know where you are")
                OnboardInfoView(imageName: "person.2.circle", title: "Find Friends", description: "See where people are hooping at and join the fun")
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}


struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView(isShowingOnboardView: .constant(true))
    }
}


struct OnboardInfoView: View {
    
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(spacing: 26) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 70, height: 70)
                .foregroundColor(.brandPrimary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title).bold()
                Text(description)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}
