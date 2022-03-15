//
//  AllowedWordsModel.swift
//  Wordle
//
//  Created by Nikita Velichko on 17/02/22.
//

import Foundation

struct AllowedWordsModel {
    
    static var allAllowedWords: [String] = Locale.preferredLanguages[0].prefix(2) == "ru" ? Dictionary.fullRussianDic : Dictionary.englishDic
    
    static func checkIfWordIsAllowed(word: [Letter]) -> Bool {
        var wordStr: String = ""
        
        for alphabet in word {
            wordStr.append(alphabet.letter)
        }
        
        wordStr = wordStr.lowercased()
        if allAllowedWords.contains(wordStr) {
            return true
        }
        else {
            return false
        }
    }
}
