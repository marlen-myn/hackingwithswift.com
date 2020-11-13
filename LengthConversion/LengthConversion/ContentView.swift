//
//  ContentView.swift
//  LengthConversion
//
//  Created by Marlen Mynzhassar on 11/13/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputNumber = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    
    let availableUnits = ["meters", "km","feet","yards","miles"]

    var result: Double {
        let inputValue = Double(inputNumber) ?? 0
        let baseValue = convertToBaseUnit(inputValue)
        let convertedValue = convertToTargetUnit(baseValue)
        return convertedValue
    }
    
    private func convertToBaseUnit(_ value: Double) -> Double {
        var inputValue = value
        switch availableUnits[inputUnit] {
            case "km": inputValue *= 1000
            case "feet": inputValue /= 3.28084
            case "yards": inputValue /= 1.09361
            case "miles": inputValue *= 1609
            default: inputValue *= 1
        }
        return inputValue
    }
    
    private func convertToTargetUnit(_ value: Double) -> Double {
        var inputValue = value
        switch availableUnits[outputUnit] {
            case "km": inputValue /= 1000
            case "feet": inputValue *= 3.28084
            case "yards": inputValue *= 1.09361
            case "miles": inputValue /= 1609
            default: inputValue *= 1
        }
        return inputValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter your value", text: $inputNumber)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Convert From")) {
                    Picker("Convert from", selection: $inputUnit) {
                        ForEach(0..<availableUnits.count) {
                            Text("\(availableUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Convert To")) {
                    Picker("Convert from", selection: $outputUnit) {
                        ForEach(0..<availableUnits.count) {
                            Text("\(availableUnits[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Conversion result")) {
                    Text("\(result, specifier: "%.3f")")
                }
                
            }
            .navigationBarTitle("Length Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
