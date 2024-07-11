//
//  CustomNavBarView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 4/7/24.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.yellow.ignoresSafeArea()
                
                CustomNavLink(destination: Text("Destination").customNavBarItems(title: "Back")) {
                    Text("Navigate")
                }
            }
            .customNavBarItems(title: "Nav Title here")
        }
    }
}

extension AppNavBarView {
    private var defaultNavBar: some View {
        NavigationView(content: {
            ZStack {
                Color.green.ignoresSafeArea()
                
                NavigationLink {
                    Text("Destination")
                } label: {
                    Text("Navigate")
                }
            }
            .navigationTitle("Navigate title here")
        })
    }
}

#Preview {
    AppNavBarView()
}
