//
//  FileManager-DataManager.swift
//  RememberThemAll
//
//  Created by Alex Po on 06.06.2022.
//

import Foundation
import SwiftUI

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct DataManager {
    
    static func load(from path: String) -> UIImage {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(path)
        if let image = try? UIImage(data: Data.init(contentsOf: savePath)) {
            return image
        } else {
            return UIImage(systemName: "person")!
        }
    }
    
    static func save(image: UIImage, to path: String) {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(path)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    static func erase(path: String) {
        let savePath = FileManager.documentsDirectory.appendingPathComponent(path, isDirectory: false)
        
        if FileManager.default.fileExists(atPath: savePath.path) {
            //print("Yes, I've got him!")
            do {
                try FileManager.default.removeItem(at: savePath)
            } catch {
                //print("Cannot delete file for some reason")
            }
        }
    }
}
