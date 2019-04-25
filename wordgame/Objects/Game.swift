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
    
    // for luck adjustment
    var tileCounts: [String: Double]
    var expectedTileCounts: [String: Double]
    
    // stats
    var tilesDropped: Int
    var wordsCleared: Int
    var longestStreak: Int
    var wordData: [[String]]
    
    init() {
        grid = Grid()
        rack = Rack()
        
        tilesServed = 0 // temp
        currentScore = 0
        currentLevel = 1
        
        paused = false
        over = false
        
        tileCounts = [:]
        expectedTileCounts = [:]
        for tileID in tileIDs {
            tileCounts[tileID] = 0.0
            expectedTileCounts[tileID] = 0.0
        }
        
        tilesDropped = 0
        wordsCleared = 0
        currentStreak = 0
        longestStreak = 0
        wordData = [[String]]()
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
            let score = scoreForWordPath(wordPath: wordPath)
            currentScore += score
            saveWord(wordPath: wordPath, multiplier: currentMultiplier(), score: score)
            gameView.showScoreBadge(score: score, wordPath: wordPath, wordPaths: wordPaths)
        }
    }
    
    func scoreForWordPath(wordPath: [Int]) -> Int {
        
        wordsCleared += 1
        
        var tiles = [Tile]()
        for position in wordPath {
            tiles.append(grid.tiles[position])
        }
        
        return rules.scoreForTiles(tiles: tiles, multiplier: currentMultiplier())
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
    
    /* STATS */
    
    func updateTileCounts(expected: [String: Double], actual: String) {
        
        var expectedTotal = 0.0
        for tileID in tileIDs {
            expectedTotal += expected[tileID]!
        }
        
        for tileID in tileIDs {
            expectedTileCounts[tileID]! += expected[tileID]! / expectedTotal
        }
        
        tileCounts[actual]! += 1.0
        
        
        /*
        print("")
        for tileID in tileIDs {
            print(tileID + "     " + String(tileCounts[tileID]!) + "     " + String(expectedTileCounts[tileID]!))
        }
        */
    }
    
    func saveWord(wordPath: [Int], multiplier: Int, score: Int) {
        var word = ""
        for position in wordPath {
            word += grid.tiles[position].text
        }
        
        let multiplierString = multiplier > 1 ? "x" + String(multiplier) : ""
        let score = String(score)
        
        wordData.append([word, multiplierString, score])
        
        print(wordData)
    }
    
    func averageWordScore() -> Double {
        if wordsCleared == 0 {
            return 0.0
        }
        
        let avg = Double(currentScore) / Double(wordsCleared)
        return Double(round(10*avg)/10)
    }
    
}
