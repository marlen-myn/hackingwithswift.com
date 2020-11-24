//
//  ContentView.swift
//  Arrow
//
//  Created by Marlen Mynzhassar on 24.11.2020.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var lineThickness: Double
    var steps: Int

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Arrow(lineThickness: lineThickness, insetAmount: CGFloat(amount))
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Arrow: InsettableShape {
    var lineThickness: Double
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        //rectangle
        path.move(to: CGPoint(x: rect.midX - CGFloat(lineThickness) + insetAmount, y: rect.midY - 100 + insetAmount))
        path.addLine(to: CGPoint(x: rect.midX - CGFloat(lineThickness) + insetAmount, y: rect.midY + 100 - insetAmount))
        // horizontal bottom line
        path.addLine(to: CGPoint(x: rect.midX + CGFloat(lineThickness) - insetAmount, y: rect.midY + 100 - insetAmount))
        
        path.addLine(to: CGPoint(x: rect.midX + CGFloat(lineThickness) - insetAmount, y: rect.midY - 100 + insetAmount))
        path.addLine(to: CGPoint(x: rect.midX - CGFloat(lineThickness) + insetAmount, y: rect.midY - 100 + insetAmount))
        
        // triangle
        
        path.move(to: CGPoint(x: rect.midX - CGFloat(lineThickness), y: rect.midY - 100))
        path.addLine(to: CGPoint(x: rect.midX - 50 - CGFloat(lineThickness), y: rect.midY - 100))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY - 200))
        path.addLine(to: CGPoint(x: rect.midX + 50 + CGFloat(lineThickness), y: rect.midY - 100))
        path.addLine(to: CGPoint(x: rect.midX - CGFloat(lineThickness), y: rect.midY - 100))
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var rect = self
        rect.insetAmount += amount
        return rect
    }
}

struct ContentView: View {
    @State private var lineThickness = 100.0
    @State private var colorCycle = 0.0
    @State private var steps = 30
    
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount:colorCycle, lineThickness:lineThickness, steps: Int(steps))
            
            Text("Line thickness \(lineThickness)")
            Slider(value: $lineThickness, in: 30...100)
            
            Text("Color cycles \(colorCycle)")
            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
