//
//  WordleApp.swift
//  Wordle
//
//  Created by Vitaly on 16/02/22.
//

import SwiftUI

@main
struct WordleApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreenView()
                .environmentObject(KeyboardViewModel())
                .environmentObject(WordleGameViewModel())
        }
    }
}
