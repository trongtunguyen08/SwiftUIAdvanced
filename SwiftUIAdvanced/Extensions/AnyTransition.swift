//
//  AnyTransition.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 1/7/24.
//

import Foundation
import SwiftUI

struct RotateViewModifier: ViewModifier {
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0
            )
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        return AnyTransition
            .modifier(active: RotateViewModifier(rotation: 180), identity: RotateViewModifier(rotation: 0))
    }
    
    static func rotating(rotation: Double) -> AnyTransition {
        return AnyTransition
            .modifier(active: RotateViewModifier(rotation: rotation), identity: RotateViewModifier(rotation: 0))
    }
    
    static var rotateOn: AnyTransition {
        return AnyTransition
            .asymmetric(insertion: rotating, removal: .move(edge: .leading))
    }
}
