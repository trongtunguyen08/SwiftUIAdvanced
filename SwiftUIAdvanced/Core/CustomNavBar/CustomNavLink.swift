//
//  CustomNavLink.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 4/7/24.
//

import SwiftUI

struct CustomNavLink<Destination:View,Label:View>: View {
    let destination: Destination
    let label: Label
    
    init(destination: Destination, label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavBarContainerView {
                destination
            }
            .navigationBarBackButtonHidden()
        } label: {
            label
        }
    }
}

#Preview {
    CustomNavView {
        CustomNavLink(destination: Text("Destination")) {
            Text("Navigate")
        }
        .customNavBarItems(title: "Title")
    }
    
}
