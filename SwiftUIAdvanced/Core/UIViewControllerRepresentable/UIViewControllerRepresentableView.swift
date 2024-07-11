//
//  UIViewControllerRepresentableView.swift
//  SwiftUIAdvanced
//
//  Created by Tu Nguyen on 4/7/24.
//

import SwiftUI

struct UIViewControllerRepresentableView: View {
    @State private var showSecondView: Bool = false
    @State private var image: UIImage?
    
    var body: some View {
        VStack {
            Button("CLICK HERE") {
                self.showSecondView.toggle()
            }
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 100)
            }
        }
        .sheet(isPresented: $showSecondView, content: {
            UIImagePickerControllerRepresentable(image: $image)
                .ignoresSafeArea()
        })
    }
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image: UIImage?
        
        init(image: Binding<UIImage?>) {
            self._image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let returnedImage = info[.originalImage] as? UIImage else { return }
            image = returnedImage
            picker.dismiss(animated: true)
        }
    }
}

struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    let text: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MyFirstViewController()
        vc.text = text
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class MyFirstViewController: UIViewController {
    var text: String = "Starting Value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let label = UILabel()
        label.text = text
        label.textColor = .white
        
        view.addSubview(label)
        
        label.frame = view.frame
    }
}

#Preview {
    UIViewControllerRepresentableView()
}
