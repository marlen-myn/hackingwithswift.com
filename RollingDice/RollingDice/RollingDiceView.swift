//
//  RollingDiceView.swift
//  RollingDice
//
//  Created by Marlen Mynzhassar on 14.12.2020.
//

import SwiftUI
import CoreHaptics

struct RollingDiceView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var numberOfDice = 2
    @State private var sidesOfDiceIndex = 1
    @State private var result = 0
    @State private var showSettings = false
    @State private var engine: CHHapticEngine?
    @State private var rotationDegree: Double = 0.0
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
                        .font(.largeTitle)
                        .onReceive(diceGenerator.$isGenerated) { value in
                            if value {
                                saveResult()
                                diceRolledFinished()
                                rotationDegree = 0
                            }
                        }
                    
                    LazyVGrid(columns: layout, spacing:20) {
                        ForEach(diceGenerator.dices) { dice in
                            DiceView(dice: dice)
                                .rotation3DEffect(diceGenerator.isGenerated ? .degrees(0) : .degrees(rotationDegree), axis: (x: 0, y: 0, z: 1))
                                .animation(!diceGenerator.isGenerated ? Animation.easeOut(duration: 7) : nil)
                        }
                    }
                    .frame(width: geo.size.width/1.5)
                    .padding(.horizontal)
                    .onAppear(perform: prepareHaptics)
                    
                    Spacer()
                    
                    Button(action: {
                        result = 0
                        rotationDegree += 3600
                        diceGenerator.rollTheDice()
                        diceRolled()
                    }) {
                        Image(systemName: "die.face.4")
                            .font(.largeTitle)
                        Text("Roll Dices")
                    }
                    .disabled(!diceGenerator.isGenerated)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(diceGenerator.isGenerated ? Color.blue : Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .shadow(radius:6)
                    .animation(.default)
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
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func diceRolledFinished() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func diceRolled() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
}

struct RollingDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollingDiceView()
    }
}
