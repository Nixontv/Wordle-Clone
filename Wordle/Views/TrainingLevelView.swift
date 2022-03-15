//
//  TrainingLevelView.swift
//  Wordle
//
//  Created by Vlad Likh on 17.02.2022.
//

import SwiftUI

struct TrainingLevelView: View {
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    var isIpad: Bool = false
    var currentLevel: Int { trainingViewModel.level }
    var paddingSize: Double { isIpad ? UIScreen.main.bounds.height/8 : UIScreen.main.bounds.height/23 }
    var levelWidth: Double { UIScreen.main.bounds.width - paddingSize * 2 }
    var color: Color {
        if trainingViewModel.level < 10 {
            return(Color("Green"))
        } else if trainingViewModel.level < 20 {
            return(Color("Yellow"))
        } else {
            return(Color("Red"))
        }
    }
    var body: some View {
        HStack(spacing: 5) {
            ZStack {
                ZStack(alignment: .leading) {
                    Rectangle().frame( height: 30)
                            .foregroundColor(Color("Card"))
                        
                    Rectangle().frame(width: levelWidth/Double(trainingViewModel.level+1) * Double(trainingViewModel.wordsDone), height: 30)
                            .foregroundColor(color)
                } .cornerRadius(4)
                
                Text("LEVEL \(currentLevel)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color("ButtonText"))
             }
            .onTapGesture {
                trainingViewModel.newWordDone()
            }
                                     
        }
        .padding(.bottom, 30)
        .padding(.horizontal, paddingSize)
    }
}

struct ContentView_TrainingPreviews: PreviewProvider {
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
            .preferredColorScheme(.light)
            .environmentObject(KeyboardViewModel())
            .environmentObject(WordleGameViewModel())
            .environmentObject(TrainingViewModel())
    }
}
