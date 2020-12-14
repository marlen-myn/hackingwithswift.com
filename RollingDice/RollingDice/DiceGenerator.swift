//
//  DiceGenerator.swift
//  RollingDice
//
//  Created by Marlen Mynzhassar on 14.12.2020.
//

import Foundation

class DiceGenerator: ObservableObject {
    @Published var dices = [Dice(sides: 6), Dice(sides: 6)]
    @Published private(set) var isGenerated = false
    static let sides = ["2","6","8","10","12","20","100"]
    
    func setDecies(count: Int, sides: Int) {
        dices = []
        for _ in 0..<count {
            dices.append(Dice(sides:sides))
        }
    }
    
    func rollTheDice() {
        isGenerated = false
        resetDiceValues()
        
        let group = DispatchGroup()
        for dice in dices {
            for delay in 0..<10 {
                group.enter()
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(delay)) {
                    dice.value = Int.random(in: 1...dice.sides)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.isGenerated = true
        }
    }
    
    func getDiceTotalValue() -> Int {
        var total = 0
        for dice in dices {
            total += dice.value
        }
        return total
    }
    
    private func resetDiceValues() {
        for dice in dices {
            dice.value = 0
        }
    }
}
