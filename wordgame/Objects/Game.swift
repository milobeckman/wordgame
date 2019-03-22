//
//  Game.swift
//  wordgame
//
//  Created by Milo Beckman on 3/12/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

class Game {
    
    var grid: Grid
    var rack: Rack
    
    var tilesServed: Int
    var currentScore: Int
    var currentLevel: Int
    
    var currentMultiplier: Int
    
    init() {
        grid = Grid()
        rack = Rack()
        
        tilesServed = 0
        currentScore = 0
        currentLevel = 0
        
        currentMultiplier = 1
    }
    
    func scoreWordPaths(wordPaths: [[Int]]) {
        
        if wordPaths.count > 1 {
            if currentMultiplier < rules.maxMultiplier {
                currentMultiplier += 1
            }
        } else {
            currentMultiplier = 1
        }
        
        for wordPath in wordPaths {
            scoreWordPath(wordPath: wordPath)
        }
        
        print("TOTAL:" + String(currentScore))
    }
    
    func scoreWordPath(wordPath: [Int]) {
        var tiles = [Tile]()
        for position in wordPath {
            tiles.append(grid.tiles[position])
        }
        
        let score = rules.scoreForTiles(tiles: tiles, multiplier: currentMultiplier)
        print("+" + String(score))
        currentScore += score
    }
    
    func tileServer() -> Int {
        tilesServed += 1
        return tilesServed
    }
    
    func updateLevelIfNeeded() {
        let level = Int((tilesServed-4) / rules.tilesPerLevel) + 1
        if level > currentLevel {
            currentLevel = level
        }
    }
    
    func numDeadTiles() -> Int {
        var count = 0
        for tile in grid.tiles {
            if tile.type == "dead" {
                count += 1
            }
        }
        
        return count
    }
    
    func numFullTiles() -> Int {
        var count = 0
        for tile in grid.tiles {
            if tile.isLetterLike() {
                count += 1
            }
        }
        
        return count
    }
    
}
