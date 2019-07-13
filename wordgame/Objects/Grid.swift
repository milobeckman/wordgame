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
    
    init() {
        tiles = []
        for _ in 0...15 {
            let newTile = Tile()
            tiles.append(newTile)
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
        
        if word.contains("*") {
            return rules.canBeWord(word: word)
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
        
        if tile.type == "wild" {
            let bestChoice = wishList.bestChoiceForWild(position: position)
            if bestChoice != noneString {
                tile.text = bestChoice
            }
        }
        
        wishList.upToDate = false
        DispatchQueue.global(qos: .userInitiated).async {
            wishList.tileDropped(position: position)
        }
    }
    
    func giveTile(position: Int) {
        tiles[position] = Tile()
        
        wishList.upToDate = false
        DispatchQueue.global(qos: .userInitiated).async {
            wishList.tileDeleted(position: position)
        }
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
        
        wishList.upToDate = false
        DispatchQueue.global(qos: .userInitiated).async {
            wishList.wordPathsCleared(wordPaths: wordPaths)
        }
    }
    
    
    
    /* WILDS */
    
    func chooseAuxiliaryWilds(position: Int, wordPaths: [[Int]]) {
        for wordPath in wordPaths {
            for i in wordPath where i != position && tiles[i].type == "wild" {
                tiles[i].text = anyClearingChoice(position: i, wordPath: wordPath)
            }
        }
    }
    
    func anyClearingChoice(position: Int, wordPath: [Int]) -> String {
        let pattern = patternForWordPath(wordPath: wordPath, position: position)
        
        return choicesForWild(pattern: pattern)[0]
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
  
    func scoreForWordPath(wordPath: [Int]) -> Int {
        
        var tilesInPath = [Tile]()
        for position in wordPath {
            tilesInPath.append(tiles[position])
        }
        
        return rules.scoreForTiles(tiles: tilesInPath)
    }

    func clearPositions(positions: [Int]) {
        for position in positions {
            tiles[position] = Tile()
        }
    }
    
}
