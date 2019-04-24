//
//  Rules.swift
//  wordgame
//
//  Created by Milo Beckman on 3/14/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation


let noneString = "!NONE"
let errorString = "!ERROR"

class Rules {
    
    let maxMultiplier = 3
    let tilesPerLevel = settings.quickAdvanceMode ? 2 : 7
    
    let timerStart = 20.0
    let timerDecrement = 0.933
    let playSomethingDuration = 0.5
    
    let fairnessAdjustment = 1.0
    
    
    
    func trueLevel(tilesServed: Int) -> Double {
        return Double(tilesServed) / Double(tilesPerLevel) + 1.0
    }
    
    
    func canDrop(tile: Tile, gridTile: Tile) -> Bool {
        switch tile.type {
        case "trash":
            return gridTile.isLetterLike()
        case "life":
            return gridTile.type == "dead"
        default:
            return gridTile.type == "null"
        }
    }
    
    func timerLength(level: Int) -> Double {
        return timerStart * pow(timerDecrement, Double(game.currentLevel-1))
    }
    
    func legalWordPaths(level: Int) -> [[Int]] {
        
        return [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],
                [0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15],
                [0,5,10,15],[12,9,6,3]]
    }
    
    
    
    
    
    
    
    
    /* WHAT'S A WORD */
    
    var wordLists: [Int : [String]]
    
    init() {
        wordLists = [:]
        startLoadingWordLists()
    }
    
    func startLoadingWordLists() {
        
        for length in 3...12 {
            DispatchQueue.main.async {
                self.wordLists[length] = wordListForLength(length: length)
            }
        }
    }
    
    func isWord(word: String) -> Bool {
        
        if settings.allWordCountMode {
            return true
        }
        
        if (3...12).contains(word.count) {
            return wordLists[word.count]!.contains(word)
        }
        
        return false
    }
    
    
    
    /* SCORING */
    
    func scoreForTiles(tiles: [Tile], multiplier: Int = 1) -> Int {
        
        var score = 0
        
        for tile in tiles {
            score += tile.score()
        }
        
        return score * multiplier
    }
    
}