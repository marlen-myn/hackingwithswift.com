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
    }
}

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
                currentQuestion = questions[currentQuestionIndex]
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
                            Spacer()
                            
                            Text("Question: \(currentQuestionIndex + 1)")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            
                            QuestionView(question: $currentQuestion, answer: $currentAnswer)
                                .rotation3DEffect(.degrees(rotationDegree), axis: (x: 0, y: 1, z: 0))
                                .animation(isCorrect ? Animation.easeInOut(duration: 0.5) : nil)
                            
                            if isAnswered {
                                Text(resultTitle)
                                    .font(.largeTitle)
                                    .foregroundColor(isCorrect ? .green : .red)
                            }
                            
                            Spacer()
                            
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
                            }
                        }
                    } else {
                        VStack {
                            Spacer()
                            Group {
                                VStack(alignment: .center, spacing: 10) {
                                    Text("Well done!")
                                    Text("You have scored: \(score)")
                                    Text("Try again, and you can do better!")
                                        .multilineTextAlignment(.center)
                                    
                                    Button(action: {
                                        withAnimation {
                                            gameState = .settings
                                        }
                                    }, label: {
                                        Text("Try again")
                                            .font(.headline)
                                            .frame(width: 100, height: 50)
                                            .background(Color.green)
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    })
                                }
                            }
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 50)

                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle("Score: \(score)", displayMode: .inline)
            .navigationBarItems(leading: Button("New Game"){
                withAnimation {
                    gameState = .settings
                }
            })
        }
    }
    
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
