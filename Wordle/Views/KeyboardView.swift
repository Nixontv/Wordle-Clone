//
//  KeyboardView.swift
//  Wordle
//
//  Created by Vlad Likh on 17.02.2022.
//

import SwiftUI

struct KeyboardView: View {
    @EnvironmentObject var wordleViewModel: KeyboardViewModel
    var isIpad: Bool = false
    var keyboard: [[String]]
    var buttonWidth: Int {
        if isIpad {
            return (Int(UIScreen.main.bounds.width) - ((keyboard[0].count + 1 + 20) * 5)) / keyboard[0].count
        } else {
         return (Int(UIScreen.main.bounds.width) - ((keyboard[0].count + 1) * 5)) / keyboard[0].count
        }
    }
    var spacing = 5.0
    var body: some View {
        VStack(spacing: 9.0) {
            HStack(spacing: spacing) {
                ForEach(keyboard[0], id: \.self) { item in
                    ButtonView(letter: item, buttonWidth: buttonWidth)
                }
            }
            HStack(spacing: spacing) {
                ForEach(keyboard[1], id: \.self) { item in
                    ButtonView(letter: item, buttonWidth: buttonWidth)
                }
            }
            HStack(spacing: spacing) {
                ForEach(keyboard[2], id: \.self) { item in
                    ButtonView(letter: item, buttonWidth: buttonWidth)
                }
                RemoveButtonView(buttonWidth: buttonWidth)
            }
            ReturnButtonView(buttonWidth: buttonWidth, keyboardWidth: keyboard[2].count + 2, returnTitle: keyboard[3][0])
        }
//        .padding(UIScreen.main.bounds.width/20)
    }
}

struct ButtonView: View {
    @EnvironmentObject var wordleViewModel: KeyboardViewModel
    @EnvironmentObject var wordleGameViewModel: WordleGameViewModel
    var letter: String
    var color: Color {
        if wordleGameViewModel.correctLetters.contains(letter) {
            return Color("Green")
        } else if wordleGameViewModel.misplacedLetters.contains(letter) {
            return Color("Yellow")
        } else if wordleGameViewModel.incorrectLetters.contains(letter) {
            return Color("ButtonAscent")
        } else {
            return Color("Button")
        }
    }
    var buttonWidth: Int
    var body: some View {
        Button {
            wordleGameViewModel.alphabetIsSelected(letter)
            wordleViewModel.keyHaptic.impactOccurred()
        } label: {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .foregroundColor(color)
                .frame(width: CGFloat(buttonWidth), height: 46)
                .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 1)
//                .overlay(
//                    VStack {
//                        Spacer()
//                        RoundedRectangle(cornerRadius: 5, style: .continuous)
//                            .foregroundColor(color)
//                            .frame(width: CGFloat(buttonWidth) - 10, height: 3)
//                            .padding(4)
//                    }
//                )
                .overlay(
                    Text(letter)
                        .font(.system(size: 25, weight: .regular))
                        .foregroundColor(Color("ButtonText"))
                        .padding(.bottom, 3)
                )
        }
            
    }
}

struct ReturnButtonView: View {
    var buttonWidth: Int
    var keyboardWidth: Int
    var returnTitle: String
    var returnWidth: CGFloat { CGFloat(CGFloat(((keyboardWidth) * buttonWidth) + ((keyboardWidth - 1) * 5))) }
    @EnvironmentObject var wordleViewModel: KeyboardViewModel
    @EnvironmentObject var wordleGameViewModel: WordleGameViewModel
//    @EnvironmentObject var secretWordModel: SecretWordModel
    @State private var showingAlert = false
    @State private var gameStatusState: GameStatusForManagingDelegate = .ignore
    var body: some View {
        Button {
            let (gameStatus,_) = wordleGameViewModel.enterButtonIsPressed()
            switch gameStatus {
                case .alert:
                    print("Alert")
                    gameStatusState = .alert
                    showingAlert = true
//                    wordleGameViewModel.endRound()
                case .gameover:
//                    wordleGameViewModel.restartGameSession()
                    print("Alert")
                    gameStatusState = .gameover
                wordleGameViewModel.endRound(status: wordleGameViewModel.languagePrefix.prefix(2) == "ru" ? "Это было слово\n «\(SecretWordModel.mainSecretWordInstance.secretWordString)»" : "This word was\n «\(SecretWordModel.mainSecretWordInstance.secretWordString)»")
                case .ignore:
                    return
                case .win:
//                    wordleGameViewModel.restartGameSession()
                    print("Alert")
                    gameStatusState = .win
                wordleGameViewModel.endRound(status: wordleGameViewModel.languagePrefix.prefix(2) == "ru" ? "Победа!" : "Win!")
            }
            wordleViewModel.keyHaptic.impactOccurred()
        } label: {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .foregroundColor(Color("ButtonAscent"))
//                .foregroundColor(wordleGameViewModel.isSpaceFullInCurrentRow ? Color("Green") : Color("ButtonSubFill"))
                .frame(width: returnWidth, height: 52)
                .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 1)
                .overlay(
                    Text(returnTitle)
                        .font(.system(size: 18, weight: .medium))
//                        .foregroundColor(wordleGameViewModel.isSpaceFullInCurrentRow ? .white : Color("ButtonText"))
                        .foregroundColor(Color("ButtonText"))
                        .padding(.bottom, 2)
                )
        }
        .alert(isPresented: $showingAlert) {
//            var message = ""
//            switch gameStatusState {
//            case .alert:
            let message = wordleGameViewModel.languagePrefix.prefix(2) == "ru" ? "Такого слова не существует" : "There is no such word."
//            case .win:
//                message = "You Win"
//            case .ignore:
//                message = ""
//            case .gameover:
//                message = "You loose"
//            }
            return Alert(
                        title: Text(""),
                        message: Text(message)
                    )
                }
    }
}

struct RemoveButtonView: View {
    var buttonWidth: Int
    @EnvironmentObject var wordleViewModel: KeyboardViewModel
    @EnvironmentObject var wordleGameViewModel: WordleGameViewModel
    var body: some View {
        Button {
            wordleGameViewModel.backspaceButtonIsPressed()
            wordleViewModel.keyHaptic.impactOccurred()
        } label: {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .foregroundColor(Color("ButtonAscent"))
                .frame(width: CGFloat(buttonWidth * 2 + 5), height: 46)
                .shadow(color: .black.opacity(0.3), radius: 0, x: 0, y: 1)
                .overlay(
                    Image(systemName: "delete.left")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(Color("ButtonText"))
                        .padding(.bottom, 0)
                        .padding(.trailing, 3)
                )
        }
    }
}
    


struct ContentView_Previews_Keyboard: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
            .preferredColorScheme(.dark)
        MainScreenView()
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
            .preferredColorScheme(.light)
//        MainScreenView()
//            .previewDevice("iPad Pro (11-inch) (3rd generation)")
//            .preferredColorScheme(.dark)
//            .environmentObject(KeyboardViewModel())
//            .environmentObject(WordleGameViewModel())
    }
}
