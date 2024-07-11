//
//  CustomTabBarView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 3/7/24.
//

import SwiftUI

struct AppTabBarView: View {
    @State private var selection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selectionValue: $selection) {
            Text("Home")
                .asTabItem(selection: $selection, tab: .home)
            
            Text("Favorites")
                .asTabItem(selection: $selection, tab: .favorite)
            
            Text("Profile")
                .asTabItem(selection: $selection, tab: .profile)
        }
        
    }
}

#Preview {
    AppTabBarView()
}
