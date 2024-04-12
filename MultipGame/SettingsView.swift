//
//  SettingsView.swift
//  MultipGame
//
//  Created by Görkem Güray on 11.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var upTo = 2
    @State private var questionNumber = 2
    @State private var qaConf = QaConf()
    
    @Environment(\.dismiss) var dismiss
    
    let questionNumberOptions = [5,10,20]
    
    
    var qas: Qa
    var gameState: GameState
    var body: some View {
        NavigationStack {
            Form {
                Section("Up To...") {
                    Picker("Up To", selection: $upTo) {
                        ForEach(2..<13) {
                            Text("\($0)")
                        }//ForEach
                    }//Picker
                    .pickerStyle(.wheel)
                }//Section
                
                Section("Number of Question") {
                    Picker("Question Number", selection: $questionNumber) {
                        ForEach(questionNumberOptions, id: \.self) {option in
                            Text("\(option)")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.segmented)
                }
                
                Button("Start Game") {
                    qaConf.numberOfQuestions = questionNumber
                    qaConf.upTo = upTo + 2
                    qas.qaConf = qaConf
                    gameState.gameIndex = 0
                    gameState.gameScore = 0
                    gameState.isGameActive = true
                    dismiss()
                }
                
            }//Form
            .navigationTitle("Settings")
        }//NavigationStack
    }//var body
}//ContentView

 #Preview {
 SettingsView(qas: Qa(), gameState: GameState())
 }
 
