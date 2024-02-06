//
//  CalcXEApp.swift
//  CalcXE
//
//  Created by Genuine on 31.08.2021.
//

import SwiftUI

@available(iOS 15.0, *)
@main
struct CalcXEApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CalcXEView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
