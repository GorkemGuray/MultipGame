//
//  ContentView.swift
//  MultipGame
//
//  Created by Görkem Güray on 16.03.2024.
//

import SwiftUI

struct QaConf {
    var upTo: Int = 0
    var numberOfQuestions: Int = 0
}

@Observable
class Qa {
    var questions = [String]()
    var answers = [Int]()
    
    var qaConf = QaConf() {
        didSet {
            questions.removeAll()
            answers.removeAll()
            if qaConf.numberOfQuestions != 0 {
                for _ in 0..<qaConf.numberOfQuestions {
                    let firstNumber = Int.random(in: 1..<qaConf.upTo)
                    let secondNumber = Int.random(in: 2..<13)
                    
                    questions.append("\(firstNumber) x \(secondNumber) = ?")
                    answers.append(firstNumber * secondNumber)
                }//for
            }//if
        }//didSet
    }
    
    
}//class

struct ContentView: View {
    
    @State private var showingSettings = false
    @State private var qas = Qa()
    @State private var questions = [String]()
    @State private var answers = [Int]()
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                if qas.questions.count != 0 {
                    Text("\(qas.questions[0])")
                    Text("\(qas.answers[0])")
                } else {
                    Button("Make Settings") {
                        showingSettings = true
                    }
                    
                }//if-else
                
            }//VStack
            .toolbar {
                Button {
                    showingSettings = true
                } label: {
                    Image(systemName: "gear")
                }//Button
                .sheet(isPresented: $showingSettings) {
                    SettingsView(qas: qas)
                }//sheet

            }//toolbar
        }

        
    }
}

#Preview {
    ContentView()
}
