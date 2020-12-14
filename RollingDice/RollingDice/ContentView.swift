//
//  ContentView.swift
//  RollingDice
//
//  Created by Marlen Mynzhassar on 14.12.2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        TabView {
            RollingDiceView()
                .tabItem {
                    Image(systemName: "die.face.5")
                    Text("Roll Dice")
                }
            ResultsView()
                .tabItem {
                    Image(systemName: "equal.square")
                    Text("Results")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
