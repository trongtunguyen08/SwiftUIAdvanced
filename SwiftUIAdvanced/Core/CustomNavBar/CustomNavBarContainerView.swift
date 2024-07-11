//
//  CustomNavBarContainerView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 4/7/24.
//

import SwiftUI

struct CustomNavBarContainerView<Content:View>: View {
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    @State private var showBackButton: Bool = true
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBarView(title: title, subtitle: subtitle, showBackButton: showBackButton)
            
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self, perform: { value in
            self.title = value
        })
        .onPreferenceChange(CustomNavBarSubtitlePreferenceKey.self, perform: { value in
            self.subtitle = value
        })
        .onPreferenceChange(CustomNavBackButtonHiddenPreferenceKey.self, perform: { value in
            self.showBackButton = !value
        })
    }
}

#Preview {
    CustomNavBarContainerView {
        ZStack {
            Color.red.ignoresSafeArea()
            
            Text("Hello world")
                .foregroundStyle(Color.white)
        }
        .customNavBarItems(title: "Title", subtitle: "Subtitle")
    }
}
