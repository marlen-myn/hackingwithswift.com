//
//  ContentView.swift
//  WordScramble
//
//  Created by Marlen Mynzhassar on 17.11.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        var trimmedWord: String?
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                let words = fileContents.components(separatedBy: "\n")
                let randomWord = words.randomElement()
                trimmedWord = randomWord?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        return Text(trimmedWord!)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
