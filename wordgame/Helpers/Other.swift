//
//  Other.swift
//  wordgame
//
//  Created by Milo Beckman on 3/18/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation


func randomDouble() -> Double {
    let max = 1000000
    let rand = Int(arc4random_uniform(UInt32(max)))
    return Double(rand)/Double(max)
}

func randomElement(array: [Int]) -> Int {
    let rand = Int(randomDouble()*Double(array.count))
    return array[rand]
}


// "*u??d" -> ["mi", "ri", "be", ...]
func choicesForWild(pattern: String) -> [String] {
    
    var choices = [String]()
    let patternList = Array(pattern)
    
    for word in allPatternFits(pattern: pattern) {
        let wordList = Array(word)
        var choice = ""
        
        for i in 0..<patternList.count {
            if patternList[i] == "?" {
                choice += String(wordList[i])
            }
        }
        
        choices.append(choice)
    }
    
    return unique(array: choices)
}

// "*u??d" -> ["humid", "lurid", "cubed", ...]
func allPatternFits(pattern: String) -> [String] {
    
    var fits = [String]()
    
    if let wordList = rules.wordLists[pattern.count] {
        let regex = pattern.replacingOccurrences(of: "?", with: "[a-z]").replacingOccurrences(of: "*", with: "[a-z]")
        for word in wordList {
            if word.range(of: regex, options: .regularExpression) != nil {
                fits.append(word)
            }
        }
    }
    
    return fits
}


func modes(array: [String]) -> [String] {
    
    var maxCount = 0
    var modes = [String]()
    
    let countedSet = NSCountedSet(array: array)
    for str in array {
        let count = countedSet.count(for: str)
        if count > maxCount {
            maxCount = count
            modes = [str]
        } else if count == maxCount && !modes.contains(str) {
            modes.append(str)
        }
    }
    
    return modes
}

func unique(array: [String]) -> [String] {
    
    var uniques = [String]()
    for s in array {
        if !uniques.contains(s) {
            uniques.append(s)
        }
    }
    
    return uniques
    
    
}
