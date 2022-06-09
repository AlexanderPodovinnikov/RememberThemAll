//
//  PresentedPhoto.swift
//  RememberThemAll
//
//  Created by Alex Po on 07.06.2022.
//

import Foundation
import SwiftUI

struct PresentedPhoto {
    let name: String
    let image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    static let example = PresentedPhoto(name: "Richie Rich", image: UIImage(systemName: "person")!)
}
