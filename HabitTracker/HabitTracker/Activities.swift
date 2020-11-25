//
//  Activities.swift
//  HabitTracker
//
//  Created by Marlen Mynzhassar on 25.11.2020.
//

import Foundation

class Activities: ObservableObject {
    @Published var items : [Activity] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "activities") {
            if let decodedData = try? JSONDecoder().decode([Activity].self, from: data) {
                items = decodedData
                return
            }
        }
        items = []
    }
    
    func deleteActivity(at offset: IndexSet) {
        items.remove(atOffsets: offset)
    }
    
    func addActivity(_ activity: Activity) {
        items.append(activity)
    }
}
