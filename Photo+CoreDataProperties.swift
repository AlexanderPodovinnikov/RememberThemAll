//
//  Photo+CoreDataProperties.swift
//  RememberThemAll
//
//  Created by Alex Po on 11.06.2022.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var filename: String?
    public var wrappedFilename: String {
        filename ?? "epicfail"
    }
    
    @NSManaged public var name: String?
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension Photo : Identifiable {

}
