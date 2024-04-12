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
            print(questions)
            print(answers)
            dump(qaConf)
        }//didSet
    }//variable setting
    
    
}//class QA

@Observable
class GameState {
    var isGameActive = false
    var gameScore = 0
    var gameIndex = 0
}//class GameState

struct ContentView: View {
    
    @State private var showingSettings = false
    @State private var showingResult = false
    @State private var qas = Qa()
    @State private var gameState = GameState()
    @State private var questions = [String]()
    @State private var answers = [Int]()
    
    var body: some View {
        
        NavigationStack {
            
            VStack {

                if gameState.isGameActive {
                    ZStack {
                        RadialGradient(stops: [
                            .init(color: Color(red: 0.28, green: 0.58, blue: 0.69), location: 0.3),
                            .init(color: Color(red: 0.87, green: 0.34, blue: 0.27), location: 0.3),
                        ], center: .top, startRadius: 200, endRadius: 700)
                        .ignoresSafeArea()
                        
                        VStack{
                            
                            Text("Score: \(gameState.gameScore)")
                                .font(.headline)
                                .foregroundStyle(.regularMaterial)
                            //Text("GameIndex: \(gameState.gameIndex)")
                            Spacer()
                            
                            Text("\(qas.questions[gameState.gameIndex])")
                                .font(.title.bold())
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            VStack {
                                
                                let randomNumber = Int.random(in: 0..<4)
                                
                                
                                ForEach(0..<4){ number in
                                    let buttonAnswer = randomNumber == number ? qas.answers[gameState.gameIndex] : Int.random(in: 2...qas.qaConf.upTo*3)
                                    
                                    Button{
                                        selectionMade(selection: buttonAnswer)
                                    } label: {
                                        HStack {
                                            Spacer()
                                            Image("\(Int.random(in: 1...30))").resizable()
                                                .scaledToFit()
                                                .frame(height: 50)
                                            Spacer()
                                            Spacer()
                                            Text("\(buttonAnswer)")
                                                .font(.title2.bold())
                                                .foregroundStyle(.black)
                                                .multilineTextAlignment(.trailing)
                                            Spacer()
                                        }
                                    }//Button
                                    .frame(width: 250, height: 80)
                                    .background(.thickMaterial)
                                    .clipShape(.rect(cornerRadius: 20))
                                    
                                }//ForEach
                            }//VStack
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(.regularMaterial)
                            .clipShape(.rect(cornerRadius: 20))
                            Spacer()
                        }//VStack
                        
                        
                    }//ZStack

                } else {
                    Spacer()
                    Text("Last Score: \(gameState.gameScore)")
                        .font(.headline.bold())
                        .foregroundStyle(.black)
                    Spacer()
                    Button("Make Settings") {
                        showingSettings = true
                    }
                    Spacer()
                }//if-else
                
            }//VStack
            .toolbar {
                Button {
                    showingSettings = true
                } label: {
                    Image(systemName: "gear")
                        .foregroundStyle(gameState.isGameActive ? .white : .blue)
                }//Button
                .sheet(isPresented: $showingSettings) {
                    SettingsView(qas: qas, gameState: gameState)
                }//sheet
                
                .alert("Finished!", isPresented: $showingResult){
                    Button("OK", action: restartGame)
                } message: {
                    Text("Your Score Is \(gameState.gameScore)")
                }//alert

            }//toolbar
        }//NavigationStack

        
    }//var body
    
    func selectionMade(selection: Int) {
        if selection == qas.answers[gameState.gameIndex] {
            gameState.gameScore += 1
        }
        if gameState.gameIndex != qas.qaConf.numberOfQuestions-1 {
            gameState.gameIndex += 1
        } else {
            gameState.isGameActive = false
            showingResult = true
        }
        
    }//func selectionMade
    
    func restartGame() {
        gameState.isGameActive = false
    }//func restartGame
}//ContentView

#Preview {
    ContentView()
}
