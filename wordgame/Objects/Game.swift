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
        let testTile1 = Tile(type: "letter", text: "a")
        let testTile2 = Tile(type: "letter", text: "b")
        let testTile3 = Tile(type: "letter", text: "c")
        let testTile4 = Tile(type: "letter", text: "d")
        rack.tiles[0] = testTile1
        rack.tiles[1] = testTile2
        rack.tiles[2] = testTile3
        rack.tiles[3] = testTile4
    }
    
}
