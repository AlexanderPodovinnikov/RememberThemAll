//
//  ContentView.swift
//  RememberThemAll
//
//  Created by Alex Po on 31.05.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)], predicate: nil) var people: FetchedResults<Photo>
    
    @State var newImage: UIImage?
    @State var isShowingImagePicker = false
    @State var isShowingAddView = false
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                FilteredPeople(filter: searchText)
                    .searchable(text: $searchText)
            }
            .navigationTitle("Who Are Them All?")
            .navigationBarItems(trailing:
                HStack {
//                    Image(systemName: "magnifyingglass")
//                    TextField("Search for...", text: $searchText)
                    
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
    
//    func deletePhotos(at offsets: IndexSet) {
//        for offset in offsets {
//            let photo = people[offset]
//            moc.delete(photo)
//
//            // how to remove image file?
//
//            if moc.hasChanges {
//                try? moc.save()
//            }
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
