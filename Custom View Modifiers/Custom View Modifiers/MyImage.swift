//
//  MyImage.swift
//  Custom View Modifiers
//
//  Created by Stewart Lynch on 2020-12-27.
//

import Foundation

struct MyImage: Identifiable {
    let id = UUID()
    let name: String
    let caption: String
    
    static var images:[MyImage] {
        [
            MyImage(name: "Lahaina", caption: "Marina Sunset"),
            MyImage(name: "Makena", caption: "Surf's up"),
            MyImage(name: "Snail", caption: "Creepy Crawler")
        ]
    }
}
