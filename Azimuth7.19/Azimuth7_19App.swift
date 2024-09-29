//
//  Azimuth7_19App.swift
//  Azimuth7.19
//
//  Created by Joseph DeWeese on 9/29/24.
//

import SwiftUI
import SwiftData

@main
struct Azimuth7_19App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Objective.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ObjectiveListScreen()
        }
        .modelContainer(sharedModelContainer)
    }
}
