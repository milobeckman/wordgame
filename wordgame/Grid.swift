//
//  Grid.swift
//  wordgame
//
//  Created by Milo Beckman on 3/12/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

class Grid {
    
    var tiles : [Tile]
    
    init() {
        
        tiles = []
        for _ in 0...15 {
            let tile = Tile(type: "null", text: "")
            tiles.append(tile)
        }
        
    }
    
}
