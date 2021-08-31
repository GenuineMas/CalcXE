//
//  CalcXEApp.swift
//  CalcXE
//
//  Created by Genuine on 31.08.2021.
//

import SwiftUI

@main
struct CalcXEApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
