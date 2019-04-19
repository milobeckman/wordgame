//
//  GridView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/12/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class GridView {
    
    var grid: Grid
    
    var gridSlotViews: [GridSlotView]
    var tileViews: Set<TileView>
    
    var view: UIView
    
    init(grid: Grid) {
        
        self.grid = grid
        
        gridSlotViews = []
        tileViews = []
        view = UIView(frame: device.screenBounds)

        // slots
        for i in 0...15 {
            let newGridSlot = GridSlotView(position: i)
            gridSlotViews.append(newGridSlot)
            view.addSubview(newGridSlot.view)
        }
        
        createTiles()
    }
    
    func createTiles() {

        for i in 0...15 {
            if grid.tiles[i].type != "null" {
                let tileView = TileView(tile: grid.tiles[i], gridPosition: i)
                tileViews.insert(tileView)
                view.addSubview(tileView.view)
            }
        }
    }
    
    
    /* HOVERS AND DROPS */
    
    func beginActiveHover(tileView: TileView, position: Int) {
        
        // hover over blank
        if grid.tiles[position].type == "null" {
            gridSlotViews[position].highlight()
        }
        
        // hover trash over tile
        else if tileView.tile.type == "trash" {
            let tileViewToFade = device.tileViewWithGridPosition(tileViews: tileViews, position: position)
            tileViewToFade.fade()
            //gridSlotViews[position].hide()
        }
        
        // hover life over dead
        else if tileView.tile.type == "life" {
            gridSlotViews[position].suggestRevival()
        }
    }
    
    func endActiveHover(tileView: TileView, position: Int) {
        
        // hover over blank
        if grid.tiles[position].type == "null" {
            gridSlotViews[position].unhighlight()
        }
        
        // hover over tile
        else if tileView.tile.type == "trash" {
            let tileViewToUnfade = device.tileViewWithGridPosition(tileViews: tileViews, position: position)
            tileViewToUnfade.unfade()
            gridSlotViews[position].unhide()
        }
        
        // hover life over dead
        else if tileView.tile.type == "life" {
            gridSlotViews[position].unsuggestRevival()
        }
    }
    
    func handleDrop(tileView: TileView, position: Int) {
        
        endActiveHover(tileView: tileView, position: position)
        game.addToTilesDropped(tile: tileView.tile)
        
        // drop on blank
        if grid.tiles[position].type == "null" {
            tileView.slideToGridPosition(position: position, duration: dropDuration)
            takeTile(tileView: tileView, position: position)
            endActiveHover(tileView: tileView, position: position)
            
            if tileView.tile.type == "bomb" {
                game.currentStreak = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + dropDuration, execute: {
                    self.bomb(position: position)
                })
            }
        }
        
        // drop on tile
        else if tileView.tile.type == "trash" {
            let tileToTrash = device.tileViewWithGridPosition(tileViews: tileViews, position: position)
            giveTile(tileView: tileToTrash, position: position)
            endActiveHover(tileView: tileView, position: position)
        }
        
        else if tileView.tile.type == "life" {
            revive(position: position)
        }
    }
    
    
    
    /* BASIC CHANGES TO GRID COMPONENTS */
    
    func giveTile(tileView: TileView, position: Int) {
        grid.tiles[position] = Tile()
        tileViews.remove(tileView)
        tileView.view.removeFromSuperview()
    }
    
    func takeTile(tileView: TileView, position: Int) {
        grid.tiles[position] = tileView.tile
        tileViews.insert(tileView)
        view.addSubview(tileView.view)
        
        clearWordsIfPossible(position: position)
    }
    
    func kill(position: Int) {
        grid.tiles[position].type = "dead"
        gridSlotViews[position].die()
        
        game.checkIfGameOver()
    }
    
    func revive(position: Int) {
        grid.tiles[position].type = "null"
        gridSlotViews[position].revive()
    }
    
    func bomb(position: Int) {
        let positionsToBomb = [position-4, position-1, position, position+1, position+4]
        for i in positionsToBomb {
            if (0...15).contains(i) && (position + i) % 8 != 7 {
                if grid.tiles[i].type != "null" && grid.tiles[i].type != "dead" {
                    let tileToTrash = device.tileViewWithGridPosition(tileViews: tileViews, position: i)
                    giveTile(tileView: tileToTrash, position: i)
                }
            }
        }
        
        gameView.bomb()
    }
    
    
    
    /* CLEARING WORDS */
    
    func clearWordsIfPossible(position: Int) {
        
        grid.optimizeWilds(position: position)
        showChoicesForWilds()
        
        let wordPathsToClear = grid.wordPathsToClear()
        if wordPathsToClear.count > 0 {
            scoreAndClearWordPaths(wordPaths: wordPathsToClear)
            game.updateLevelIfNeeded()
        }
        
        gameView.scoreView.showyUpdate()
    }
    
    func showChoicesForWilds() {
        for tileView in tileViews {
            if tileView.tile.type == "wild" && !tileView.tile.text.contains("*") {
                tileView.updateAndShowText()
            }
        }
    }
    
    func scoreAndClearWordPaths(wordPaths: [[Int]]) {
        game.scoreWordPaths(wordPaths: wordPaths)
        
        var gridPositions = [Int]()
        for wordPath in wordPaths {
            for i in wordPath {
                if !gridPositions.contains(i) {
                    gridPositions.append(i)
                }
            }
        }
        
        grid.clearPositions(positions: gridPositions)
        
        for tileView in tileViews {
            let position = device.gridPositionForFrame(frame: tileView.depthFrame)
            
            if gridPositions.contains(position) {
                giveAndEvaporateTile(tileView: tileView, position: position)
            }
        }
    }
    
    func giveAndEvaporateTile(tileView: TileView, position: Int) {
        grid.tiles[position] = Tile()
        tileViews.remove(tileView)
        
        tileView.evaporate()
    }
    
}
