//
//  TrainingViewModel.swift
//  Wordle
//
//  Created by Vlad Likh on 17.02.2022.
//

import Foundation

class TrainingViewModel: ObservableObject {
    @Published var wordsDone = 0
    @Published var level = 1
    @Published var wordsNumer = 0
    
    func newWordDone() {
        wordsNumer += 1
        if wordsDone < level + 1 {
            wordsDone += 1
        } else {
            wordsDone = 0
            level += 1
        }
        UserDefaults.standard.set(wordsDone, forKey: "wordsDone")
        UserDefaults.standard.set(level, forKey: "level")
        UserDefaults.standard.set(wordsNumer, forKey: "wordsNumer")
    }
}
