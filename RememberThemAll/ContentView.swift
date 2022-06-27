//
//  ContentView.swift
//  RememberThemAll
//
//  Created by Alex Po on 31.05.2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var newImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var isShowingAddView = false
    @State private var searchText = ""
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    
    @State private var location: CLLocationCoordinate2D?
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationView {
            VStack {
                FilteredPeople(filter: searchText)
                    .searchable(text: $searchText)
                    .navigationTitle("Who Are Them All?")
            }
            
            .navigationBarItems(trailing:
                HStack {
                    Button {
                        sourceType = .photoLibrary
                        fetchLocation()
                        isShowingImagePicker.toggle()
                    } label: {
                        Image(systemName: "photo")
                    }
                    
                    Button {
                        sourceType = .camera
                        fetchLocation()
                        isShowingImagePicker.toggle()
                    } label: {
                        Image(systemName: "camera")
                    }
                }
            )
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePickerView(image: $newImage, sourceType: sourceType)
            }
            .sheet(isPresented: $isShowingAddView) {
                AddPhotoView(photo: newImage, location: location)
            }
            .onChange(of: newImage) { image in
                if image != nil {
                    isShowingAddView.toggle()
                }
            }
        }
    }
    
    func fetchLocation() {
        if let location = self.locationFetcher.lastKnownLocation {
            self.location = location
        } else {
            self.location = nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
