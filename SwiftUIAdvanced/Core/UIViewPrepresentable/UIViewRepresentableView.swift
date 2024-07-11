//
//  UIViewRepresentableView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 4/7/24.
//

import SwiftUI

struct UIViewRepresentableView: View {
    @State private var text: String = ""
    
    var body: some View {
        Text(text)
        
        GroupBox {
            Text("SwiftUI")
            TextField("Type here...", text: $text)
        }
        
        GroupBox {
            Text("UIKit")
            UITextFieldRepresentable(text: $text, placeholder: "Placeholder...", placeholderColor: UIColor.red)
                .padding(.horizontal)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
        }
    }
}

struct UITextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String = "Default placeholder...", placeholderColor: UIColor = UIColor.red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField =  getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        
        let placeholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor: placeholderColor
        ])
        
        textField.attributedPlaceholder = placeholder
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

#Preview {
    UIViewRepresentableView()
}
