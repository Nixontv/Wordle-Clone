//
//  WordleViewModel.swift
//  Wordle
//
//  Created by Vlad Likh on 17.02.2022.
//

import Foundation
import SwiftUI





class KeyboardViewModel: ObservableObject {
    @Published var keyHaptic = UIImpactFeedbackGenerator(style: .soft)
    @Published var keyboard = [["й","ц","у","к","е","н","г","ш","щ","з","х"],
                               ["ф","ы","в","а","п","р","о","л","д","ж","э"],
                               ["я","ч","с","м","и","т","ь","б","ю"],
                               ["Проверить"]]
    @Published var keyboardEng = [["q","w","e","r","t","y","u","i","o","p"],
                               ["a","s","d","f","g","h","j","k","l"],
                               ["z","x","c","v","b","n","m"],
                               ["Check"]]
}
