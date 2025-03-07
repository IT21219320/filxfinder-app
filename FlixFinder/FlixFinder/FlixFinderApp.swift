//
//  FlixFinderApp.swift
//  FlixFinder
//
//  Created by IM Student on 2025-03-07.
//

import SwiftUI
import SwiftData

@main
struct FlixFinderApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WatchList.self,
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
            TabView {
                WatchListView()
                    .tabItem {
                        Label("WatchList", systemImage: "bookmark")
                    }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
