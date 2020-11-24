import SwiftUI

for number in stride(from: 0, to: 10, by: 2) {
    print(number)
}

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 4) {
            print("Number: \(number)")
            
            //Create a rotation transform equal to the current number.
            let rotation = CGAffineTransform(rotationAngle: number)
            print("Rotation: \(rotation)")
            
            //Add to that rotation a movement equal to half the width and height of our draw space, so each petal is centered in our shape.
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            
            //Create a new path for a petal, equal to an ellipse of a specific size.
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width/2))
            
            //Apply our transform to that ellipse so it’s moved into position.
            let rotatedPetal = originalPetal.applying(position)
            
            //Add that petal’s path to our main path.
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

private var petalOffset = -20.0
private var petalWidth = 100.0

Flower(petalOffset: petalOffset, petalWidth: petalWidth)
    .stroke(Color.red, lineWidth: 1)
