//
//  Resort.swift
//  SnowSeeker
//
//  Created by Marlen Mynzhassar on 15.12.2020.
//

import Foundation

struct Resort: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    static let allCountries = allResorts.map { $0.country }
    static let allSizes = allResorts.map { $0.size }

    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    var friendlySize: String {
        switch size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var friendlyPrice: String {
        String(repeating: "$", count: price)
    }
}
