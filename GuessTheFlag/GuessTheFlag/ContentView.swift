//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Marlen Mynzhassar on 13.11.2020.
//

import SwiftUI

struct FlagImage: View {
    var countrySelected: String
    
    var body: some View {
        Image(countrySelected)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var flagTapped = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var rotationDegreeAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var scaleEffect: CGFloat = 1.0
    @State private var isWrong = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                VStack {
                    Text("Tap the flag off")
                        .foregroundColor(.white)
                    
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        if !flagTapped {
                            flagTapped(number)
                        }
                    }) {
                        FlagImage(countrySelected: countries[number])
                            .accessibility(label: Text(labels[countries[number], default: "Unknown flag"]))

                    }
                    .rotation3DEffect(.degrees(number == correctAnswer ? rotationDegreeAmount : .zero),
                                      axis: (x: 0.0, y: 1.0, z: 0.0))
                    .opacity(number == correctAnswer ? 1 : opacityAmount)
                    .animation(.easeInOut(duration: 0.7))
                    .scaleEffect(number == correctAnswer && isWrong ? scaleEffect : 1)
                    .animation(isWrong ? Animation.linear.repeatForever(autoreverses: true) : .default)
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                
                Text(scoreTitle)
                    .foregroundColor(.white)
                
                Button(action: askQuestions) {
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50, alignment: .center)
                        .background(!flagTapped ? Color.gray : Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
                .disabled(!flagTapped)
            }
            
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            rotationDegreeAmount += 360
            opacityAmount = 0.25
            score += 1
        } else {
            isWrong = true
            scaleEffect = 1.2
            scoreTitle = "Wrong. That’s the flag of \(countries[number])"
            score -= 1
        }
        flagTapped = true
    }
    
    func askQuestions() {
        withAnimation {
            flagTapped = false
            scoreTitle = ""
            isWrong = false
            scaleEffect = 1.0
            opacityAmount = 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
