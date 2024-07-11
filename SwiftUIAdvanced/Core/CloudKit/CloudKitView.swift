 //
//  CloudKitView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 10/7/24.
//

import SwiftUI

struct CloudKitView: View {
    @StateObject private var vm = CloudKitViewModel()
    
    var body: some View {
        cloudKitLayer
    }
}

extension CloudKitView {
    private var cloudKitLayer: some View {
        VStack {
            headerLayer
            
            textFieldLayer
            
            addButton
            
            List(vm.fruits, id: \.self) { fruit in
                Text(fruit)
            }
            .listStyle(.plain)
        }
        .padding()
        .toolbar(.hidden)
    }
    
    private var headerLayer: some View {
        Text("CloudKit")
            .font(.headline)
    }
    
    private var textFieldLayer: some View {
        TextField("Add something herer", text: $vm.text)
            .padding()
            .frame(height: 55)
            .background(
                Color.gray.opacity(0.3)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
    
    private var addButton: some View {
        Button(action: {
            vm.addButtonPressed()
        }, label: {
            Text("ADD")
                .foregroundStyle(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(
                    Color.red
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                )
            
        })
    }
}

#Preview {
    CloudKitView()
}
