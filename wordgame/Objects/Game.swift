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
    
    var iced: Bool
    var charmed: Bool
    
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
        
        tilesServed = 0 + playtestOptions.advancedStart * rules.tilesPerLevel
        currentScore = 0
        currentLevel = 1
        
        iced = false
        charmed = false
        
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
            
            gameView.showMultiplierView(multiplier: currentMultiplier())
            if settings.showStreakView {
                backgroundView.showOrIncreaseStreakView(multiplier: currentMultiplier())
            }
            
        } else {
            currentStreak = 0
            if settings.showStreakView {
                backgroundView.hideStreakView()
            }
        }
        
        for wordPath in wordPaths {
            let score = grid.scoreForWordPath(wordPath: wordPath)*currentMultiplier()
            currentScore += score
            wordsCleared += 1
            saveWord(wordPath: wordPath, multiplier: currentMultiplier(), score: score)
            gameView.showScoreBadge(score: score, wordPath: wordPath, wordPaths: wordPaths)
        }
    }
    
    func tileServer() -> Int {
        tilesServed += 1
        return tilesServed
    }
    
    func tileDropped() {
        tilesDropped += 1
        for tile in grid.tiles {
            if tile.type == "ice" || tile.type == "charm" {
                tile.dropsLeft -= 1
            }
        }
    }
    
    func updateLevelIfNeeded() {
        let level = Int(rules.trueLevel(tilesServed: tilesServed))
        
        if level > currentLevel {
            currentLevel = level
        }
        
        if level >= rules.timerActivationLevel && !gameView.timerView.active {
            gameView.timerView.showAndActivateTimer()
        }
    }
    
    /* WISH LISTS */
    
    func wishListShouldUpdate(length: Int) -> Bool {
        
        return length == 1
        
        /*
        
        if length == 1 {
            return true
        }
        
        if charmed || rack.hasCharm() || playtestOptions.alwaysCharmed {
            if length == 2 && game.currentLevel >= 10 {
                return true
            }
            if length == 3 && game.currentLevel >= 20 {
                return true
            }
        }
        
        return false*/
    }
    
    
    /* GAME ENDING */
    
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
            
            for tile in grid.tiles {
                if tile.type == "ice" || tile.type == "charm" {
                    gameView.gridView.expireSomething()
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
    }
    
    func averageWordScore() -> Double {
        if wordsCleared == 0 {
            return 0.0
        }
        
        let avg = Double(currentScore) / Double(wordsCleared)
        return Double(round(10*avg)/10)
    }
    
}
