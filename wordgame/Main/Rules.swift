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
    
    var maxMultiplier = 5
    
    
    
    
    
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
        return 2.0 + (100.0 / Double(game.tilesServed + 1))
    }
    
    func legalWordPaths(level: Int) -> [[Int]] {
        
        return [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],
                [0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15],
                [0,5,10,15],[12,9,6,3]]
    }
    
    
    
    
    /* NEW TILE GENERATOR */
    
    func newTile() -> Tile {
        let filename = letterFrequencyFilename(level: 0) // temp: hard-coded
        let letterFreqs = readlines(filename: filename)
        let tileID = randomTileIDFromFreqs(freqs: letterFreqs)
        
        return Tile(tileID: tileID)
    }
    
    func letterFrequencyFilename(level: Int) -> String {
        return "TileFrequency-0.txt"
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
            if tile.type == "letter" {
                for letter in Array(tile.text) {
                    score += scoreForLetter(letter: String(letter))
                }
            }
        }
        
        return score * multiplier
    }
    
    func scoreForLetter(letter: String) -> Int {
        if "etaoinshrdlu".contains(letter) {
            return 1
        } else if "zxqjk".contains(letter) {
            return 3
        } else {
            return 2
        }
    }
    
    
    
}
