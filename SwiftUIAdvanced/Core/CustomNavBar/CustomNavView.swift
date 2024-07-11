//
//  CustomNavView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 4/7/24.
//

import SwiftUI

struct CustomNavView<Content:View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView(content: {
            CustomNavBarContainerView {
                content
            }
        })
        .navigationBarBackButtonHidden()
        .navigationViewStyle(.stack)
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

#Preview {
    CustomNavView {
        Text("ABC")
            .customNavBarItems(title: "Title", subtitle: "Subtitle here!")
    }
}
