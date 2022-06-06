//
//  RememberThemAllApp.swift
//  RememberThemAll
//
//  Created by Alex Po on 31.05.2022.
//

import SwiftUI

@main
struct RememberThemAllApp: App {
    @StateObject private var dataController = DataController()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
