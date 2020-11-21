//
//  ActiveGame.swift
//  Edutainment
//
//  Created by Marlen Mynzhassar on 21.11.2020.
//

import SwiftUI

// Active Game View
struct ActiveGame: View {
    @Binding var gameState: GameState
    @Binding var questions: [Question]
    
    @State var currentQuestion: Question
    @State var currentAnswer: String = ""
    
    @State private var isAnswered = false
    @State private var isCorrect = false
    @State private var resultTitle = ""
    @State private var rotationDegree = 0.0
    
    @State private var score = 0
    @State private var currentQuestionIndex = 0 {
        didSet {
            if currentQuestionIndex < questions.count {
                currentQuestion.isCurrent = false
                currentQuestion = questions[currentQuestionIndex]
                currentQuestion.isCurrent = true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                if isAnswered {
                    LinearGradient(gradient: Gradient(colors: [isCorrect ? Color.green : Color.pink, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea(edges: .bottom)
                }
                
                Group {
                    if currentQuestionIndex < questions.count {
                        
                        VStack {
                            
                            ForEach(0..<questions.count) {
                                if $0 == currentQuestionIndex {
                                    VStack { // this stack shoule move in and out
                                        Text("Question: \(currentQuestionIndex + 1)")
                                            .font(.largeTitle)
                                            .foregroundColor(.blue)
                                        
                                        QuestionView(question: $currentQuestion, answer: $currentAnswer)
                                            .rotation3DEffect(.degrees(rotationDegree), axis: (x: 0, y: 1, z: 0))
                                            .animation(isCorrect ? Animation.easeInOut(duration: 0.5) : .default)
                                           
                                        
                                    } // end of VStack
                                    .transition(.slide)
                                }
                            }
                            
                            VStack {
                                if isAnswered {
                                    Text(resultTitle)
                                        .font(.largeTitle)
                                        .foregroundColor(isCorrect ? .green : .red)
                                        .padding()
                                }
                                
                                HStack(spacing:10) {
                                    Button(action: {
                                        withAnimation {
                                            checkAnswer()
                                        }
                                    }) {
                                        Text("Check")
                                            .frame(width: 100, height: 50)
                                            .background(isAnswered ? Color.gray : Color.blue)
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    .disabled(isAnswered)
                                    
                                    Button(action: {
                                        withAnimation {
                                            nextQuestion()
                                        }
                                    }, label: {
                                        Text("Next")
                                            .frame(width: 100, height: 50)
                                            .background(Color.green)
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    })
                                    
                                } // end of HStack
                                
                            } // end of VStack
                            
                        } // end of VStack
                        
                    } else {
                        EndGame(score: score, gameState: $gameState)
                    }
                    
                } // end-of-Group
                
            } // end of ZStack
            .navigationBarTitle("Score: \(score)", displayMode: .inline)
            .navigationBarItems(leading: Button("New Game"){
                withAnimation {
                    gameState = .settings
                }
            })
            
        } // end of NavigationView
    } // end of body
    
    func checkAnswer() {
        isAnswered = true
        if currentQuestion.answer == Int(currentAnswer) {
            score += 1
            resultTitle = "Correct!"
            isCorrect = true
            rotationDegree += 360
        } else {
            resultTitle = "Wrong"
            isCorrect = false
        }
    }
    
    func nextQuestion() {
        
        currentQuestionIndex += 1
        isCorrect = false
        isAnswered = false
        currentAnswer = ""
    }
}
