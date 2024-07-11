//
//  View.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 1/7/24.
//

import Foundation
import SwiftUI

struct DefaultButtonModifier: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(Color.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct PressableButtonStyle: ButtonStyle {
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat = 0.9) {
        self.scaledAmount = scaledAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

extension View {
    func asDefaultButton(withBackgroundColor color: Color = .blue) -> some View {
        self
            .modifier(DefaultButtonModifier(color: color))
    }
    
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        self
            .buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}
