//
//  ContentView.swift
//  LazyVGrid
//
//  Created by Taeeun Kim on 23.06.21.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    
    let colors: [Color]
    let columns: [GridItem] = [GridItem(), GridItem()]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(1..<100) { index in
                    colors[index % colors.count]
                        .overlay(
                            Text("\(index)")
                        )
                        .frame(height: 100)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(colors: [.red, .blue, .orange, .yellow])
    }
}
