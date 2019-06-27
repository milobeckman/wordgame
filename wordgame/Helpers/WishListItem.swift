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
    var dependencies: [Int]
    
    init(grid: Grid, position: Int, text: String) {
        
        self.position = position
        self.text = text
        
        let clearingPaths = grid.clearingPathsForChoice(choice: text, position: position)
        numCleared = clearingPaths.count
        dependencies = []
        for wordPath in clearingPaths {
            for position in wordPath where !dependencies.contains(position) {
                dependencies += [position]
            }
        }
        
        score = grid.scoreForChoice(choice: text, position: position)
    }
    
    
    
}
