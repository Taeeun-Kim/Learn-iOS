//
//  CombineToDoListApp.swift
//  CombineToDoList
//
//  Created by Taeeun Kim on 07.11.21.
//

import SwiftUI

@main
struct CombineToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStore())
        }
    }
}
