//
//  ResultView.swift
//  Wordle
//
//  Created by Vladislav Likh on 17/02/22.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var wordleGameViewModel: WordleGameViewModel
    var data: [[Letter]] = [[Letter(),Letter(),Letter(),Letter(),Letter()],
                            [Letter(),Letter(),Letter(),Letter(),Letter()],
                            [Letter(),Letter(),Letter(),Letter(),Letter()],
                            [Letter(),Letter(),Letter(),Letter(),Letter()],
                            [Letter(),Letter(),Letter(),Letter(),Letter()],
                            [Letter(),Letter(),Letter(),Letter(),Letter()]
                            ]
    var isIpad = false
    var body: some View {
        ZStack {
//            Color.black.ignoresSafeArea()
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(Color("BackgroundResult"))
                    .aspectRatio(0.8, contentMode: .fit)
                    .overlay(
                        VStack {
                            HStack(alignment: .center) {
                                Text(wordleGameViewModel.gameStatus)
                                    .font(.system(size: 25, weight: .bold))
                                    .foregroundColor(Color("ButtonText"))
                                Spacer()
                                Text ("\(wordleGameViewModel.currentRow + 1)/6")
                                    .font(.system(size: 18, weight: .regular))
                            }
                            Spacer()
                            ResultImageView(data: data, isIpad: isIpad)
                            Spacer()
                            Button {wordleGameViewModel.restartGameSession()} label : {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .foregroundColor(Color("Green"))
                                    .frame(height: 60)
                                    
                                    .overlay(
                                        Text(wordleGameViewModel.languagePrefix.prefix(2) == "ru" ? "Следующее слово" : "Next word")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .semibold))
                                    )
                            }
                        }.padding(isIpad ? 20 : 20)
                        )
            }
            .padding(.horizontal, isIpad ? UIScreen.main.bounds.height/8 : UIScreen.main.bounds.height/23)
        }
    }
}

struct ResultImageView: View {
    var data: [[Letter]]
    var isIpad = false
    var body: some View {
        VStack(spacing: 5) {
            ForEach(0..<6) { row in
                HStack(spacing: 5) {
                    ForEach(0..<5) { column in
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .aspectRatio(1, contentMode: .fit)
                            .foregroundColor(data[row][column].color)
                    }
                }
            }
        }
        .padding(isIpad ? 70 : 20)
        
    }
}

struct ContentView_Results: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .previewDevice("iPhone 11")
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
            .preferredColorScheme(.light)
        MainScreenView()
            .previewDevice("iPhone 11")
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
            .preferredColorScheme(.dark)
//        MainScreenView()
//            .previewDevice("iPad Pro (11-inch) (3rd generation)")
//            .preferredColorScheme(.light)
//            .environmentObject(KeyboardViewModel())
//            .environmentObject(WordleGameViewModel())
    }
}
