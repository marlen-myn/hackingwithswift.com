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
    var completionCount = 0
}
