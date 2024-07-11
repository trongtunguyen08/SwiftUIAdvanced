//
//  CustomTabBarContainerView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 3/7/24.
//

import SwiftUI

struct CustomTabBarContainerView<Content:View>: View {
    @Binding var selection: TabBarItem
    @State private var tabs: [TabBarItem] = []
    let content: Content
    
    init(selectionValue: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selectionValue
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0, content: {
            ZStack(alignment: .bottom) {
                content
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea()
                
                CustomTabBarView(tabs: tabs, selection: $selection)
            }
        })
        .onPreferenceChange(TabBarItemPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

#Preview {
    CustomTabBarContainerView(selectionValue: .constant(.home)) {
        Color.red
    }
}
