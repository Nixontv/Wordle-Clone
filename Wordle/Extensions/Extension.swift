//
//  Extension.swift
//  Wordle
//
//  Created by Vlad Likh on 17.02.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let wordleRed = Color(red: 223 / 255, green: 80 / 255, blue: 80 / 255)
    static let wordlePaper = Color(red: 248 / 255, green: 248 / 255, blue: 234 / 255)
    static let wordleGreen = Color(red: 45 / 255, green: 190 / 255, blue: 156 / 255)
}

extension Array where Element == String {
    
    func convertArrayToString() -> String {
        
        var str: String = ""
        
        for alphabet in self {
            str.append(alphabet)
        }
        
        return str
    }
    
    func removeFirstInstanceOfString(_ givenString: String) -> Array<String> {
        var newArr: Array<String> = []
        var isFirstElementFound: Bool = false
        
        for item in self {
            if givenString != item {
                newArr.append(item)
            }
            if givenString == item {
                if isFirstElementFound == false {
                    isFirstElementFound = true
                    continue
                }
                else {
                    newArr.append(item)
                }
            }
        }
        return newArr
    }
    
}

extension Date {
    static func from(year: Int, month: Int, day: Int, hour: Int, minute: Int, timeZone: String) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone(abbreviation: timeZone) // Japan Standard Time
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        return calendar.date(from: dateComponents) ?? nil
    }
}
