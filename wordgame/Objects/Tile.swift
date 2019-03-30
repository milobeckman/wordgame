//
//  Tile.swift
//  wordgame
//
//  Created by Milo Beckman on 3/11/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation


/*
 TYPES:

 null       not a tile
 dead       not a tile
 
 letter     (any 1-3 letter string)
 wild       *, **, ***
 trash      .trash
 life       .life
 bomb       .bomb
 sweep      .sweep
 ice        .ice
 arrow      .u, .d, .l, .r, .ul, .ur, .dl, .dr
*/


class Tile: CustomStringConvertible {
    
    var type: String
    var text: String
    
    init(type: String, text: String) {
        self.type = type
        self.text = text
    }
    
    var description: String {
        return type + "," + text
    }
    
    convenience init() {
        self.init(type: "null", text: "")
    }
    
    convenience init(tileID: String) {
        self.init()
        
        type = typeForTileID(tileID: tileID)
        text = textForTileID(tileID: tileID)
    }
    
    func typeForTileID(tileID: String) -> String {
        
        if tileID.contains("*") {
            return "wild"
        } else if tileID == ".trash" {
            return "trash"
        } else if tileID == ".life" {
            return "life"
        } else {
            return "letter"
        }
    }
    
    func textForTileID(tileID: String) -> String {
        
        if tileID.contains(".") {
            return ""
        } else if tileID.contains("*") {
            return tileID
        } else {
            return rules.randomTileForLength(length: tileID)
        }
    }
    
    func isLetterLike() -> Bool {
        switch type {
        case "letter":
            return true
        case "wild":
            return true
        default:
            return false
        }
    }
    
    func score() -> Int {
        
        if type == "wild" {
            return 0
        }
        

        
        switch text.count {
        case 3:
            return 30
        case 2:
            return 10
            
        // single letter tile
        default:
            if "qxjz".contains(text) {
                return 3
            } else if "vwfbcgyhkmp".contains(text) {
                return 2
            } else {
                return 1
            }
        }
        
    }
    
    func imageName() -> String {
        switch type {
        case "wild":
            return text
        case "trash":
            return "trash"
        case "life":
            return "life"
        default:
            return ""
        }
    }
}

func sampleTile(tileID: String) -> Tile {
    let tile = Tile(tileID: tileID)
    if tile.type == "letter" {
        switch tile.text.count {
        case 1:
            tile.text = "a"
        case 2:
            tile.text = "ab"
        default:
            tile.text = "abc"
        }
    }
    
    return tile
    
}
