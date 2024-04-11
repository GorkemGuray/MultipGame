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
    @State public var qaConf = QaConf()
    
    @Environment(\.dismiss) var dismiss
    
    let questionNumberOptions = [5,10,20]
    
    
    var qas: Qa
    
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
                    print("\(upTo+2)")
                    print("\(questionNumber)")
                    
                    qaConf.numberOfQuestions = questionNumber
                    qaConf.upTo = upTo + 2
                    
                    qas.qaConf = qaConf
                    dismiss()
                }
                
            }//Form
            .navigationTitle("Settings")
        }//NavigationStack
    }
}

 #Preview {
 SettingsView(qas: Qa())
 }
 
