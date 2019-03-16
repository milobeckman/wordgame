//
//  Rack.swift
//  wordgame
//
//  Created by Milo Beckman on 3/12/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

class Rack {
    
    var tiles: [Tile]
    
    init() {
        
        tiles = []
        for _ in 0...3 {
            let tile = Tile(type: "null", text: "")
            tiles.append(tile)
        }
        
    }
    
    func moveTile(from: Int, to: Int) {
        
        if tiles[to].type == "null" {
            swap(a: from, b: to)
            return
        }
        
        let tileToMove = tiles[from]
        tiles[from] = Tile()
        
        if from > to {
            push(from: to, direction: 1)
        } else {
            push(from: to, direction: -1)
        }
        
        tiles[to] = tileToMove
    }
    
    func push(from: Int, direction: Int) {
        let target = from + direction
        
        if tiles[target].type == "null" {
            swap(a: from, b: target)
        } else {
            push(from: target, direction: direction)
            tiles[target] = tiles[from]
            tiles[from] = Tile()
        }
        
    }
    
    func swap(a: Int, b: Int) {
        let temp = tiles[a]
        tiles[a] = tiles[b]
        tiles[b] = temp
    }
    
}
