//
//  UITestingView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 8/7/24.
//

import SwiftUI

class UITestingViewModel: ObservableObject {
    let placehokderText: String = "Type here..."
    @Published var textFieldValue: String = ""
    @Published var currentUserIsSignedIn: Bool = false
    
    func signUpButtonPress() {
        guard !textFieldValue.isEmpty else { return }
        self.currentUserIsSignedIn = true
    }
}

struct UITestingView: View {
    @StateObject private var vm = UITestingViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
                .ignoresSafeArea()
            
            ZStack {
                if vm.currentUserIsSignedIn {
                    SignInView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                }
                
                if !vm.currentUserIsSignedIn {
                    signUpLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

extension UITestingView {
    private var signUpLayer: some View {
        VStack {
            TextField(vm.placehokderText, text: $vm.textFieldValue)
                .font(.headline)
                .padding()
                .background(
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                )
                .accessibilityIdentifier("SignUpTextField")
            
            Button(action: {
                withAnimation(.spring()) {
                    vm.signUpButtonPress()
                }
            }, label: {
                Text("Sign Up")
                    .padding()
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .background(
                        Color.blue
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    )
            })
            .accessibilityIdentifier("SignUpButton")
        }
        .padding()
    }
}

#Preview {
    UITestingView()
}
