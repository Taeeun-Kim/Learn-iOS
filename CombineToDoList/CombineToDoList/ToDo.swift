//
//  ToDo.swift
//  CombineToDoList
//
//  Created by Taeeun Kim on 07.11.21.
//

import Foundation

struct ToDo: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var completed: Bool = false
    
    static var sampleData: [ToDo] {
        [
            ToDo(name: "Taeeun works"),
            ToDo(name: "Taeeun studies", completed: true)
        ]
    }
}
