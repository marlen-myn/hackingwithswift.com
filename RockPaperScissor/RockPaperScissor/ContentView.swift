//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Marlen Mynzhassar on 15.11.2020.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    @State private var currentChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var showAlert = false
    @State private var scoreTitle = ""
    @State private var moveCount = 0
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea(.all)
            VStack (spacing: 10) {
                if moveCount < 10 {
                    Group {
                        HStack {
                            Text("Score: \(score)")
                            Spacer()
                            Text("Move: \(moveCount)")
                        }
                        .padding()
                        Divider()
                        Spacer()
                        Text("\(possibleMoves[currentChoice]) - \(shouldWin ? "Win" : "Lose")")
                    }
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    
                    HStack {
                        ForEach(0..<possibleMoves.count) {
                            let move = possibleMoves[$0]
                            Button(action: {
                                if let choice = possibleMoves.firstIndex(of: move) {
                                    makeMove(choice)
                                    showAlert = true
                                }
                            }, label: {
                                Text(move)
                                    .frame(width:100,height: 100)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                            })
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text(scoreTitle),
                                  message: Text("Your score \(score)"),
                                  dismissButton: .default(Text("Continue")) {
                                    moveCount += 1
                                    nextMove()
                                  }
                            )
                        }
                    }
                    .padding(15)
                    
                } else {
                    Spacer()
                    Text("Game Finished")
                        .font(.largeTitle)
                    Button("Start Again") {
                        startNewGame()
                    }
                    Spacer()
                }
                
                Spacer()
            }
        }
    }
    
    private func makeMove(_ choice: Int) {
        if (shouldWin && isOnRight(choice)) || (!shouldWin && isOnLeft(choice)){
            score += 1
            scoreTitle = "You Won!"
        } else {
            score -= 1
            scoreTitle = "You Lost :("
        }
    }
    
    private func isOnRight(_ choice: Int) -> Bool {
        let nextMove = (currentChoice + 1 < possibleMoves.count) ? currentChoice + 1 : 0
        return nextMove == choice
    }
    
    private func isOnLeft(_ choice: Int) -> Bool {
        let previousMove = (currentChoice - 1 < 0) ? 2 : currentChoice - 1
        return previousMove == choice
    }
    
    private func nextMove() {
        currentChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
    
    private func startNewGame() {
        moveCount = 0
        score = 0
        showAlert = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
