//
//  ContentView.swift
//  Edutainment
//
//  Created by Marlen Mynzhassar on 20.11.2020.
//

import SwiftUI

// Enum to identify possbile game states
enum GameState {
    case active
    case settings
}

// Settings view
struct Settings: View {
    @Binding var gameState: GameState
    @Binding var questions: [Question]
    @State private var selectedMultiplicationTable = 0
    @State private var selectedQuestionsNumber = 1
    let questionsNumber = ["3", "5", "10"]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Form {
                        Section(header: Text("Multiplication table")) {
                            Picker("Choose", selection: $selectedMultiplicationTable) {
                                ForEach(2..<16) {
                                    Text("\($0)")
                                }
                            }
                        }
                        
                        Section(header: Text("Number of questions")) {
                            Picker("Choose", selection: $selectedQuestionsNumber) {
                                ForEach(0..<questionsNumber.count) {
                                    Text(questionsNumber[$0])
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: Button("Play") {
                withAnimation {
                    gameState = .active
                    generateRandomQuestions()
                }
            })
        }
    }
    
    func generateRandomQuestions() {
        let numberOfQuestions = Int(questionsNumber[selectedQuestionsNumber]) ?? 5
        
        let allQuestions =  Question.questions.filter( { $0.question.contains("What is \(selectedMultiplicationTable + 2) *") } ).shuffled()
        
        questions = Array(allQuestions.prefix(numberOfQuestions))
        questions[0].isCurrent = true
    }
}

struct QuestionView: View {
    @Binding var question: Question
    @Binding var answer: String
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300, height: 200, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
                Text(question.question)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
            HStack {
                Spacer()
                
                TextField("Type your answer", text: $answer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(50)
                    .keyboardType(.numberPad)
                
                Spacer()
            }
        }
    }
}

// Main menu view
struct ContentView: View {
    @State private var gameState = GameState.settings
    @State private var questions = [Question]()
    
    var body: some View {
        if gameState == .active {
            ActiveGame(gameState: $gameState, questions: $questions, currentQuestion: questions[0])
                .transition(.slide)
        } else {
            Settings(gameState: $gameState, questions: $questions)
                .transition(.slide)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
