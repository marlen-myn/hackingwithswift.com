//
//  Prospect.swift
//  HotProspects
//
//  Created by Marlen Mynzhassar on 07.12.2020.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate (set) var isConnected = false
}


class Prospects: ObservableObject {
    @Published fileprivate (set) var people: [Prospect]
    static let saveKey = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                people = decoded
                return
            }
        }
        people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            UserDefaults.standard.setValue(encoded, forKey: Self.saveKey)
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toogle(_ prospect: Prospect) {
        prospect.isConnected.toggle()
        objectWillChange.send()
        save()
    }
}
