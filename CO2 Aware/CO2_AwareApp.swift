//
//  CO2_AwareApp.swift
//  CO2 Aware
//
//  Created by 王首之 on 9/16/22.
//

import SwiftUI

@main
struct CO2_AwareApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
