//
//  User.swift
//  FriendsCircle
//
//  Created by Marlen Mynzhassar on 30.11.2020.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    var friendlyDateRegistered: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: registered)
    }
    
    var friendlyUserTags: String {
        var tagsToReturn = ""
        
        for tag in tags {
            tagsToReturn += "\(tag) "
        }
        return tagsToReturn
    }
    
}
