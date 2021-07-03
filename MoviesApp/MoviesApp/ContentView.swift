//
//  ContentView.swift
//  MoviesApp
//
//  Created by Taeeun Kim on 01.05.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            
            .onAppear {
                HTTPClient().getMoviesBy(search: "batman") { result in
                    switch result {
                    case .success(let movies):
                        print(movies)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
