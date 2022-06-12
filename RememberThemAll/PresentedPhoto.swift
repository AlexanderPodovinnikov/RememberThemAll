//
//  PresentedPhoto.swift
//  RememberThemAll
//
//  Created by Alex Po on 07.06.2022.
//

import Foundation
import SwiftUI
import CoreLocation

struct PresentedPhoto {
    let name: String
    let image: UIImage
    let location: CLLocationCoordinate2D?
    
    init(name: String, image: UIImage, location: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.image = image
        
        if location != nil && CLLocationCoordinate2DIsValid(location!) {
            self.location = location
        } else {
            self.location = nil
        }
    }
    
    init(name: String, image: UIImage, latitude: Double, longitude: Double) {
        self.name = name
        self.image = image
        if CLLocationCoordinate2DIsValid(CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
            self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.location = nil
        }
    }
    
    static let example = PresentedPhoto(name: "Richie Rich", image: UIImage(systemName: "person")!)
}
