//
//  Mission.swift
//  Moonshot
//
//  Created by Marlen Mynzhassar on 22.11.2020.
//

import Foundation

struct Mission: Codable, Identifiable {
    static let allMissions: [Mission] = Bundle.main.decode("missions.json")
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id:Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var astronauts: [MissionView.CrewMember] {
        var matches = [MissionView.CrewMember]()
        let allAstronauts: [Astronaut] = Astronaut.allAustronauts
        for member in crew {
            if let match = allAstronauts.first(where: { $0.id == member.name }) {
                matches.append(MissionView.CrewMember(role: member.role, astronaut:match))
            }
        }
        return matches
    }
}
