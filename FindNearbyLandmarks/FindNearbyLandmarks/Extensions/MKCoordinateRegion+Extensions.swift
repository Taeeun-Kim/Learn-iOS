//
//  MKCoordinateRegion+Extensions.swift
//  FindNearbyLandmarks
//
//  Created by Taeeun Kim on 30.07.22.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.532600, longitude: 127.024612), span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
    }
    
    static func regionFromLandmark(_ landmark: Landmark) -> MKCoordinateRegion {
        MKCoordinateRegion(center: landmark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
    }
}
