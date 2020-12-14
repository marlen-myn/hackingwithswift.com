//
//  Settings.swift
//  RollingDice
//
//  Created by Marlen Mynzhassar on 14.12.2020.
//

import SwiftUI

struct Settings: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var numberOfDice: Int
    @Binding var sidesOfDiceIndex: Int
    let sides = DiceGenerator.sides
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Stepper("Number of dices: \(numberOfDice)", value: $numberOfDice, in: 1...4)
                }
                Section {
                    Picker(selection: $sidesOfDiceIndex, label: Text("Number of sides:")) {
                        ForEach(0..<sides.count) {
                            Text("\(sides[$0])")
                        }
                    }
                }
            }
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(numberOfDice: .constant(2), sidesOfDiceIndex: .constant(6))
    }
}
