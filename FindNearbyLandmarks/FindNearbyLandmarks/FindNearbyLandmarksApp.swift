//
//  FindNearbyLandmarksApp.swift
//  FindNearbyLandmarks
//
//  Created by Taeeun Kim on 29.07.22.
//

import SwiftUI

@main
struct FindNearbyLandmarksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LocalSearchService())
        }
    }
}
