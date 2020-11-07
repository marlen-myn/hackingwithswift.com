import UIKit

var result = 11 % 6

let title = "A Swift Blog"
let range = title.range(of: "Swift")!
let convertedRange = NSRange(range, in: title)
let attributedString = NSMutableAttributedString(string: title)

attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], range: convertedRange)

print(attributedString)
