//
//  WishList.swift
//  wordgame
//
//  Created by Milo Beckman on 6/26/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

class WishList {
    
    var grid: Grid
    var wishListItems: [WishListItem]
    var wordPathFullness: [[Int]: Int]
    
    
    init(grid: Grid) {
        self.grid = grid
        wishListItems = []
        
        // assume the grid starts empty
        wordPathFullness = [:]
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            wordPathFullness[wordPath] = 0
        }
    }
    
    func removeWishListItemsAtPosition(position: Int) {
        var newWishListItems = [WishListItem]()
        for wishListItem in wishListItems {
            if wishListItem.position != position {
                newWishListItems += [wishListItem]
            }
        }
        
        wishListItems = newWishListItems
    }
    
    func addWishListItemsForPosition(position: Int, length: Int) {
        
        var choices = [String]()
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) {
            if wordPath.contains(position) && wordPathFullness[wordPath]! == 3 {
                let pattern = grid.patternForWordPath(wordPath: wordPath, position: position)
                choices += choicesForWild(pattern: pattern)
            }
        }
        
        for choice in choices {
            let newWishListItem = WishListItem(grid: grid, position: position, text: choice)
            wishListItems += [newWishListItem]
        }
    }
    
    func tileDropped(position: Int) {
        
        removeWishListItemsAtPosition(position: position)
        var newlyActivePositions = [Int]()
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            wordPathFullness[wordPath]! += 1
            if wordPathFullness[wordPath]! == 3 {
                for emptyPosition in wordPath where grid.tiles[emptyPosition].type == "null" {
                    newlyActivePositions += [emptyPosition]
                }
            }
        }
        
        for newlyActivePosition in newlyActivePositions {
            addWishListItemsForPosition(position: newlyActivePosition, length: 1) // temp
        }
    }
    
    func wordPathsCleared(wordPaths: [[Int]]) {
        
        var allClearedPositions = [Int]()
        for wordPath in wordPaths {
            allClearedPositions += wordPath
        }
        
        for position in 0...15 {
            if allClearedPositions.contains(position) {
                for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
                    wordPathFullness[wordPath]! -= 1
                }
            }
        }
        
        var newlyActivePositions = [Int]()
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPathFullness[wordPath]! == 3 {
            for emptyPosition in wordPath where grid.tiles[emptyPosition].type == "null" {
                newlyActivePositions += [emptyPosition]
            }
        }
        
        for newlyActivePosition in newlyActivePositions {
            addWishListItemsForPosition(position: newlyActivePosition, length: 1) // temp
        }
        
    }
    
    
    
    func printWishList() {
        for wishListItem in wishListItems {
            print(wishListItem.text + " @" + String(wishListItem.position) + "   +" + wishListItem.score)
        }
    }
    
    
}
