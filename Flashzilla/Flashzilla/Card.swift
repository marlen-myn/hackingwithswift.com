//
//  Card.swift
//  Flashzilla
//
//  Created by Marlen Mynzhassar on 10.12.2020.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
