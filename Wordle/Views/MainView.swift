//
//  ContentView.swift
//  Wordle
//
//  Created by Vitaly on 16/02/22.
//

import SwiftUI

enum ScreenType {
    case game
    case settings
}

struct MainScreenView: View {
    @EnvironmentObject var wordleViewModel: KeyboardViewModel
    @EnvironmentObject var wordleGameViewModel: WordleGameViewModel
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    var roundEnded: Bool { wordleGameViewModel.isRoundEnded }
    var isIpad: Bool { UIDevice.current.localizedModel == "iPad" }
    @State var screenType: ScreenType = .settings
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            switch screenType {
            case .settings:
                VStack {
                    Button {
                        wordleGameViewModel.gameMode = .workout
                        screenType = .game
                    } label: {
                        Rectangle()
                            .frame(width: 300, height: 100)
                    }
                    
                    Button {
                        wordleGameViewModel.gameMode = .wordOfTheDay
                        screenType = .game
                    } label: {
                        Rectangle()
                            .frame(width: 300, height: 100)
                    }
                }
            case .game:
                VStack {
                    Spacer()
                    if wordleGameViewModel.gameMode == .workout {
                        TrainingLevelView(isIpad: isIpad)
                    }
                    ZStack {
                        
                        WordsBoardView(data: wordleGameViewModel.guessedWords, isIpad: isIpad)
                        if roundEnded {
                            ResultView(data: wordleGameViewModel.guessedWords, isIpad: isIpad)
                        }
                    }
                    Spacer()
                    if !roundEnded {
                        KeyboardView(isIpad: isIpad, keyboard: wordleGameViewModel.languagePrefix.prefix(2) == "ru" ? wordleViewModel.keyboard : wordleViewModel.keyboardEng)
                        .padding(.bottom, 10)
                    }
                }
            }
            
            
        }
        .onAppear {
            trainingViewModel.level = UserDefaults.standard.integer(forKey: "level")
            trainingViewModel.wordsDone = UserDefaults.standard.integer(forKey: "wordsDone")
            trainingViewModel.wordsNumer = UserDefaults.standard.integer(forKey: "wordsNumer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .previewDevice("iPhone 11")
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
            .environmentObject(TrainingViewModel())
            .preferredColorScheme(.light)
        MainScreenView()
            .previewDevice("iPhone 11")
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
            .environmentObject(TrainingViewModel())
            .preferredColorScheme(.dark)
        MainScreenView()
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
            .environmentObject(TrainingViewModel())
            .preferredColorScheme(.light)
    }
}
