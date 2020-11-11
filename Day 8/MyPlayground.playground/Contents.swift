import UIKit

struct Human {
    
    var name: String
    var height: Double
    var weight: Double
    
    lazy var bodyIndex: Int = {
        print("lazy called")
        var total = 0
        for i in 1...10 {
            total += i
        }
        return total + Int(self.height)
    }()
}

var me = Human(name: "Marlen", height: 176.5, weight: 66.0)
me.bodyIndex


struct Doctor {
    var name: String
    var location: String
    private var currentPatient = "No one"
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}

let drJones = Doctor(name: "Esther Jones", location: "Bristol")

struct App {
    var name: String
    private var sales = 0
    init(name: String) {
        self.name = name
    }
}

let spotify = App(name: "Spotify")

class Reading {
    var value = 0.0
}
class TemperatureReading: Reading { }
let temperature = TemperatureReading()
if let reading = temperature as? Reading {
    print("The reading is \(reading.value).")
}

var age: Int!
age = 38
print(age)
