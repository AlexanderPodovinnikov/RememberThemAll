//
//  AddPhotoView.swift
//  RememberThemAll
//
//  Created by Alex Po on 31.05.2022.
//

import SwiftUI
import CoreData

struct AddPhotoView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    var photo: UIImage?
    
    struct PhotoView: View {
        var parent: AddPhotoView
        var body: some View {
            Group {
                Image(uiImage: parent.photo!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250) //TODO Size
                    .padding([.top, .bottom])
                Form {
                    TextField("Name", text: parent.$name)
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
    
    init(photo: UIImage?) {
        self.photo = photo
    }
    
    func save() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        
        let newPhoto = Photo(context: moc)
        let filename = UUID().uuidString
        newPhoto.name = name
        newPhoto.filename = filename
        
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
        AddPhotoView(photo: UIImage(systemName: "person"))
            .previewInterfaceOrientation(.portrait)
    }
}
