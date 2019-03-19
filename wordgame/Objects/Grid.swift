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
    
    func clearPositions(positions: [Int]) {
        
    }
    
}
