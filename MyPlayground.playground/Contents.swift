import UIKit

let nums1 = [2]
let nums2 = [Int]()

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let mergedArray = nums1 + nums2
    let sorted = mergedArray.sorted()
    var foundMedian: Double = 0.0
        
    if sorted.isEmpty { return foundMedian }
    if sorted.count == 1 { return Double(sorted[0]) }
    
    let middleIndex = floor(Double(sorted.count) / 2.0)
    
    if sorted.count % 2 == 0 {
        let rightMedian = Double(sorted[Int(middleIndex)])
        let leftMedian = Double(sorted[Int(middleIndex) - 1])
        foundMedian = (rightMedian + leftMedian) / 2
    } else {
        foundMedian = Double(sorted[Int(middleIndex)])
    }
    
    return foundMedian
}

print(findMedianSortedArrays(nums1, nums2))
