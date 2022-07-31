//
//  LandmarkListView.swift
//  FindNearbyLandmarks
//
//  Created by Taeeun Kim on 31.07.22.
//

import SwiftUI

struct LandmarkListView: View {
    
    @EnvironmentObject var localSearchService: LocalSearchService

    var body: some View {
        VStack {
            List(localSearchService.landmarks) { landmark in
                VStack(alignment: .leading) {
                    Text(landmark.name)
                    Text(landmark.title)
                        .opacity(0.5)
                }
            }
        }
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView()
            .environmentObject(LocalSearchService())
    }
}
