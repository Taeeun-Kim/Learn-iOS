//
//  LocalSearchService.swift
//  FindNearbyLandmarks
//
//  Created by Taeeun Kim on 30.07.22.
//

import Foundation
import MapKit
import Combine

class LocalSearchService: ObservableObject {
    
    @Published var landmarks: [Landmark] = []
    @Published var landmark: Landmark?
    @Published var region = MKCoordinateRegion.defaultRegion()
    
    let locationManager = LocationManager()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        locationManager.$region
            .assign(to: \.region, on: self)
            .store(in: &cancellables)
    }
    
    func search(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = locationManager.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
            }
        }
    }
}
