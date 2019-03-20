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
    
    var tilesServed : Int
    var currentLevel : Int
    
    init() {
        grid = Grid()
        rack = Rack()
        
        tilesServed = 0
        currentLevel = 0
    }
    
    func scoreWordPaths(wordPaths: [[Int]]) {
        
    }
    
    func tileServer() -> Int {
        tilesServed += 1
        return tilesServed
    }
    
}
