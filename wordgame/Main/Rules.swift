//
//  Rules.swift
//  wordgame
//
//  Created by Milo Beckman on 3/14/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation


let noneString = "!NONE"

class Rules {
    
    /* RULES */
    let maxMultiplier = 5
    let tilesPerLevel = 7
    
    let timerStart = 20.0
    let timerDecrement = 0.933
    let playSomethingDuration = 0.5
    
    
    
    
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
        // TEMP!!!
        return timerStart * pow(timerDecrement, Double(game.currentLevel-1))
    }
    
    func legalWordPaths(level: Int) -> [[Int]] {
        
        return [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],
                [0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15],
                [0,5,10,15],[12,9,6,3]]
    }
    
    
    
    
    /* NEW TILE GENERATOR */
    
    func newTile() -> Tile {
        let filename = letterFrequencyFilename(level: game.currentLevel)
        let letterFreqs = readlines(filename: filename)
        let tileID = randomTileIDFromFreqs(freqs: letterFreqs)
        
        let tile = Tile(tileID: tileID)
        
        // never serve a triple tile
        var sameCount = 0
        for rackTile in game.rack.tiles {
            if rackTile.type == tile.type && rackTile.text == tile.text {
                sameCount += 1
            }
        }
        if sameCount >= 2 {
            return newTile()
        }
        
        // in some cases we shouldn't serve special tiles, serve wild instead
        if tile.type == "life" && game.numDeadTiles() == 0 {
            return newTile()
        }
        
        if tile.type == "trash" {
            if game.numFullTiles() < 5 {
                return newTile()
            }
            
            for rackTile in game.rack.tiles {
                if rackTile.type == "trash" {
                    return newTile()
                }
            }
        }
        
        return tile
    }
    
    func letterFrequencyFilename(level: Int) -> String {
        let freqFile = level/5
        if freqFile < 5 {
            return "TileFrequency-" + String(freqFile) + ".txt"
        } else {
            return "TileFrequency-5.txt"
        }
    }
    
    func randomTileIDFromFreqs(freqs: [String]) -> String {
        
        var tileIDs = [String]()
        var cumulativeFreqs = [Double]()
        var cumulativeFreq = 0.0
        
        for line in freqs {
            let lineComponents = line.components(separatedBy: ",")
            tileIDs.append(lineComponents[0])
            cumulativeFreq += Double(lineComponents[1])!
            cumulativeFreqs.append(cumulativeFreq)
        }
        
        let rand = randomDouble()*cumulativeFreq
        
        for i in 0..<tileIDs.count {
            if rand < cumulativeFreqs[i] {
                return tileIDs[i]
            }
        }
        
        return "err"
    }
    
    func randomTileForLength(length: String) -> String {
        
        let filename = length + ".txt"
        let freqs = readlines(filename: filename)
        
        var tileTexts = [String]()
        var cumulativeFreqs = [Double]()
        var cumulativeFreq = 0.0
        
        for line in freqs {
            let lineComponents = line.components(separatedBy: ",")
            tileTexts.append(lineComponents[0])
            cumulativeFreq += Double(lineComponents[1])!
            cumulativeFreqs.append(cumulativeFreq)
        }
        
        let rand = randomDouble()*cumulativeFreq
        
        for i in 0..<tileTexts.count {
            if rand < cumulativeFreqs[i] {
                return tileTexts[i]
            }
        }
        
        return noneString
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
