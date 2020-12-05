//
//  Person.swift
//  NameMemorizer
//
//  Created by Marlen Mynzhassar on 05.12.2020.
//

import Foundation
import MapKit

struct Person: Comparable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var photoId: UUID
    var latitude: Double?
    var longitude: Double?

    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    var wrappedlatitude: Double {
        get {
            latitude ?? 0
        }
    }
    
    var wrappedlongitude: Double {
        get {
            longitude ?? 0
        }
    }
    
    var placeCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: wrappedlatitude, longitude: wrappedlongitude)
    }
    
}
