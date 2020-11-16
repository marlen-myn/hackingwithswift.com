//
//  ContentView.swift
//  BetterRest
//
//  Created by Marlen Mynzhassar on 15.11.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = ContentView.defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount =  0
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    private var sleepTime: String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        var calculatedSleepTime = ""
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            calculatedSleepTime = formatter.string(from: sleepTime)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calcualting your bedtime."
            showingAlert = true
        }
        
        return calculatedSleepTime
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")
                            .font(.headline)) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")
                            .font(.headline)) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake")
                            .font(.headline)) {
                    //                    Stepper(value: $coffeeAmount, in: 1...20) {
                    //                        if coffeeAmount == 1 {
                    //                            Text("1 cup")
                    //                        } else {
                    //                            Text("\(coffeeAmount) cups")
                    //                        }
                    //                    }
                    Picker(selection: $coffeeAmount, label: Text("Number of cups")) {
                        ForEach(1..<6) { number in
                            Text("\(number)").tag(number)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("You ideal bed time")
                            .font(.headline)) {
                    Text(sleepTime)
                }
            }
            .navigationBarTitle("Better Rest")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedTime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal time is ..."
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calcualting your bedtime."
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
