//
//  Game.swift
//  wordgame
//
//  Created by Milo Beckman on 3/12/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

class Game {
    
    var grid : Grid
    var rack : Rack
    
    init() {
        grid = Grid()
        rack = Rack()
        
        // temp -- for testing
        let testTile1 = Tile(type: "letter", text: "p")
        let testTile2 = Tile(type: "letter", text: "qu")
        grid.tiles[6] = testTile1
        rack.tiles[3] = testTile2
    }
    
}
