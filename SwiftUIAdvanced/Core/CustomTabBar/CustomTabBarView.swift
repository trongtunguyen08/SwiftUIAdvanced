//
//  CustomTabBarView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 3/7/24.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var backgroundNamespace
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            switchToTab(tab)
                        }
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom).cornerRadius(10))
        .padding(.horizontal)
        .shadow(color: selection.color.opacity(0.1), radius: 10)
    }
}

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.icon)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10))
        }
        .foregroundStyle(selection == tab ? tab.color : Color.gray)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            if selection == tab {
                RoundedRectangle(cornerRadius: 10)
                    .fill(tab.color.opacity(0.2))
                    .matchedGeometryEffect(id: "background_id", in: backgroundNamespace)
            }
        }
        
    }
    
    private func switchToTab(_ tab: TabBarItem) {
        self.selection = tab
    }
}

#Preview {
    let tabs: [TabBarItem] = [.home, .favorite, .profile]
    return VStack {
        Spacer()
        CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!))
    }
}
