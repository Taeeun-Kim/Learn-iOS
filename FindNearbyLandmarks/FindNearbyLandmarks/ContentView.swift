//
//  ContentView.swift
//  FindNearbyLandmarks
//
//  Created by Taeeun Kim on 29.07.22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @EnvironmentObject var localSearchService: LocalSearchService
    @State private var search: String = ""
    // 25분
    var body: some View {
        VStack {
            TextField("Search", text: $search)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onSubmit {
                    localSearchService.search(query: search)
                }
            
            List(localSearchService.landmarks) { landmark in
                Text(landmark.name)
            }
            
            Map(coordinateRegion: $localSearchService.region)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocalSearchService())
    }
}
