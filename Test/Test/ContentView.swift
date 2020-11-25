//
//  ContentView.swift
//  Test
//
//  Created by Marlen Mynzhassar on 25.11.2020.
//

import SwiftUI

struct StructA: Identifiable {
    var id = UUID()
    var title: String
    var count: Int
}

class ClassA: ObservableObject {
    @Published var items = [StructA]()
}

struct ContentView: View {
    @ObservedObject var classA: ClassA
    
    var body: some View {
        NavigationView {
            List {
                ForEach(classA.items.indices, id: \.self) { index in
                    NavigationLink(destination: InnerView(item: $classA.items[index])) {
                        Text("\(classA.items[index].title) - \(classA.items[index].count)")
                    }
                }
            }
            .navigationTitle("Test")
            .navigationBarItems(trailing: Button("Add") {
                classA.items.append(StructA(title: "String", count: Int.random(in: 1...10)))
            })
        }
    }
}

struct InnerView: View {
    @Binding var item: StructA
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $item.title)
            }
            
            Section {
                Stepper("\(item.count)", value: $item.count)
            }
        }
        .navigationTitle(item.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(classA: ClassA())
    }
}
