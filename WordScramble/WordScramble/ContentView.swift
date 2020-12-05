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
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter new word", text:$newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text("\(word), \(word.count) letters"))
                    
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
