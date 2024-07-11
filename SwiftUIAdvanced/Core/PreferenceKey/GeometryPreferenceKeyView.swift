//
//  GeometryPreferenceKeyView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 3/7/24.
//

import SwiftUI

struct GeometryPreferenceKeyView: View {
    @State private var size: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("abc")
            
            Text("Hello!")
                .frame(width: size.width, height: size.height)
                .background(Color.blue)
            
            Spacer()
            
            HStack {
                Rectangle()
                
                GeometryReader(content: { geometry in
                    Rectangle()
                        .updateGemometrySize(geometry.size)
                })
                
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(GemometrySizePreferenceKey.self, perform: { value in
            self.size = value
        })
    }
}

extension View {
    func updateGemometrySize(_ size: CGSize) -> some View {
       preference(key: GemometrySizePreferenceKey.self, value: size)
    }
}

struct GemometrySizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#Preview {
    GeometryPreferenceKeyView()
}
