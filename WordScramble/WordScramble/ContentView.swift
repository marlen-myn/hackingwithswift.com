//
//  ContentView.swift
//  WordScramble
//
//  Created by Marlen Mynzhassar on 17.11.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State var isScrolled = false
    let colors = [Color.red, Color.blue, Color.green, Color.black, Color.orange, Color.pink]
    
    func getColor(_ geo: GeometryProxy, _ index: Int) -> Color {
        let threshold: CGFloat = 264.0 + CGFloat(index) * geo.size.height * 2
        if geo.frame(in: .global).minY > threshold {
            return colors[index % colors.count]
        } else {
            return Color.black
        }
    }
    
    var body: some View {
        GeometryReader { fullsize in
            NavigationView {
                VStack {
                    TextField("Enter new word", text:$newWord, onCommit: addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    
                    List(0..<usedWords.count, id: \.self) { index in
                        
                        GeometryReader { geo in
                            HStack {
                                Image(systemName: "\(usedWords[index].count).circle")
                                    .foregroundColor(getColor(geo, index))
                                Text(usedWords[index])
                            }
                            .onTapGesture {
                                print("fullsize height: \(fullsize.size.height)")
                                print("fullsize minY : \(fullsize.frame(in: .global).minY)")
                                print("geo height: \(geo.size.height)")
                                print("geo minY : \(geo.frame(in: .global).minY)")
                            }
                            .offset(x: max(0, geo.frame(in: .global).maxY - fullsize.size.height * 0.8), y:0)
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(usedWords[index]), \(usedWords[index].count) letters"))
                            .animation(.default)
                        }
                    }
                    
                    Text("Score: \(score)")
                }
                .navigationBarTitle(rootWord)
                .navigationBarItems(trailing: Button("New Game", action: startGame))
                .onAppear(perform: startGame)
                .alert(isPresented: $showingError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word is used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word is not recognized", message: "You can not just make them up, you know!")
            return
        }
        
        guard isRealWord(word: answer) else {
            wordError(title: "Word is not possible", message: "That is not a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        calculateScore(word: answer)
        newWord = ""
    }
    
    func startGame() {
        if let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                usedWords = [String]()
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word) && rootWord != word
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isRealWord(word: String) -> Bool {
        guard word.count > 2 else { return false }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return mispelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func calculateScore(word: String) {
        if word.count > 5 {
            score += 2
        } else {
            score += 1
        }
        if usedWords.count > 5 {
            score += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
