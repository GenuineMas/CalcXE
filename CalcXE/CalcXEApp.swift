//
//  CalcXEApp.swift
//  CalcXE
//
//  Created by Genuine on 31.08.2021.
//

import SwiftUI

@available(iOS 16.0, *)
@main
struct CalcXEApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
                BarCodeView()
                    .tabItem {
                        Label("BarCode", systemImage: "barcode.viewfinder")
                    }
        
                CalcXEView()
                    .tabItem {
                        Label("XE", systemImage: "fork.knife")
                    }
            }
        }
    }
}
