//
//  ButtonStylesView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 1/7/24.
//

import SwiftUI

struct ButtonStylesView: View {
    var body: some View {
        VStack {
            Button(action: {}, label: {
                Text("Hello world")
                    .asDefaultButton(withBackgroundColor: .red)
            })
            .withPressableStyle()
        }
        .padding()
    }
}

#Preview {
    ButtonStylesView()
}
