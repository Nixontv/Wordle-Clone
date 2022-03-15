//
//  WordsBoardView.swift
//  Wordle
//
//  Created by Vlad Likh on 17.02.2022.
//

import Foundation
import SwiftUI

struct WordsBoardView: View {
    @EnvironmentObject var wordleGameViewModel: WordleGameViewModel
    var data: [[Letter]]
    var isIpad: Bool = false
    var body: some View {
        VStack(spacing: 6.0) {
            ForEach(0..<6) { row in
                HStack(spacing: 6.0) {
                    ForEach(data[row], id: \.id) { item in
                        LetterView(letter: item.letter, color: item.color)
                    }
                }
            }
        }
        .padding(.horizontal, isIpad ? UIScreen.main.bounds.height/8 : UIScreen.main.bounds.height/23)
    }
}

struct LetterView: View {
    var letter: String
    var color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
            .foregroundColor(color)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                Text(letter.uppercased())
                    .font(.system(size: UIScreen.main.bounds.width/12, weight: .semibold))
                    .foregroundColor(Color("ButtonText"))
            )
    }
}

struct ContentView_Previews_Board: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
            .preferredColorScheme(.light)
        MainScreenView()
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
            .preferredColorScheme(.dark)
        MainScreenView()
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .preferredColorScheme(.dark)
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
    }
}
