//
//  ContentView.swift
//  Test
//
//  Created by Marlen Mynzhassar on 22.11.2020.
//

import SwiftUI

class SomeClass: ObservableObject {
    
    @Published var arraySet: [Int] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(arraySet) {
                UserDefaults.standard.set(encoded, forKey: "Items_1")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items_1") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Int].self, from: items) {
                arraySet = decoded
                return
            }
        }
        arraySet = []
    }
}

struct ContentView: View {
    @ObservedObject var object = SomeClass()
    @State private var isShowSheet = false
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(object.arraySet, id:\.self) { item in
                    Text("\(item)")
                }
                .onDelete(perform: { indexSet in
                    object.arraySet.remove(atOffsets: indexSet)
                })
            }
            .navigationBarItems(leading: EditButton(),
                                trailing: Button("Add new item") {
                                    isShowSheet = true
                                })
            .sheet(isPresented: $isShowSheet) {
                AnotherView(object: object)
            }
            .environment(\.editMode, $editMode)
        }
    }
}

struct AnotherView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var object: SomeClass
    
    var body: some View {
        NavigationView {
            Form {
                Text("Custom Text")
            }
            .navigationBarItems(trailing: Button("Done"){
                let item = object.arraySet.max() ?? 0
                object.arraySet.append(item + 1)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(object: SomeClass())
    }
}
