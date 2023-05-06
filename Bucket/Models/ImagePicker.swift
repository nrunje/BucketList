//
//  ImagePicker.swift
//  Bucket
//
//  Created by Nicholas Runje on 5/5/23.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var selectedImage: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isPresented: $isPresented, selectedImage: $selectedImage)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var isPresented: Bool
        @Binding var selectedImage: String
        
        init(isPresented: Binding<Bool>, selectedImage: Binding<String>) {
            _isPresented = isPresented
            _selectedImage = selectedImage
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
                let imageData = uiImage.jpegData(compressionQuality: 0.5) { // Adjust the compression quality (0.5 in this case)
                    let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
                    selectedImage = "data:image/jpeg;base64," + base64String
            }
            isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isPresented = false
        }
    }
}


