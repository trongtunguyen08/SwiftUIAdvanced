//
//  PrototolsView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 5/7/24.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    var primary: Color = .red
    var secondary: Color = .white
    var tertiary: Color = .green
}

struct AnotherTheme: ColorThemeProtocol {
    let primary: Color = .yellow
    let secondary: Color = .white
    let tertiary: Color = .red
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

struct PrototolsView: View {
    let colorTheme: ColorThemeProtocol
    
    var body: some View {
        ZStack {
            colorTheme.primary
                .ignoresSafeArea()
            
            VStack {
                Text("CLICK ME")
                    .foregroundStyle(colorTheme.secondary)
                    .padding()
                    .background(colorTheme.tertiary)
            }
        }
    }
}

#Preview {
    let theme: ColorThemeProtocol = DefaultColorTheme()
    return PrototolsView(colorTheme: theme)
}
