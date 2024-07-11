//
//  ViewModifiersView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 1/7/24.
//

import SwiftUI

struct ViewModifiersView: View {
    var body: some View {
        VStack {
            Text("Hello world")
                .asDefaultButton(withBackgroundColor: .red)
            
            Text("Hello world")
                .asDefaultButton()
        }
        .padding()
    }
}

#Preview {
    ViewModifiersView()
}
