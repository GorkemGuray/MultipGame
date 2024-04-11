//
//  Generator.swift
//  MultipGame
//
//  Created by Görkem Güray on 10.04.2024.
//

import Foundation

class Generator {
    var qa = QuestionsAndAnswers(questions: [""], answers: [0])
    
    var upTo: Int
    var numberOfQuestions: Int {
        didSet {
            var firstElement = 0
            var secondElement = 0
            
            for _ in 0...self.numberOfQuestions-1 {
                firstElement = Int.random(in: 2...upTo)
                secondElement = Int.random(in: 2...12)
                
                qa.questions.append("\(String(firstElement)) x \(String(secondElement)) = ?")
                qa.answers.append(firstElement*secondElement)
            }
        }
    }
    
    init(upTo: Int, numberOfQuestions: Int) {
        self.upTo = upTo
        self.numberOfQuestions = numberOfQuestions
    }
    
    
    
}//class
