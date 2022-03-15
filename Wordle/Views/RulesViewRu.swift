//
//  RulesView.swift
//  Wordle
//
//  Created by Vitaly on 17/02/22.
//

import SwiftUI

struct RulesViewRu: View {
    
    let rightPosition: [String] = ["Р", "У", "П", "О", "Р"]
    let wrongPosition: [String] = ["Г", "И", "Е", "Н", "А"]
    let notInWord: [String] = ["К", "О", "Л", "О", "С"]
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Угадай слово, чтобы победить")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
                VStack {
                    HStack {
                        ForEach(rightPosition, id: \.self) { letter in
                            if letter == "У" {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3)
                                        .aspectRatio(1, contentMode: .fit)
                                        .foregroundColor(.green)
                                    Text("\(letter)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold))
                                }
                            } else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3)
                                        .foregroundColor(.white)
                                        .aspectRatio(1, contentMode: .fit)
                                    Text("\(letter)")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .semibold))
                                }
                            }
                        }
                    }
                    .padding(.bottom, 16)
                    Text("Буква «У» расположена в правильной позиции")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                }
                .padding(.bottom, 40)
                
                VStack {
                    HStack {
                        ForEach(wrongPosition, id: \.self) { letter in
                            if letter == "И" {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3)
                                        .aspectRatio(1, contentMode: .fit)
                                        .foregroundColor(.yellow)
                                    Text("\(letter)")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .semibold))
                                }
                            } else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3)
                                        .foregroundColor(.white)
                                        .aspectRatio(1, contentMode: .fit)
                                    Text("\(letter)")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .semibold))
                                }
                            }
                        }
                    }
                    .padding(.bottom, 16)
                    Text("Буква «И» присутствует в слове, но расположена неверно")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                }
                .padding(.bottom, 40)
                
                VStack {
                    HStack {
                        ForEach(notInWord, id: \.self) { letter in
                            if letter == "Л" {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3)
                                        .aspectRatio(1, contentMode: .fit)
                                        .foregroundColor(.gray)
                                    Text("\(letter)")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold))
                                }
                            } else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3)
                                        .foregroundColor(.white)
                                        .aspectRatio(1, contentMode: .fit)
                                    Text("\(letter)")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .semibold))
                                }
                            }
                        }
                    }
                    .padding(.bottom, 16)
                    Text("Буквы «Л» в загаданном слове нет совсем")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                }
                Spacer()
            }
            .padding(UIScreen.main.bounds.width/10)
        }
    }
}

struct RulesViewRu_Previews: PreviewProvider {
    static var previews: some View {
        RulesViewRu()
            .preferredColorScheme(.dark)
        RulesViewRu()
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .preferredColorScheme(.dark)
            .environmentObject(KeyboardViewModel())
    }
}
