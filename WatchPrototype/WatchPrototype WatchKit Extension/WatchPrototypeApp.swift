//
//  WatchPrototypeApp.swift
//  WatchPrototype WatchKit Extension
//
//  Created by Taeeun Kim on 19.08.21.
//

import SwiftUI

@main
struct WatchPrototypeApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
