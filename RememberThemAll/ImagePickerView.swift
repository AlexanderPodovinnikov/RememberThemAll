//
//  ImagePickerView.swift
//  RememberThemAll
//
//  Created by Alex Po on 12.06.2022.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePickerView
        
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        // method required by the protocol
        func picker(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.parent.image = image
            self.parent.isPresented.wrappedValue.dismiss()
        }
    }
    
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    @Environment(\.presentationMode) var isPresented
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
               
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
                
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
     

    
}
