//
//  ScrollviewPreferenceKeyView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 3/7/24.
//

import SwiftUI

struct ScrollviewPreferenceKeyView: View {
    @State private var scrollOffset: CGFloat = 0.0
    let title: String = "Navigation Title"
    
    var body: some View {
        ScrollView {
            titleLayer
                .opacity(Double(scrollOffset) / 75.0)
                .onScrollviewOffsetChange { offset in
                    self.scrollOffset = offset
                }
            
            contentLayer
        }
        .padding()
        .overlay(alignment: .top) {
            navBarHeader
                .opacity(scrollOffset < 37 ? 1.0 : 0.0)
        }
        .overlay {
            Text("\(scrollOffset)")
        }
    }
}

struct ScrollviewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func onScrollviewOffsetChange(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        background(
            GeometryReader(content: { geometry in
                Text("")
                    .preference(key: ScrollviewOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
            })
        )
        .onPreferenceChange(ScrollviewOffsetPreferenceKey.self, perform: { value in
            action(value)
        })
    }
}

extension ScrollviewPreferenceKeyView {
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(1..<100) { _ in
            Rectangle()
                .fill(Color.pink.opacity(0.5))
                .frame(maxWidth: .infinity)
                .frame(height: 200)
        }
    }
    
    private var navBarHeader: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
    }
}

#Preview {
    ScrollviewPreferenceKeyView()
}
