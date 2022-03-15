//
//  WordleGameViewModel.swift
//  Wordle
//
//  Created by Nikita Velichko on 17/02/22.
//

import Foundation
import SwiftUI

struct AlphabetStatus {
    var alphabet: String
    var status: WordleColor
}

struct KeyboardColor {
    let backgroundColorOfKeyboard: Color
    let foregroundColorOfKeyboard: Color
}

struct Letter: Identifiable {
    var id = UUID()
    var letter: String = ""
    var color: Color = Color("Card")
}

enum GameType {
    case wordOfTheDay
    case workout
}

class WordleGameViewModel: ObservableObject {
    @Published var guessedWords = [[Letter(),Letter(),Letter(),Letter(),Letter()],
                                   [Letter(),Letter(),Letter(),Letter(),Letter()],
                                   [Letter(),Letter(),Letter(),Letter(),Letter()],
                                   [Letter(),Letter(),Letter(),Letter(),Letter()],
                                   [Letter(),Letter(),Letter(),Letter(),Letter()],
                                   [Letter(),Letter(),Letter(),Letter(),Letter()]
                                   ]
    @Published var languagePrefix = Locale.preferredLanguages[0]
    
    @Published var usedAlphabets: Array<AlphabetStatus> = []
    @Published var keyboardColors: Array<KeyboardColor> = Array<KeyboardColor>(repeating: KeyboardColor(backgroundColorOfKeyboard: .gray, foregroundColorOfKeyboard: .black), count: AlphabetsModel.allAlphabets.count)
    @Published var currentRow = 0
    @Published var currentIndex = 0
    @Published var isSpaceFullInCurrentRow: Bool = false
    @Published var correctLetters: [String] = []
    @Published var misplacedLetters: [String] = []
    @Published var incorrectLetters: [String] = []
    @Published var isRoundEnded: Bool = false
    @Published var gameStatus: String = ""
    @Published var gameMode: GameType = .workout
    
    var secretWord: Array<String> = SecretWordModel.mainSecretWordInstance.secretWord

    func endRound(status: String) {
        print("Ended")
        gameStatus = status
        isRoundEnded = true
    }
    
    func restartGameSession() {
        
        print("Restarted")
        let secretWordManager = SecretWordModel.mainSecretWordInstance
        secretWordManager.generateNewWord { wordChangeStatus in
            if wordChangeStatus {
                DispatchQueue.main.async {
                    
                    self.guessedWords = [[Letter(),Letter(),Letter(),Letter(),Letter()],
                                         [Letter(),Letter(),Letter(),Letter(),Letter()],
                                         [Letter(),Letter(),Letter(),Letter(),Letter()],
                                         [Letter(),Letter(),Letter(),Letter(),Letter()],
                                         [Letter(),Letter(),Letter(),Letter(),Letter()],
                                         [Letter(),Letter(),Letter(),Letter(),Letter()]
                    ]
                    self.keyboardColors = Array<KeyboardColor>(repeating: KeyboardColor(backgroundColorOfKeyboard: .gray, foregroundColorOfKeyboard: .black), count: AlphabetsModel.allAlphabets.count)
                    self.correctLetters = []
                    self.misplacedLetters = []
                    self.incorrectLetters = []
                    self.usedAlphabets = []
                    self.isSpaceFullInCurrentRow = false
                    self.currentIndex = 0
                    self.currentRow = 0
                    self.secretWord = secretWordManager.secretWord
                    self.isRoundEnded = false
                    self.gameStatus = ""
                }
            }
        }
    }
    
    func checkSingleRow() {
                
        let guessedWord: [Letter] = guessedWords[currentRow]
        var availableAlphabets: Array<String> = secretWord

        for (index,alphabet) in guessedWord.enumerated() {
            if secretWord.contains(alphabet.letter) && guessedWord[index].letter == secretWord[index]  {
                guessedWords[currentRow][index].color = Color("Green")
                correctLetters.append(alphabet.letter)
//                keyboardColors[AlphabetsModel.getIndexOfAlphabet(alphabet.letter)] = KeyboardColor(backgroundColorOfKeyboard: .wordleGreen, foregroundColorOfKeyboard: .white)
                availableAlphabets = availableAlphabets.removeFirstInstanceOfString(alphabet.letter)
            }
            
        }
        
        for (index,alphabet) in guessedWord.enumerated() {
            
            if secretWord.contains(alphabet.letter) == false {
                guessedWords[currentRow][index].color = Color("CardAscent")
                incorrectLetters.append(alphabet.letter)
//                keyboardColors[AlphabetsModel.getIndexOfAlphabet(alphabet.letter)] = KeyboardColor(backgroundColorOfKeyboard: .gray, foregroundColorOfKeyboard: .white)

            }
            
            else if secretWord.contains(alphabet.letter) && guessedWord[index].letter != secretWord[index] && availableAlphabets.contains(alphabet.letter) {
                guessedWords[currentRow][index].color = Color("Yellow")
//                keyboardColors[AlphabetsModel.getIndexOfAlphabet(alphabet.letter)] = KeyboardColor(backgroundColorOfKeyboard: .yellow, foregroundColorOfKeyboard: .white)
                availableAlphabets = availableAlphabets.removeFirstInstanceOfString(alphabet.letter)
                misplacedLetters.append(alphabet.letter)
            }
            
            else if secretWord.contains(alphabet.letter) && guessedWord[index].letter != secretWord[index] && availableAlphabets.contains(alphabet.letter) == false {
                guessedWords[currentRow][index].color = Color("CardAscent")
            }
            
        }
        
    }
    
    func isWordAllowed() -> Bool {
        return AllowedWordsModel.checkIfWordIsAllowed(word: guessedWords[currentRow])
    }
    
    func enterButtonIsPressed() -> (GameStatusForManagingDelegate,AlertType?){
//      Go To Next Row, or the game is over
        if currentIndex == 4 && isSpaceFullInCurrentRow == true {
            
            if isWordAllowed() == true {
                checkSingleRow()
//              Do this is you check row 1 through 4
                if currentRow != 5 {
                    
//                    print("guessedWords[currentRow].convertArrayToString() \(guessedWords[currentRow].convertArrayToString())")
//                    print("SecretWordModel.mainSecretWordInstance.secretWordString \(SecretWordModel.mainSecretWordInstance.secretWordString)")
//                  Check if user won
                    var wordString = ""
                    for word in guessedWords[currentRow] {
                        wordString += word.letter
                    }
                    
                    if wordString == SecretWordModel.mainSecretWordInstance.secretWordString {
                        print("In game over")
//                        UNCOMMENT THISS
                        return (.win,nil)
                    }
                    
                    currentRow += 1
                    currentIndex = 0
                    isSpaceFullInCurrentRow = false
                    
                    return (.ignore,nil)
                }
//              Do this if you just checked the last row and now game is over
                else {
                    return (.gameover,nil)
                }
            }
            else {
                return (.alert,.notInList)
            }
        }
        else {
            return (.alert,.incompleteWord)
        }
    }
    
    func backspaceButtonIsPressed() {
        
        isSpaceFullInCurrentRow = false
        if guessedWords[currentRow][currentIndex].letter != "" {
            guessedWords[currentRow][currentIndex].letter = ""
        }
        else {
            if currentIndex != 0 {
                currentIndex -= 1
                guessedWords[currentRow][currentIndex].letter = ""

            }
        }
    }
    
    func alphabetIsSelected(_ alphabet: String) {
        
        if self.isSpaceFullInCurrentRow == true {
            return
        }
        
        self.guessedWords[self.currentRow][self.currentIndex].letter = alphabet
        
        if self.currentIndex == 4 {
            self.isSpaceFullInCurrentRow = true
        }
        else {
            self.currentIndex += 1
        }
    }
    
}
