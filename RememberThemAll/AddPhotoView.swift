//
//  AddPhotoView.swift
//  RememberThemAll
//
//  Created by Alex Po on 31.05.2022.
//

import SwiftUI

struct AddPhotoView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    var photo: UIImage?
    
    var body: some View {
        
        VStack {
            Image(uiImage: photo!)
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
                .padding([.top, .bottom])
            Form {
                TextField("Name", text: $name)
            }
            
            Button("Save") {
                save()
            }
            .padding()
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
        try? moc.save()
        if let photo = photo {
            DataManager.save(image: photo, to: filename)
        }
        dismiss()
    }
}

struct AddPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        AddPhotoView(photo: UIImage(systemName: "person"))
    }
}
