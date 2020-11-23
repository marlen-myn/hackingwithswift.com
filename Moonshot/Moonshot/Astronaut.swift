//
//  Astronaut.swift
//  Moonshot
//
//  Created by Marlen Mynzhassar on 22.11.2020.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    
    static let allAustronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
}
