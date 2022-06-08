//
//  DataController.swift
//  RememberThemAll
//
//  Created by Alex Po on 31.05.2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "PhotoBank")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            // merge policy for duplicates - duplicates are nearly impossible
            //self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
