//
//  AddPhotoView.swift
//  RememberThemAll
//
//  Created by Alex Po on 31.05.2022.
//

import SwiftUI
import CoreData
import CoreLocation
import MapKit

struct AddPhotoView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var usingLocation = true
    
    let photo: UIImage?
    let location: CLLocationCoordinate2D?
    
    struct PhotoView: View {
        var parent: AddPhotoView
        var body: some View {
            Group {
                VStack {
                    Image(uiImage: parent.photo!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200) //TODO Size
                        .padding([.top, .bottom])
                    Form {
                        Section {
                            TextField("Name", text: parent.$name)
                        }
                        Section {
                            Toggle("Save location", isOn: parent.$usingLocation)
                            
                        }
                    }
                }
                    if parent.usingLocation && parent.location != nil {
                        HStack {
                            Spacer()
                            MapView(location: parent.location!)
                                .foregroundColor(.gray)
                                .frame(width: 250, height: 250)
                            Spacer()
                        }
//                    } else {
//                        HStack {
//                            Spacer()
//                            Rectangle()
//                                .foregroundColor(.gray)
//                                .frame(width: 250, height: 250)
//                            Spacer()
//                        }
                    }
               
            }
        }
        init(_ parent: AddPhotoView) {
            self.parent = parent
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                if geo.size.height > geo.size.width {
                    VStack {
                        PhotoView(self)
                    }
                } else {
                    HStack {
                        PhotoView(self)
                    }
                }
    
                Button("Save") {
                    save()
                }
                .padding()
            }
        }
    }

    func save() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        
        let newPhoto = Photo(context: moc)
        let filename = UUID().uuidString
        newPhoto.name = name
        newPhoto.filename = filename
        if usingLocation {
            if let newLocation = location {
                newPhoto.latitude = newLocation.latitude
                newPhoto.longitude = newLocation.longitude
            }
        }
        
        if moc.hasChanges {
            try? moc.save()
        }
        
        if let photo = photo {
            DataManager.save(image: photo, to: filename)
        }
        dismiss()
    }
}

struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        
            AddPhotoView(photo: UIImage(systemName: "person"), location: nil)
            .previewInterfaceOrientation(.portrait)
            
      
    }
}
