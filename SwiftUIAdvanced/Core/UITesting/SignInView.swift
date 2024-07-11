//
//  SignInView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 8/7/24.
//

import SwiftUI

struct SignInView: View {
    @State private var showAlertMessage: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Label("Show alert message!", systemImage: "bell")
                    .padding()
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .background(
                        Color.red
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    )
                    .onTapGesture {
                        self.showAlertMessage.toggle()
                    }
                    .alert("Welcome to the App", isPresented: $showAlertMessage) {
                        Button("OK") {
                            self.showAlertMessage = false
                        }
                    }
                    .accessibilityIdentifier("AlertButton")
                
                NavigationLink("Navigate") {
                    Text("Destination")
                }
                .padding()
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.white)
                .background(
                    Color.blue
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                )
                .accessibilityIdentifier("NavigationLinkToDestination")
            }
            .padding()
            .navigationTitle("Welcome!")
        }
    }
}

#Preview {
    SignInView()
}
