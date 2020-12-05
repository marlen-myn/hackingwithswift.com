//
//  Person.swift
//  NameMemorizer
//
//  Created by Marlen Mynzhassar on 05.12.2020.
//

import Foundation

struct Person: Comparable, Codable, Identifiable {
    var id = UUID()
    var name: String
    var photoId: UUID

    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
