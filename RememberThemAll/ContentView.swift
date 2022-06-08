//
//  ContentView.swift
//  RememberThemAll
//
//  Created by Alex Po on 31.05.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)], predicate: nil) var people: FetchedResults<Photo>
    
    @State var newImage: UIImage?
    @State var isShowingImagePicker = false
    @State var isShowingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                if people.count == 0 {
                    Text("Your list is empty")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(people, id:\.name) {photo in
                        NavigationLink {
                            DetailView(currentPhoto: PresentedPhoto(name: photo.wrappedName, image: DataManager.load(from: photo.wrappedFilename)))
                        } label: {
                            HStack {
                                Image(uiImage: DataManager.load(from: photo.wrappedFilename))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .background(Color(hue: 0.7,saturation: 0.1,brightness: 1))
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                Text(photo.wrappedName)
                            }
                        }
                    }
                    .onDelete(perform: deletePhotos)
                }
            }
            .navigationTitle("Who Are Them All?")
            .navigationBarItems(trailing:
                HStack {
//                    Button {
//                        // isShowingSortOptions.toggle()
//                    } label: {
//                        Image(systemName: "arrow.up.arrow.down")
//                    }
                    Button {
                        isShowingImagePicker.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            )
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $newImage)
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
    
    func deletePhotos(at offsets: IndexSet) {
        for offset in offsets {
            let photo = people[offset]
            moc.delete(photo)
            
            // how to remove image file?
            
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
