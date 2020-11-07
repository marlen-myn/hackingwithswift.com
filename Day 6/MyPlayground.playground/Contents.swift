import UIKit

let driving = { (place: String) -> String in
    return "I'm driving to the \(place) in my car"
}

func travel(action: (String) -> String) {
    print("I'm travelling")
    let destination = action("Nur-Sultan")
    print("I have reached the destination: \(destination)")
}

//travel { place in
//    return place
//}


func buildCar(name: String, engine: (Int) -> Void) {
    print("building the card")
    engine(5)
    print("finished")
}

//buildCar(name: "BMW") { speed in
//    print("Changing speed to \(speed)kph")
//}

func reduce(_ values: [Int], using closure: (Int, Int) -> Int) -> Int {
    // start with a total equal to the first value
    var current = values[0]

    // loop over all the values in the array, counting from index 1 onwards
    for value in values[1...] {
        // call our closure with the current value and the array element, assigning its result to our current value
        current = closure(current, value)
    }

    // send back the final current value
    return current
}

let numbers = [10, 20, 30]
let sum = reduce(numbers, using: *)

typealias ClosureType = (Int) -> String
var closureName: ClosureType

func someFunc () -> ClosureType {
    return {
        "Returned \($0)"
    }
}

closureName = someFunc()
closureName(5)

func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}

travel {
    "I'm going to \($0) at \($1) miles per hour."
}

