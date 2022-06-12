//
//  ContentView.swift
//  RememberThemAll
//
//  Created by Alex Po on 31.05.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State var newImage: UIImage?
    @State var isShowingImagePicker = false
    @State var isShowingAddView = false
    @State var searchText = ""
    @State var sourceType = UIImagePickerController.SourceType.photoLibrary
    
    var body: some View {
        NavigationView {
            VStack {
                FilteredPeople(filter: searchText)
                    .searchable(text: $searchText)
            }
            .navigationTitle("Who Are Them All?")
            .navigationBarItems(trailing:
                HStack {
                    Button {
                        sourceType = .camera
                        isShowingImagePicker.toggle()
                    } label: {
                        Image(systemName: "camera")
                    }
                    
                    Button {
                        sourceType = .photoLibrary
                        isShowingImagePicker.toggle()
                    } label: {
                        Image(systemName: "photo")
                    }
                }
            )
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePickerView(image: $newImage, sourceType: sourceType)
            }
            .sheet(isPresented: $isShowingAddView) {
                AddPhotoView(photo: newImage)
            }
            .onChange(of: newImage) { image in
                if image != nil {
                    isShowingAddView.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
