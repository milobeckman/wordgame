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
    
    var currentStreak: Int
    
    var paused: Bool
    var over: Bool
    
    var tilesDropped: Int
    var tileCounts: [String: Int]
    var wordsCleared: Int
    var longestStreak: Int
    
    init() {
        grid = Grid()
        rack = Rack()
        
        tilesServed = 0 // temp
        currentScore = 0
        currentLevel = 1
        
        paused = false
        over = false
        
        tilesDropped = 0
        tileCounts = [:]
        wordsCleared = 0
        currentStreak = 0
        longestStreak = 0
    }
    
    func currentMultiplier() -> Int {
        let multiplier = currentStreak + 1
        if multiplier > rules.maxMultiplier {
            return rules.maxMultiplier
        } else {
            return multiplier
        }
    }
    
    func scoreWordPaths(wordPaths: [[Int]]) {
        
        if wordPaths.count > 1 {
            currentStreak += 1
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
            
            // temp
            switch currentMultiplier() {
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
            currentStreak = 0
        }
        
        for wordPath in wordPaths {
            scoreWordPath(wordPath: wordPath)
        }
    }
    
    func scoreWordPath(wordPath: [Int]) {
        
        wordsCleared += 1
        
        var tiles = [Tile]()
        for position in wordPath {
            tiles.append(grid.tiles[position])
        }
        
        let score = rules.scoreForTiles(tiles: tiles, multiplier: currentMultiplier())
        currentScore += score
        gameView.showScoreBadge(score: score, wordPath: wordPath)
    }
    
    func tileServer() -> Int {
        tilesServed += 1
        return tilesServed
    }
    
    func updateLevelIfNeeded() {
        let level = Int(rules.trueLevel(tilesServed: tilesServed))
        
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
    
    func addToTilesDropped(tile: Tile) {
        tilesDropped += 1
        
        var tileID = ""
        
        switch tile.type {
        case "letter":
            tileID = String(tile.text.count)
        case "wild":
            tileID = tile.text
        default:
            tileID = "." + tile.type
        }
        
        if let count = tileCounts[tileID] {
            tileCounts[tileID] = count + 1
        } else {
            tileCounts[tileID] = 1
        }
        
    }
    
    func averageWordScore() -> Double {
        if wordsCleared == 0 {
            return 0.0
        }
        
        let avg = Double(currentScore) / Double(wordsCleared)
        return Double(round(10*avg)/10)
    }
    
}
