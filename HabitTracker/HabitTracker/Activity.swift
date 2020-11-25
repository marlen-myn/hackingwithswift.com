//
//  Activity.swift
//  HabitTracker
//
//  Created by Marlen Mynzhassar on 25.11.2020.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var completionCount: Int
    
    init(title:String, description: String, completionCount: Int = 0) {
        self.title = title
        self.description = description
        self.completionCount = completionCount
    }
}
