//
//  SecretWordModel.swift
//  Wordle
//
//  Created by Nikita Velichko on 17/02/22.
//

import Foundation

class SecretWordModel {
    
    static let mainSecretWordInstance = SecretWordModel()
    
//  This is just the default valueвава
    lazy var secretWord: [String] = firstGenerateNewWord() {
        didSet {
            secretWordString = secretWord.convertArrayToString()
        }
    }
    
    var randomWords: [String] = Locale.preferredLanguages[0].prefix(2) == "ru" ? Dictionary.russianDic : Dictionary.englishDic
    
    var secretWordString: String = ""

    func generateNewWord(completion: @escaping (Bool) -> Void) {
        secretWord = randomWords.randomElement()!.map { String($0) }
        print("changed Word: \(secretWord)")
        completion(true)
    }
    
    func firstGenerateNewWord() -> [String] {
        let newWordString = randomWords.randomElement()!
        let newWordArray = newWordString.map { String($0) }
        secretWordString = newWordString
        return newWordArray
    }
    
}
