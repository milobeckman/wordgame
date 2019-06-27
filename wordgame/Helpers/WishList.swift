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
    
    func addWishListItem(wishListItem: WishListItem) {
        for i in 0..<wishListItems.count {
            if wishListItems[i].text == wishListItem.text && wishListItems[i].position == wishListItem.position {
                wishListItems[i] = wishListItem
                return
            }
        }
        
        wishListItems += [wishListItem]
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
                let pattern = grid.patternForWordPath(wordPath: wordPath, position: position, length: length)
                choices += choicesForWild(pattern: pattern)
            }
        }
        
        for choice in choices {
            let newWishListItem = WishListItem(grid: grid, position: position, text: choice)
            addWishListItem(wishListItem: newWishListItem)
        }
    }
    
    func addWishListItemsForPositionAndPath(position: Int, wordPath: [Int], length: Int) {
        let pattern = grid.patternForWordPath(wordPath: wordPath, position: position, length: length)
        let choices = choicesForWild(pattern: pattern)
        for choice in choices {
            let newWishListItem = WishListItem(grid: grid, position: position, text: choice)
            addWishListItem(wishListItem: newWishListItem)
        }
    }
    
    func tileDropped(position: Int) {
        
        removeWishListItemsAtPosition(position: position)
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            wordPathFullness[wordPath]! += 1
            if wordPathFullness[wordPath]! == 3 {
                for emptyPosition in wordPath where grid.tiles[emptyPosition].type == "null" {
                    addWishListItemsForPositionAndPath(position: emptyPosition, wordPath: wordPath, length: 1) // temp
                }
            }
        }
        
        printWishList()
    }
    
    func tileDeleted(position: Int) {
        
        var i = 0
        while i < wishListItems.count {
            if wishListItems[i].dependencies.contains(position) {
                wishListItems.remove(at: i)
            } else {
                i += 1
            }
        }
        
        for wordPath in rules.legalWordPaths(level: game.currentLevel) where wordPath.contains(position) {
            wordPathFullness[wordPath]! -= 1
            if wordPathFullness[wordPath]! == 3 {
                addWishListItemsForPositionAndPath(position: position, wordPath: wordPath, length: 1) // temp
            }
        }
        
        
        printWishList()
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
                
                var i = 0
                while i < wishListItems.count {
                    if wishListItems[i].dependencies.contains(position) {
                        wishListItems.remove(at: i)
                    } else {
                        i += 1
                    }
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
        
        
        printWishList()
    }
    
    
    
    func printWishList() {
        
        print("WISH LIST:")
        for wishListItem in wishListItems {
            print(wishListItem.text + " @" + String(wishListItem.position)
                                    + " x" + String(wishListItem.numCleared)
                                    + " +" + String(wishListItem.score))
        }
    }
    
    
}
