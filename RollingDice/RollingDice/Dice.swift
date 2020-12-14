//
//  Dice.swift
//  RollingDice
//
//  Created by Marlen Mynzhassar on 14.12.2020.
//

import Foundation

class Dice: ObservableObject, Identifiable {
    let id = UUID()
    let sides: Int
    @Published var value: Int = 0
    
    init(sides:Int) {
        self.sides = sides
    }
    
}
