//
//  RollingDiceView.swift
//  RollingDice
//
//  Created by Marlen Mynzhassar on 14.12.2020.
//

import SwiftUI

struct RollingDiceView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var numberOfDice = 2
    @State private var sidesOfDiceIndex = 1
    @State private var result = 0
    @State private var showSettings = false
    @ObservedObject var diceGenerator = DiceGenerator()
    let sides = DiceGenerator.sides
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    HStack {
                        Text("number of dices: \(numberOfDice)")
                        Spacer()
                        Text("sides: \(sides[sidesOfDiceIndex])")
                    }
                    Spacer()
                    
                    Text("Total: \(result)")
                        .onReceive(diceGenerator.$isGenerated) { value in
                            if value {
                                saveResult()
                            }
                        }
                    LazyVGrid(columns: layout, spacing:20) {
                        ForEach(diceGenerator.dices) { dice in
                            DiceView(dice: dice)
                        }
                    }
                    .frame(width: geo.size.width/1.5)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {
                        result = 0
                        diceGenerator.rollTheDice()
                    }) {
                        Image(systemName: "die.face.4")
                            .font(.largeTitle)
                        Text("Roll Dices")
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .shadow(radius:6)
                }
                .padding()
                .sheet(isPresented: $showSettings, onDismiss: setDices) {
                    Settings(numberOfDice: $numberOfDice, sidesOfDiceIndex: $sidesOfDiceIndex)
                }
                .navigationBarTitle("Rolling Dice", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    showSettings = true
                }) {
                    Image(systemName: "gearshape")
                })
            }
        }
    }
    
    var rollSides: Int {
        Int(sides[sidesOfDiceIndex])!
    }
    
    func setDices() {
        diceGenerator.setDecies(count:numberOfDice, sides: rollSides)
    }
    
    func saveResult() {
        result = diceGenerator.getDiceTotalValue()
        guard result > 0 else { return }
        let rollResult = Roll(context: self.moc)
        rollResult.id = UUID()
        rollResult.date = Date()
        rollResult.rollquantity = Int16(numberOfDice)
        rollResult.sides = Int16(rollSides)
        rollResult.total = Int16(result)
        
        try? self.moc.save()
    }
    
}

struct RollingDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollingDiceView()
    }
}
