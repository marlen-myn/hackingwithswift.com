//
//  CardObservable.swift
//  Flashzilla
//
//  Created by Marlen Mynzhassar on 11.12.2020.
//

import Foundation

class CardObservable: ObservableObject {
    @Published var cards = [Card]()
}
