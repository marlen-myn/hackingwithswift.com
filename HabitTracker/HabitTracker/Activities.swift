//
//  Activities.swift
//  HabitTracker
//
//  Created by Marlen Mynzhassar on 25.11.2020.
//

import Foundation

class Activities: ObservableObject {
    @Published var activitites : [Activity] {
        didSet {
            if let encoded = try? JSONEncoder().encode(activitites) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "activities") {
            if let decodedData = try? JSONDecoder().decode([Activity].self, from: data) {
                activitites = decodedData
                return
            }
        }
        self.activitites = []
    }
    
    func deleteActivity(at offset: IndexSet) {
        activitites.remove(atOffsets: offset)
    }
    
    func addActivity(_ activity: Activity) {
        activitites.append(activity)
    }
}
