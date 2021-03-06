//
//  filteredPeople.swift
//  RememberThemAll
//
//  Created by Alex Po on 08.06.2022.
//

import SwiftUI
import CoreData

struct FilteredPeople: View {
    @FetchRequest var fetchRequest: FetchedResults<Photo>
    @Environment(\.managedObjectContext) var moc
    
    init(filter: String) {
        if filter.isEmpty {
            _fetchRequest = FetchRequest<Photo>(sortDescriptors: [SortDescriptor(\.name)], predicate: nil)
        } else {
            _fetchRequest = FetchRequest<Photo>(sortDescriptors: [SortDescriptor(\.name)], predicate: NSPredicate(format: "name CONTAINS[c] %@", filter))
        }
    }
    
    var body: some View {
        List {
            if fetchRequest.count == 0 {
                Text("Nothing was found")
                    .foregroundColor(.secondary)
            } else {
                ForEach(fetchRequest, id:\.name) {photo in
                    let curentImage = DataManager.load(from: photo.wrappedFilename)
                    NavigationLink {
                        DetailView(currentPhoto: PresentedPhoto(name: photo.wrappedName, image: curentImage))
                    } label: {
                        HStack {
                            Image(uiImage: curentImage)
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
    }
    func deletePhotos(at offsets: IndexSet) {
        
        for offset in offsets {
            let photo = fetchRequest[offset]
            DataManager.erase(path: photo.wrappedFilename)
            moc.delete(photo)
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

struct filteredPeople_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        FilteredPeople(filter: "")
    }
}
