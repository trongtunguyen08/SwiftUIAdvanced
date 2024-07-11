//
//  PreferenceKeyView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 3/7/24.
//

import SwiftUI

struct PreferenceKeyView: View {
    @State private var text: String = "Title here!!!!"
    
    var body: some View {
        NavigationView {
            SecondaryView(text: text)
                .navigationTitle("Navigation Title")
        }
        .onPreferenceChange(CustomValuePreferenceKey.self, perform: { value in
            self.text = value
        })
    }
    
   
}

extension View {
    func customValue(text: String) -> some View {
        self
            .preference(key: CustomValuePreferenceKey.self, value: text)
    }
}

struct CustomValuePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct SecondaryView: View {
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        VStack {
            Text(text)
                .onAppear(perform: getData)
                .customValue(text: newValue)
               
        }
    }
    
    private func getData() {
        // Download data
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "NEW VALUE"
        }
    }
}

#Preview {
    PreferenceKeyView()
}
