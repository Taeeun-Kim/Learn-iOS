//
//  Landmark.swift
//  FindNearbyLandmarks
//
//  Created by Taeeun Kim on 30.07.22.
//

import Foundation
import MapKit

struct Landmark: Identifiable, Hashable {
    
    let placemark: MKPlacemark
    
    let id = UUID()
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
