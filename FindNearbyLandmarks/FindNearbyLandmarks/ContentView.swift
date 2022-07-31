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
            
            LandmarkListView()
            
            Map(coordinateRegion: $localSearchService.region, showsUserLocation: true, annotationItems: localSearchService.landmarks) { landmark in
                MapAnnotation(coordinate: landmark.coordinate) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            
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
