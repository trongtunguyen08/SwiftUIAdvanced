//
//  CustomShapesView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 1/7/24.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct CustomShapesView: View {
    var body: some View {
        VStack {
            ScrollView {
                Triangle()
                    .stroke(.red, style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [5]))
                    .fill(
                        LinearGradient(colors: [.black, .blue, .yellow], startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: 300, height: 300)
            }
        }
        .padding()
    }
}

#Preview {
    CustomShapesView()
}
