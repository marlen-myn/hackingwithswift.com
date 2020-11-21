//
//  ContentView.swift
//  Animations
//
//  Created by Marlen Mynzhassar on 19.11.2020.
//

import SwiftUI

class SomeClas: ObservableObject {
    @Published var array = [Item]() {
        didSet {
            print("s")
        }
    }
    init() {
        for num in 0..<10 {
            array.append(Item(id: num))
        }
        array[0].isVisible = true
    }
}

struct Item: Identifiable {
    let id: Int
    var isVisible = false
}

struct ContentView: View {
    @State private var counter = 0
    @ObservedObject var someClass: SomeClas

    var body: some View {
        VStack {
            
            Spacer()
            
            Group {
                ForEach(someClass.array) { item in
                    if item.isVisible {
                        CardView(counter: item.id)
                    }
                }
            }
            .transition(.slide)
            .animation(.default)
            
            Spacer()
            
            Button("Tap Me") {
                someClass.array[counter].isVisible = false
                counter += 1
                someClass.array[counter].isVisible = true
            }
        }
    }
}

struct CardView: View {
    var counter: Int
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .leading, endPoint: .trailing)
                .frame(width: 300, height: 200, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            Text("First: \(counter)")
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(someClass: SomeClas())
    }
}
