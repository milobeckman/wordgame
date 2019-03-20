//
//  Grid.swift
//  wordgame
//
//  Created by Milo Beckman on 3/12/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

class Grid {
    
    var tiles : [Tile]
    
    init() {
        
        tiles = []
        for _ in 0...15 {
            let tile = Tile(type: "null", text: "")
            tiles.append(tile)
        }
        
    }
    
    func wordPathsToClear() -> [[Int]] {
        let legalWordPaths = rules.legalWordPaths(level: game.currentLevel)
        var wordPathsToClear = [[Int]]()
        
        for wordPath in legalWordPaths {
            if wordPathShouldClear(wordPath: wordPath) {
                wordPathsToClear.append(wordPath)
            }
        }
        
        return wordPathsToClear
    }
    
    func wordPathShouldClear(wordPath: [Int]) -> Bool {
        var word = ""
        for i in wordPath {
            if tiles[i].type == "letter" || tiles[i].type == "wild" {
                word += tiles[i].text
            } else {
                return false
            }
        }
        
        return rules.isWord(word: word)
    }
    
    func stringForWordPath(wordPath: [Int]) -> String {
        var word = ""
        for i in wordPath {
            if tiles[i].type == "letter" || tiles[i].type == "wild" {
                word += tiles[i].text
            } else {
                return ""
            }
        }
        
        return word
    }
    
    func patternForWordPath(wordPath: [Int], position: Int) -> String {
        var word = ""
        for i in wordPath {
            if i == position {
                word += String(repeating: "?", count: tiles[i].text.count)
            } else if tiles[i].type == "letter" || tiles[i].type == "wild" {
                word += tiles[i].text
            } else {
                return ""
            }
        }
        
        return word
    }
    
    func bestChoiceForWild(position: Int) -> String {
        
        var choices = [String]()
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            if wordPath.contains(position) {
                let pattern = patternForWordPath(wordPath: wordPath, position: position)
                if pattern != "" {
                    choices += choicesForWild(pattern: pattern)
                }
            }
        }
        
        print(choices)
        
        if choices.count == 0 {
            return "none" /// TEMP
        }
        
        // most words cleared
        let mostCleared = modes(array: choices)
        if mostCleared.count == 1 {
            return mostCleared[0]
        }
        
        // highest score (tiebreak)
        // TEMP -- no tiebreak, just first in list
        return mostCleared[0]
    }
    
    func clearPositions(positions: [Int]) {
        
    }
    
}
