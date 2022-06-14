//
//  ContentView.swift
//  TestDeinit
//
//  Created by Taeeun Kim on 03.05.22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationLink(destination: NewView(viewModel: NewViewModel())) {
            Text("Go to NewView")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
