//
//  View+Ext.swift
//  DubDubGrub
//
//  Created by Mitch Andrade on 5/21/23.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameText())
    }
}
