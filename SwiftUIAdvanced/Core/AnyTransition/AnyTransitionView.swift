//
//  AnyTransitionView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 1/7/24.
//

import SwiftUI

struct AnyTransitionView: View {
    @State private var showShape: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if showShape {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    //.transition(.rotating(rotation: 180))
                    .transition(.rotateOn)
            }
            
            Spacer()
            
            Text("Click Me")
                .asDefaultButton()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.showShape.toggle()
                    }
                }
        }
        .padding()
    }
}

#Preview {
    AnyTransitionView()
}
