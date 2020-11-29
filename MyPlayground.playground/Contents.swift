import Foundation
import UIKit

var phone_numbers = ["123-123-123","777-777-777"]
var phone_owners = ["Marlen", "Tayeer"]
var number = "444-777-777"

public func solution(_ phone_numbers : inout [String], _ phone_owners : inout [String], _ number : inout String) -> String {
    var foundNumber = ""
    if let found = phone_numbers.firstIndex(of: number) {
       foundNumber = phone_owners[found]
    } else {
       foundNumber = number
    }
    return foundNumber
}


print(solution(&phone_numbers, &phone_owners, &number))
