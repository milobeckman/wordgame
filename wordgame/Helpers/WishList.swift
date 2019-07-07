//
//  WishList.swift
//  wordgame
//
//  Created by Milo Beckman on 6/26/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation




class WishList {
    
    var grid: Grid
    
    var wordPathFullness: [[Int]: Int]
    var emptyPositionForWordPath: [[Int]: Int]
    var clearingChoicesForWordPath: [[Int]: [String]]
    
    
    
    init(grid: Grid) {
        self.grid = grid
        
        wordPathFullness = [:]
        emptyPositionForWordPath = [:]
        clearingChoicesForWordPath = [:]
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            wordPathFullness[wordPath] = 0
        }
    }
    
    func updateWordPath(wordPath: [Int]) {
        if wordPathFullness[wordPath] != 3 {
            emptyPositionForWordPath[wordPath] = nil
            clearingChoicesForWordPath[wordPath] = nil
        }
            
        // created a 3
        else {
            for i in wordPath {
                if grid.tiles[i].type == "null" {
                    emptyPositionForWordPath[wordPath] = i
                    clearingChoicesForWordPath[wordPath] = clearingChoices(wordPath: wordPath, position: i)
                }
            }
        }
    }
    
    func clearingChoices(wordPath: [Int], position: Int, lengths: [Int] = [1]) -> [String] {
        var choices = [String]()
        
        for length in lengths {
            let pattern = grid.patternForWordPath(wordPath: wordPath, position: position, length: length)
            choices += choicesForWild(pattern: pattern)
        }
        
        return choices
    }
    
    
    
    func tileDropped(position: Int) {
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            wordPathFullness[wordPath] = wordPathFullness[wordPath]! + 1
            updateWordPath(wordPath: wordPath)
        }
        
        printWishList()
    }
    
    func tileDeleted(position: Int) {
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            wordPathFullness[wordPath] = wordPathFullness[wordPath]! - 1
            updateWordPath(wordPath: wordPath)
        }
        
        printWishList()
    }
    
    func wordPathsCleared(wordPaths: [[Int]]) {
        var allClearedPositions = [Int]()
        for wordPath in wordPaths {
            for position in wordPath where !allClearedPositions.contains(position) {
                allClearedPositions += [position]
            }
        }
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            for position in wordPath where allClearedPositions.contains(position) {
                wordPathFullness[wordPath] = wordPathFullness[wordPath]! - 1
            }
            
            updateWordPath(wordPath: wordPath)
        }
        
        printWishList()
    }
    
    
    
    func bestChoiceForWild(position: Int) -> String {
        var choices = [String]()
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            if wordPathFullness[wordPath] == 3 {
                choices += clearingChoicesForWordPath[wordPath]!
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
            let score = grid.scoreForChoice(choice: choice, position: position)
            if score > highestScore {
                highestScoringChoice = choice
                highestScore = score
            }
        }
        
        return highestScoringChoice
    }
    
    
    
    func printWishList() {
        
        print("WISH LIST:")
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPathFullness[wordPath] == 3 {
            print(String(emptyPositionForWordPath[wordPath]!)
                + ": " + clearingChoicesForWordPath[wordPath]!.description)
        }
        
    }
    
    
    
    
}
