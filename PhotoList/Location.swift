//
//  Location.swift
//  BucketList
//
//  Created by Gustavo Verdugo on 25/08/2022.
//

import Foundation
import CoreLocation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    let id : UUID
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        get {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }
    
    init? (coordinates: CLLocationCoordinate2D?) {
        guard let coordinates = coordinates else {
            return nil
        }
        id = UUID()
        latitude = coordinates.latitude
        longitude = coordinates.longitude
    }
    
    init(latitude: Double, longitude: Double) {
        id = UUID()
        self.latitude = latitude
        self.longitude = longitude
    }
    
    static let example = Location(latitude: 51.501, longitude: -0.141)

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

