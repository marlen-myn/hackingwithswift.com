//
//  ContentView.swift
//  TestDrawing
//
//  Created by Marlen Mynzhassar on 24.11.2020.
//

import SwiftUI

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            
            //Create a rotation transform equal to the current number.
            let rotation = CGAffineTransform(rotationAngle: number)
            
            //Add to that rotation a movement equal to half the width and height of our draw space, so each petal is centered in our shape.
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            
            //Create a new path for a petal, equal to an ellipse of a specific size.
            let originalPetal = Path(ellipseIn:CGRect(x: CGFloat(petalOffset),y: 0, width: CGFloat(petalWidth),height: rect.width/2))
            
            //Apply our transform to that ellipse so it’s moved into position.
            let rotatedPetal = originalPetal.applying(position)
            
            //Add that petal’s path to our main path.
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {

            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .stroke(Color.red, lineWidth: 1)

            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])

            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
