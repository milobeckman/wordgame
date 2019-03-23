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
    
    var over: Bool
    
    init() {
        grid = Grid()
        rack = Rack()
        
        tilesServed = 0
        currentScore = 0
        currentLevel = 1
        
        currentMultiplier = 1
        
        over = false
    }
    
    func scoreWordPaths(wordPaths: [[Int]]) {
        
        if wordPaths.count > 1 {
            if currentMultiplier < rules.maxMultiplier {
                currentMultiplier += 1
            }
            
            // temp
            switch currentMultiplier {
            case 2:
                print("CROSS BONUS!   x2")
            case 3:
                print("CROSS COMBO!   x3")
            case 4:
                print("TRIPLE COMBO!  x4")
            case 5:
                print("COMBO MAX!     x5")
            default:
                print("error")
            }
            
        } else {
            currentMultiplier = 1
        }
        
        for wordPath in wordPaths {
            scoreWordPath(wordPath: wordPath)
        }
    }
    
    func scoreWordPath(wordPath: [Int]) {
        var tiles = [Tile]()
        for position in wordPath {
            tiles.append(grid.tiles[position])
        }
        
        let score = rules.scoreForTiles(tiles: tiles, multiplier: currentMultiplier)
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
    
    func checkIfGameOver() {
        
        if numDeadTiles() + numFullTiles() == 16 {
            for tile in rack.tiles {
                if tile.type == "trash" {
                    return
                }
            }
            
            if numDeadTiles() > 0 {
                for tile in rack.tiles {
                    if tile.type == "life" {
                        return
                    }
                }
            }
            
            over = true
            gameView.gameOver()
        }
        
    }
    
}
