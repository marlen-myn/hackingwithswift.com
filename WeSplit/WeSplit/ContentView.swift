//
//  ContentView.swift
//  WeSplit
//
//  Created by Marlen Mynzhassar on 11/12/20.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

extension View {
    func titleStyles() -> some View {
        self.modifier(Title())
    }
}

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = "1"
    @State private var tipPercentage = 3
    
    private let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let numberOfPeopleConverted = Int(numberOfPeople) ?? 0
        let peopleCount = Double(numberOfPeopleConverted)
        let amountPerPerson = totalAmount / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    //                    Picker("Number of people", selection: $numberOfPeople) {
                    //                        ForEach(2..<100) {
                    //                            Text("\($0) people")
                    //                        }
                    //                    }
                    
                }
                
                Section(header: Text("Number of people")) {
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip would you like to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$ \(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total amount for the check")) {
                    Text("$ \(totalAmount, specifier: "%.2f")")
                        .foregroundColor(tipPercentage==0 ? .red : .black )
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
