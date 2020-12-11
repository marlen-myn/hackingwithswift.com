//
//  ContentView.swift
//  Test2
//
//  Created by Marlen Mynzhassar on 11.12.2020.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width:0, height: offset * 10))
    }
}

struct ContentView: View {
    @State var cards = [Card]()
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Button("Reset") {
                        reset()
                    }
                    Spacer()
                    Text("Counter: \(cards.count)")
                }
                .padding()
                Spacer()
            }
            
            ForEach(0..<cards.count, id: \.self) { index in
                ZStack {
                    CardView(card: cards[index], addClosure: {
                        addCard()
                    }) {
                        removeCard(at:index)
                    }
                    .stacked(at: index, in: cards.count)
                }
            }
            
            HStack {
                Button("Add") {
                    addCard()
                }
                Spacer()
                Button("Remove") {
                    removeCard(at: cards.count - 1)
                }
                
            }
        }
        .onAppear() {
            reset()
        }
    }
    
    func reset() {
        cards = [Card]()
        for num in 0..<5 {
            cards.append(Card(title: "Title-\(num)", description: "Description-\(num)"))
        }
    }
    
    func addCard() {
        let removed = cards.remove(at: cards.count - 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let card = Card(title: removed.title, description: removed.description)
            cards.insert(card, at: 0)
        }
        
        
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
