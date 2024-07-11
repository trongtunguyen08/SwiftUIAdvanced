//
//  TabBarItemPreferenceKey.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 3/7/24.
//

import Foundation
import SwiftUI

struct TabBarItemPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

struct TabBarItemViewModifier: ViewModifier {
    let tabItem: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tabItem ? 1.0 : 0.0)
            .preference(key: TabBarItemPreferenceKey.self, value: [tabItem])
    }
}

extension View {
    func asTabItem(selection: Binding<TabBarItem>, tab: TabBarItem) -> some View {
        self
            .modifier(TabBarItemViewModifier(tabItem: tab, selection: selection))
    }
}
