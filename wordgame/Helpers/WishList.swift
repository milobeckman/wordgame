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
    var lengths: [Int]
    
    var wordPathFullness: [[Int]: Int]
    var emptyPositionForWordPath: [[Int]: Int]
    var clearingChoicesForWordPath: [[Int]: [String]]
    
    var active: Bool
    var upToDate: Bool
    
    
    
    init(grid: Grid, lengths: [Int] = [1]) {
        self.grid = grid
        self.lengths = lengths
        
        wordPathFullness = [:]
        emptyPositionForWordPath = [:]
        clearingChoicesForWordPath = [:]
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            wordPathFullness[wordPath] = 0
        }
        
        active = true
        upToDate = true
    }
    
    func activateIfNeeded() {
        
        if active {
            return
        } else {
            print("activating " + String(lengths[0]))
            setupFromScratch()
            active = true
        }
    }
    
    func setupFromScratch() {
        
        emptyPositionForWordPath = [:]
        clearingChoicesForWordPath = [:]
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            var fullness = 0
            for position in wordPath where grid.tiles[position].isLetterLike() {
                fullness += 1
            }
            
            wordPathFullness[wordPath] = fullness
            updateWordPath(wordPath: wordPath)
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
    
    func clearingChoices(wordPath: [Int], position: Int) -> [String] {
        var choices = [String]()
        
        for length in lengths {
            let pattern = grid.patternForWordPath(wordPath: wordPath, position: position, length: length)
            choices += choicesForWild(pattern: pattern)
        }
        
        return choices
    }
    
    /*
    
    func tileDropped(position: Int) {
        activateIfNeeded()
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            wordPathFullness[wordPath] = wordPathFullness[wordPath]! + 1
            updateWordPath(wordPath: wordPath)
        }
        
        checkIn()
    }
    
    func tileDeleted(position: Int) {
        activateIfNeeded()
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            wordPathFullness[wordPath] = wordPathFullness[wordPath]! - 1
            updateWordPath(wordPath: wordPath)
        }
        
        checkIn()
    }
    
    func wordPathsCleared(wordPaths: [[Int]]) {
        activateIfNeeded()
        
        var allClearedPositions = [Int]()
        for wordPath in wordPaths {
            for position in wordPath where !allClearedPositions.contains(position) {
                allClearedPositions += [position]
            }
        }
        
        update(positions: allClearedPositions, delta: -1)
    }*/
    
    func update(positions: [Int], delta: Int) {
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            for position in wordPath where positions.contains(position) {
                wordPathFullness[wordPath] = wordPathFullness[wordPath]! + delta
            }
            
            updateWordPath(wordPath: wordPath)
        }
        
        checkIn()
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
        var choiceScores = [String: Int]()
        for choice in mostCleared {
            choiceScores[choice] = 0
        }
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            if wordPathFullness[wordPath] == 3 {
                let scoreForThisPath = grid.scoreForWordPath(wordPath: wordPath)
                for choice in mostCleared where clearingChoicesForWordPath[wordPath]!.contains(choice) {
                    choiceScores[choice]! += scoreForThisPath
                }
            }
        }
        
        var highestScoringChoice = choices[0]
        var highestScore = 0
        
        for choice in mostCleared {
            if choiceScores[choice]! > highestScore {
                highestScoringChoice = choice
                highestScore = choiceScores[choice]!
            }
        }
        
        return highestScoringChoice
    }
    
    
    func charm(tile: Tile) -> Tile {
        
        if !upToDate {
            print("not up to date")
            return tile
        }
        
        var numClearedPerChoice = [String: Int]()
        var numClearedPerPosition = [[String: Int]]()
        for _ in 0...15 {
            numClearedPerPosition.append([String: Int]())
        }
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPathFullness[wordPath] == 3 {
            for choice in clearingChoicesForWordPath[wordPath]! {
                
                let position = emptyPositionForWordPath[wordPath]!
                if let count = numClearedPerPosition[position][choice] {
                    numClearedPerPosition[position][choice] = count + 1
                } else {
                    numClearedPerPosition[position][choice] = 1
                }
                
                if let count = numClearedPerChoice[choice] {
                    if count < numClearedPerPosition[position][choice]! {
                        numClearedPerChoice[choice] = numClearedPerPosition[position][choice]!
                    }
                } else {
                    numClearedPerChoice[choice] = numClearedPerPosition[position][choice]!
                }
            }
        }
        
        for i in [3,2,1] {
            for choice in numClearedPerChoice where choice.value == i {
                tile.text = choice.key
                return tile
            }
        }
        
        return tile
    }
    
    
    func checkIn() {
        upToDate = true
        if game.charmed || playtestOptions.alwaysCharmed {
            // charm the tiles ?
        }
        
        if playtestOptions.printWishList {
            printWishList()
        }
    }
    
    
    func printWishList() {
        
        print("WISH LIST:")
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPathFullness[wordPath] == 3 {
            print(String(emptyPositionForWordPath[wordPath]!)
                + ": " + clearingChoicesForWordPath[wordPath]!.description)
        }
        
    }
    
    
    
    
}
