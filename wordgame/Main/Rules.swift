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
        return 10.0
    }
    
    func newTile() -> Tile {
        return Tile(type: "letter", text: "m")
    }
    
}
