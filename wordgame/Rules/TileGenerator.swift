//
//  TileGenerator.swift
//  wordgame
//
//  Created by Milo Beckman on 4/24/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation


let tileIDs = ["1","2","3","*","**",".trash",".bomb",".life"]
let luckAdjustment = 8.0


func newTile() -> Tile {
    let howFull = Double(game.numFullTiles())/Double(16-game.numDeadTiles())
    let rawTileBag = tileBag(level: game.currentLevel, howFull: howFull)
    let trueTileBag = adjustForSpecialTileRules(bag: rawTileBag, rackTiles: game.rack.tiles)
    let luckAdjustedTileBag = adjustForLuck(bag: trueTileBag, expected: game.expectedTileCounts, actual: game.tileCounts)
    
    var tileID = randomTileIDFromBag(bag: luckAdjustedTileBag)
    var tile = Tile(tileID: tileID)
    while !canServe(tile: tile, rackTiles: game.rack.tiles) {
        tileID = randomTileIDFromBag(bag: luckAdjustedTileBag)
        tile = Tile(tileID: tileID)
    }
    
    game.updateTileCounts(expected: trueTileBag, actual: tileID)
    
    return tile
}


func tileBag(level: Int, howFull: Double) -> [String: Double] {
    
    var bag = [String: Double]()
    
    bag["1"] = 100.0
    bag["2"] = level >= 10 ? pow(4.0*Double(level-8), 0.5) : 0
    bag["3"] = level >= 20 ? pow(3.0*Double(level-18), 0.5) : 0
    bag["*"] = max(6.0, 13.0-(2.0*Double(level))/5.0)*0.6
    bag["**"] = level >= 15 ? 1.8 : 0
    bag[".trash"] = 16.0*pow(howFull, 2.0)
    bag[".bomb"] = level >= 5 && howFull < 1.0 ? 20.0*pow(howFull, 4.0) : 0
    bag[".life"] = 3.0
    
    return bag
}



func adjustForSpecialTileRules(bag: [String: Double], rackTiles: [Tile]) -> [String: Double] {
    
    var adjusted = [String: Double]()
    for tileID in tileIDs {
        adjusted[tileID] = bag[tileID]!
    }
    
    // never serve life tile if no dead squares or if you already have one
    if game.numDeadTiles() == 0 {
        adjusted[".life"] = 0.0
    }
    
    for rackTile in rackTiles {
        if rackTile.type == "life" {
            adjusted[".life"] = 0.0
        }
    }

    // never serve two clearing tiles
    for rackTile in rackTiles {
        if rackTile.type == "trash" || rackTile.type == "bomb" {
            adjusted[".trash"] = 0.0
            adjusted[".bomb"] = 0.0
        }
    }
    
    return adjusted
}


func adjustForLuck(bag: [String: Double], expected: [String: Double], actual: [String: Double]) -> [String: Double] {
    
    var adjusted = [String: Double]()
    
    for tileID in tileIDs {
        if tileID == "1" {
            adjusted[tileID] = bag[tileID]!
        } else {
            adjusted[tileID] = bag[tileID]! * pow(luckAdjustment, expected[tileID]! - actual[tileID]!)
        }
    }
    
    return adjusted
}


func randomTileIDFromBag(bag: [String: Double]) -> String {
    
    var cumulativeFreqs = [Double]()
    var cumulativeFreq = 0.0
    
    for tileID in tileIDs {
        cumulativeFreq += bag[tileID]!
        cumulativeFreqs.append(cumulativeFreq)
    }
    
    let rand = randomDouble()*cumulativeFreq
    
    for i in 0..<tileIDs.count {
        if rand < cumulativeFreqs[i] {
            return tileIDs[i]
        }
    }
    
    return errorString
}


func canServe(tile: Tile, rackTiles: [Tile]) -> Bool {
    
    // never serve a triple tile
    var sameCount = 0
    for rackTile in rackTiles {
        if rackTile.type == tile.type && rackTile.text == tile.text {
            sameCount += 1
        }
    }
    if sameCount >= 2 {
        return false
    }
    
    
    // never serve four vowels or four consonants
    var vowelCount = 0
    for rackTile in rackTiles {
        if rackTile.type == "letter" && "aeiouy".contains(rackTile.text) {
            vowelCount += 1
        }
    }
    if vowelCount == 3 && tile.type == "letter" && "aeiouy".contains(tile.text) {
        return false
    }
    if vowelCount == 0 && tile.type == "letter" && !"aeiouy".contains(tile.text) {
        return false
    }
    
    return true
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
















