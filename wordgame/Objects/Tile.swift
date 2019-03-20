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

 null       - not a tile
 dead       - not a tile
 
 letter
 wild
 trash
 bomb
 sweep
*/


class Tile {
    
    var type: String
    var text: String
    
    init(type: String, text: String) {
        self.type = type
        self.text = text
    }
    
    convenience init() {
        self.init(type: "null", text: "")
    }
    
    convenience init(tileID: String) {
        self.init()
        
        if tileID == "wild" {
            type = "wild"
            text = "*"
        }
        
        else {
            type = "letter"
            text = tileID
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
}
