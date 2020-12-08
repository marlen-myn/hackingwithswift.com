//
//  Prospect.swift
//  HotProspects
//
//  Created by Marlen Mynzhassar on 07.12.2020.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate (set) var isConnected = false
    var addedTime = Date()
}

class Prospects: ObservableObject {
    @Published fileprivate (set) var people: [Prospect]
    static let saveKey = "SavedData"
    
    init() {
        let filename = FileManager.getDataURL(filename: Self.saveKey)
        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
            return
        } catch {
            print(error.localizedDescription)
        }
        people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            try? FileManager.saveData(encoded, filename: Self.saveKey)
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
    
    func delete(at indexOffset: IndexSet) {
        people.remove(atOffsets: indexOffset)
        save()
    }

}
