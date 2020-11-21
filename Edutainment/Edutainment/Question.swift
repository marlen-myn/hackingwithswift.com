//
//  Question.swift
//  Edutainment
//
//  Created by Marlen Mynzhassar on 20.11.2020.
//

import Foundation

struct Question {
    let question: String
    var answer: Int
    var isCurrent: Bool
    
    static var questions: [Question] {
        var quetionBase = [Question]()
        for num in 2...10 {
            for numInternal in 1...10 {
                let newQuestion = Question(question: "What is \(num) * \(numInternal) ?", answer: num * numInternal, isCurrent: false)
                quetionBase.append(newQuestion)
            }
        }
        return quetionBase
    }
}
