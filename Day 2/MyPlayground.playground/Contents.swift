import UIKit

enum TimeInterval: Equatable {
    case seconds(value: Int)
    case milliseconds(Int)
    case microseconds(Int)
    case nanoseconds(Int)
}

if TimeInterval.seconds(value: 1) == .seconds(value: 1) {
    print("Matching!")
} else {
    print("Not matching!")
}
