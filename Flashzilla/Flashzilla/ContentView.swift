//
//  ContentView.swift
//  Flashzilla
//
//  Created by Marlen Mynzhassar on 08.12.2020.
//

import SwiftUI
import CoreHaptics

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width:0, height: offset * 10))
    }
}

enum ActiveSheet {
    case Edit, Settings
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    //@State private var cards = [Card]()
    @ObservedObject var cardHolder = CardObservable()
    
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet?
    
    @State private var timeRemaining = TIME_REMAINING
    @State private var isActive = true
    @State private var engine: CHHapticEngine?
    @State private var tryAgainOption = false
    
    static var TIME_REMAINING = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func resetCards() {
        timeRemaining = Self.TIME_REMAINING
        isActive = true
        loadData()
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
    
    func timeFinished() {
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
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                /* Timer */
                Group {
                    if timeRemaining > 0 {
                        Text("Time: \(timeRemaining)")
                    } else {
                        Text("You are run out of time")
                            .onAppear(perform: timeFinished)
                    }
                }
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(Color.black)
                        .opacity(0.75)
                )
                
                /* Stack of cards */
                ZStack {
                    ForEach(cardHolder.cards.indices, id: \.self) { index in
                        CardView(card: cardHolder.cards[index], delaying: {
                            withAnimation {
                                putCardBack(index:index)
                            }
                        }) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cardHolder.cards.count)
                        //.allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < cardHolder.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                /* Button to reset when stack is empty */
                if cardHolder.cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            /* Add card button */
            VStack {
                HStack {
                    Button(action: {
                        activeSheet = ActiveSheet.Settings
                        showSheet = true
                    }) {
                        Image(systemName: "wrench")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        activeSheet = ActiveSheet.Edit
                        showSheet = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            /* Accessibility mode */
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                if tryAgainOption {
                                    self.putCardBack(index: cardHolder.cards.count - 1)
                                } else {
                                    self.removeCard(at: cardHolder.cards.count - 1)
                                }
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: cardHolder.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if cardHolder.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .sheet(isPresented: $showSheet, onDismiss: resetCards) {
            if activeSheet == .Edit {
                EditCards()
            } else if activeSheet == .Settings {
                Settings(tryAgainOption: $tryAgainOption)
            }
        }
        .onAppear() {
            resetCards()
            prepareHaptics()
        }
    }
    
    func putCardBack(index: Int) {
        guard index >= 0 else { return }
        let removed = cardHolder.cards.remove(at: index)
        if cardHolder.cards.count > 0 && tryAgainOption {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cardHolder.cards.insert(removed, at: 0)
            }
        }
        if cardHolder.cards.isEmpty {
            isActive = false
        }
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cardHolder.cards.remove(at: index)
        if cardHolder.cards.isEmpty {
            isActive = false
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cardHolder.cards = decoded
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
