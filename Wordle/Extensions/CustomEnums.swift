//
//  CustomEnums.swift
//  Wordle
//
//  Created by Nikita Velichko on 17/02/22.
//

import SwiftUI


enum WordleColor {
    case gray
    case yellow
    case green
    case edit
    
    static func getCellColor(_ status: WordleColor) -> Color {
        
        switch status {
        case .gray:
            return Color.gray
        case .yellow:
            return Color.yellow
        case .green:
            return Color.green
//      Should never be in .edit, can ignore this case, returning garbage value
        case .edit:
//          Random Value
            return Color.black
        }
    }
}

enum GameStatusForManagingDelegate {
    case alert
    case gameover
    case win
    case ignore
}

enum AlertType {
    case notInList
    case incompleteWord
}
