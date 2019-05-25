//
//  TileGenerator.swift
//  wordgame
//
//  Created by Milo Beckman on 4/24/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation


let tileIDs = ["1","2","3","*","**",".trash",".bomb",".life"]
let freqs = [IO.loadResource(resource: "1.txt"), IO.loadResource(resource: "1.txt"), IO.loadResource(resource: "3.txt")]
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
    bag["*"] = max(6.0, 13.0-(2.0*Double(level))/5.0)*0.6
    bag[".trash"] = 16.0*pow(howFull, 2.0)
    bag[".life"] = 3.0
    bag[".bomb"] = level >= 5 && howFull < 1.0 ? 20.0*pow(howFull, 4.0) : 0
    bag["2"] = level >= 10 ? pow(4.0*Double(level-8), 0.5) : 0
    bag["3"] = level >= 20 ? pow(3.0*Double(level-18), 0.5) : 0
    
    
    bag["**"] = 0.0 // level >= 15 ? 1.8 : 0
    
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
    /*
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
    var yCount = 0
    for rackTile in rackTiles {
        if rackTile.type == "letter" && "aeiou".contains(rackTile.text) {
            vowelCount += 1
        }
        if rackTile.type == "letter" && rackTile.text == "y" {
            yCount += 1
        }
    }
    if vowelCount + yCount == 3 && tile.type == "letter" && "aeiouy".contains(tile.text) {
        return false
    }
    if vowelCount == 0 && tile.type == "letter" && !"aeiou".contains(tile.text) {
        return false
    }*/
    
    return true
}


func randomTileForLength(length: String) -> String {
    
    if length == "1" {
        return randomSingleLetterTile()
    }
    
    var tileTexts = [String]()
    var cumulativeFreqs = [Double]()
    var cumulativeFreq = 0.0
    
    for line in freqs[Int(length)!-1] {
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

func randomSingleLetterTile() -> String {
    
    var numInPlay = [String: Int]()
    for letter in "abcdefghijklmnopqrstuvwxyz" {
        numInPlay[String(letter)] = 0
    }
    
    for tile in game.rack.tiles {
        if tile.type == "letter" && tile.text.count == 1 {
            numInPlay[tile.text]! += 1
        }
    }
    for tile in game.grid.tiles {
        if tile.type == "letter" && tile.text.count == 1 {
            numInPlay[tile.text]! += 1
        }
    }
    
    var vowelsInPlay = 0
    var consonantsInPlay = 0
    for letter in "aeiou" {
        vowelsInPlay += numInPlay[String(letter)]!
    }
    for letter in "bcdfghjklmnpqrstvwxyz" {
        consonantsInPlay += numInPlay[String(letter)]!
    }
    
    if vowelsInPlay + consonantsInPlay < 4 {
        return randomSingleLetterTile(vowelAdjust: 1.0, numInPlay: numInPlay)
    }
    let vowelFraction = Double(vowelsInPlay) / Double(vowelsInPlay + consonantsInPlay)
    return randomSingleLetterTile(vowelAdjust: 2.0*(1.0-vowelFraction), numInPlay: numInPlay)
}

func randomSingleLetterTile(vowelAdjust: Double, numInPlay: [String: Int]) -> String {
    
    var tileTexts = [String]()
    var cumulativeFreqs = [Double]()
    var cumulativeFreq = 0.0
    
    for line in freqs[0] {
        let lineComponents = line.components(separatedBy: ",")
        
        let letter = lineComponents[0]
        var freq = Double(lineComponents[1])!
        
        if "aeiou".contains(letter) {
            freq *= vowelAdjust
        } else {
            freq *= (2.0 - vowelAdjust)
        }
        
        let logisticAdjust = 1.0 / (1.0 + pow(2.718, 2.0*(Double(numInPlay[letter]!) - 2.5)))
        freq *= logisticAdjust
        
        tileTexts.append(letter)
        cumulativeFreq += freq
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
















