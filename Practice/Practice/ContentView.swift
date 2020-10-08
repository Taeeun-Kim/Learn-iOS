//
//  ContentView.swift
//  Practice
//
//  Created by Taeeun Kim on 08.10.20.
//  Copyright © 2020 Taeeun Kim. All rights reserved.
//

import SwiftUI

let age: Int = 10
let constant: String = "어쩔라미야"
var variable: String = "바꿔볼까?"

struct ContentView: View {
    var body: some View {
        Text("Hello, World! \(variable)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
