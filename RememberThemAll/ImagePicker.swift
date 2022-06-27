//
//  ImagePicker.swift
//  RememberThemAll
//
//  Created by Alex Po on 05.06.2022.
//  It will be needed when UIImagePickerController stops fetching photos from album

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // method required by the protocol
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    @Binding var image: UIImage?
       
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
                
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // we won't realy use it in this project
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
     
//    typealias UIViewControllerType = PHPickerViewController  // hack to generate code template
    
}
