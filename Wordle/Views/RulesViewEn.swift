//
//  RulesView.swift
//  Wordle
//
//  Created by Vitaly on 17/02/22.
//

import SwiftUI

struct RulesViewEn: View {
    
    let rightPosition: [String] = ["I", "N", "T", "E", "R"]
    let wrongPosition: [String] = ["A", "I", "R", "E", "D"]
    let notInWord: [String] = ["F", "U", "N", "N", "Y"]
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Guess the word to win")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
                VStack {
                    HStack {
                        ForEach(rightPosition, id: \.self) { letter in
                            if letter == "I" {
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
                    Text("The letter 'I' is in the right spot")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                }
                .padding(.bottom, 40)
                
                VStack {
                    HStack {
                        ForEach(wrongPosition, id: \.self) { letter in
                            if letter == "I" {
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
                    Text("The letter 'R' is in the wrong spot")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                }
                .padding(.bottom, 40)
                
                VStack {
                    HStack {
                        ForEach(notInWord, id: \.self) { letter in
                            if letter == "Y" {
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
                    Text("The letter 'Y' is not in the word at all")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                }
                Spacer()
            }
            .padding(UIScreen.main.bounds.width/10)
        }
    }
}

struct RulesViewEn_Previews: PreviewProvider {
    static var previews: some View {
        RulesViewEn()
            .preferredColorScheme(.dark)
        RulesViewEn()
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
            .preferredColorScheme(.dark)
            .environmentObject(KeyboardViewModel())
    }
}
