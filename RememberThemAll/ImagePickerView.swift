//
//  ImagePickerView.swift
//  RememberThemAll
//
//  Created by Alex Po on 12.06.2022.
//  Mainly for using camera

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePickerView
        
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        // method required by the protocol
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            print("Got something")
            guard let selectedImage = info[.originalImage] as? UIImage else { return }
            self.parent.image = selectedImage
            print("It's an Image!")
        }
    }
    
    @Binding var image: UIImage?
    @State var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
               
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
                
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
     

    
}
