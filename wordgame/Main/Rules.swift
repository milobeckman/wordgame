//
//  Rules.swift
//  wordgame
//
//  Created by Milo Beckman on 3/14/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

class Rules {
    
    init() {
        
    }
    
    func canDrop(tile: Tile, gridTile: Tile) -> Bool {
        if tile.type == "letter" {
            return gridTile.type == "null"
        }
        
        return false
    }
    
    func currentTimerLength() -> Double {
        return 1000.0
    }
    
    func newTile() -> Tile {
        let filename = letterFrequencyFilename(level: 0) // temp: hard-coded
        let letterFreqs = readlines(filename: filename)
        let tileID = randomTileIDFromFreqs(freqs: letterFreqs)
        
        return Tile(type: "letter", text: tileID)
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
            if lineComponents.count == 2 {
                tileIDs.append(lineComponents[0])
                cumulativeFreq += Double(lineComponents[1])!
                cumulativeFreqs.append(cumulativeFreq)
            }
        }
        
        let rand = randomDouble()*cumulativeFreq
        
        for i in 0..<tileIDs.count {
            if rand < cumulativeFreqs[i] {
                return tileIDs[i]
            }
        }
        
        return "err"
    }
    
}
