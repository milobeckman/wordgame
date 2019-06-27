//
//  Grid.swift
//  wordgame
//
//  Created by Milo Beckman on 3/12/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

class Grid {
    
    var tiles: [Tile]
    
    var savedChoicesForWilds: [String]
    
    init() {
        tiles = []
        
        savedChoicesForWilds = []
        for _ in 0...15 {
            let tile = Tile(type: "null", text: "")
            tiles.append(tile)
            savedChoicesForWilds.append("*")
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
            if tiles[i].isLetterLike() {
                word += tiles[i].text
            } else {
                return false
            }
        }
        
        return rules.isWord(word: word)
    }
    
    func wordPathIsFull(wordPath: [Int]) -> Bool {
        for i in wordPath {
            if !tiles[i].isLetterLike() {
                return false
            }
        }
        
        return true
    }
    
    
    func takeTile(tile: Tile, position: Int) {
        tiles[position] = tile
        wishList.tileDropped(position: position)
    }
    
    func giveTile(position: Int) {
        tiles[position] = Tile()
        wishList.tileDeleted(position: position)
    }
    
    func clearWordPaths(wordPaths: [[Int]]) {
        var gridPositions = [Int]()
        for wordPath in wordPaths {
            for i in wordPath {
                if !gridPositions.contains(i) {
                    gridPositions.append(i)
                }
            }
        }
        
        clearPositions(positions: gridPositions)
        wishList.wordPathsCleared(wordPaths: wordPaths)
    }
    
    
    
    /* WILDS */
    
    func optimizeWilds(position: Int) {
        var activeWordPaths = [[Int]]()
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            if wordPath.contains(position) && wordPathIsFull(wordPath: wordPath) {
                activeWordPaths.append(wordPath)
            }
        }
        
        if activeWordPaths.count == 0 {
            return
        }
        
        // optimize active position first, then all
        optimizeWildAtPosition(position: position)
        for wordPath in activeWordPaths {
            for i in wordPath {
                if i != position {
                    optimizeWildAtPosition(position: i)
                }
            }
        }
    }
    
    func optimizeWildAtPosition(position: Int) {
        if tiles[position].type != "wild" {
            return
        }
        
        let bestChoice = bestChoiceForWild(position: position)
        if bestChoice != noneString {
            tiles[position].text = bestChoice
        }
    }
    
    func patternForWordPath(wordPath: [Int], position: Int, length: Int=1) -> String {
        var word = ""
        for i in wordPath {
            if i == position {
                for _ in 0..<length {
                    word += "?"
                }
            } else if tiles[i].isLetterLike() {
                word += tiles[i].text
            } else {
                return noneString
            }
        }
        
        return word
    }
    
    func wordForWordPathWithChoice(wordPath: [Int], position: Int, choice: String) -> String {
        var word = ""
        for i in wordPath {
            if i == position {
                word += choice
            } else if tiles[i].isLetterLike() {
                word += tiles[i].text
            } else {
                return noneString
            }
        }
        
        return word
    }
    
    func bestChoiceForWild(position: Int) -> String {
        
        if savedChoicesForWilds[position] != "*" {
            return savedChoicesForWilds[position]
        }
        
        var choices = [String]()
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            if wordPath.contains(position) {
                let pattern = patternForWordPath(wordPath: wordPath, position: position)
                if pattern != noneString {
                    choices += choicesForWild(pattern: pattern)
                }
            }
        }
        
        if choices.count == 0 {
            // no way to clear this wild
            return noneString
        }
        
        // most words cleared
        let mostCleared = modes(array: choices)
        if mostCleared.count == 1 {
            return mostCleared[0]
        }
        
        // highest score (tiebreak)
        var highestScoringChoice = choices[0]
        var highestScore = 0
        
        for choice in choices {
            let score = scoreForChoice(choice: choice, position: position)
            if score > highestScore {
                highestScoringChoice = choice
                highestScore = score
            }
        }
        
        return highestScoringChoice
    }
    
    func scoreForChoice(choice: String, position: Int) -> Int {
        var score = 0
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            if wordPath.contains(position) {
                let word = wordForWordPathWithChoice(wordPath: wordPath, position: position, choice: choice)
                if word != noneString && rules.canBeWord(word: word) {
                    for tilePosition in wordPath {
                        score += tiles[tilePosition].score()
                    }
                }
            }
        }
        
        return score
    }
    
    func clearingPathsForChoice(choice: String, position: Int) -> [[Int]] {
        var clearingPaths = [[Int]]()
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            let word = wordForWordPathWithChoice(wordPath: wordPath, position: position, choice: choice)
            if word != noneString && rules.canBeWord(word: word) {
                clearingPaths += [wordPath]
            }
        }
        
        return clearingPaths
    }
    
    func clearPositions(positions: [Int]) {
        for position in positions {
            tiles[position] = Tile()
        }
    }
    
    /* pre-decide what wilds should be, for better runtime performance */
    
    func preemptWildDrop(position: Int) {
        if savedChoicesForWilds[position] != "*" {
            return
        }
        
        DispatchQueue.main.async {
            let choice = self.bestChoiceForWild(position: position)
            if choice != noneString {
                self.savedChoicesForWilds[position] = choice
            }
        }
    }
    
    func wipeSavesAfterDrop(position: Int) {
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            for i in wordPath where game.grid.tiles[i].type == "null" {
                savedChoicesForWilds[i] = "*"
            }
        }
    }
    
    func wipeAllSaves() {
        for i in 0...15 {
            savedChoicesForWilds[i] = "*"
        }
    }
    
}
