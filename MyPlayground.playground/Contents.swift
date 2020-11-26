import Foundation


var A = [-1, -2]

public func solution(_ A : inout [Int]) -> Int {
    let minimum = A.min()! > 0 ? A.min()! : 0
    var nextMinimum = minimum + 1
    while A.contains(nextMinimum) {
        nextMinimum += 1
    }
    return nextMinimum
}


solution(&A)

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    
    for firstIndex in 0..<nums.count {
        for secondIndex in firstIndex + 1..<nums.count {
            if nums[firstIndex] + nums[secondIndex] == target {
                return [firstIndex, secondIndex]
            }
        }
    }
    
    return [Int]()
}

twoSum([3,3], 6)
