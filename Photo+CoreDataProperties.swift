//
//  Photo+CoreDataProperties.swift
//  RememberThemAll
//
//  Created by Alex Po on 31.05.2022.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var name: String?
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    
    
    @NSManaged public var filename: String?
    public var wrappedFilename: String {
        filename ?? "Unknown file name"
    }

}

extension Photo : Identifiable {

}
