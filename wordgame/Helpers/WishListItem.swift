//
//  WishListItem.swift
//  wordgame
//
//  Created by Milo Beckman on 6/26/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

class WishListItem {
    
    var position: Int
    var text: String
    var numCleared: Int
    var score: Int
    
    init(grid: Grid, position: Int, text: String) {
        
        self.position = position
        self.text = text
        
        numCleared = grid.numClearedForChoice(choice: text, position: position)
        score = grid.scoreForChoice(choice: text, position: position)
    }
    
    
    
}
