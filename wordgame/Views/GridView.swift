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
        view = UIView(frame: vc.screenBounds)
        
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
            let tileViewToFade = vc.tileViewWithGridPosition(tileViews: tileViews, position: position)
            tileViewToFade.fade()
            //gridSlotViews[position].hide()
        }
        
        // hover life over dead
        else if tileView.tile.type == "life" {
            gridSlotViews[position].suggestRebirth()
        }
    }
    
    func endActiveHover(tileView: TileView, position: Int) {
        
        // hover over blank
        if grid.tiles[position].type == "null" {
            gridSlotViews[position].unhighlight()
        }
        
        // hover over tile
        else if tileView.tile.type == "trash" {
            let tileViewToUnfade = vc.tileViewWithGridPosition(tileViews: tileViews, position: position)
            tileViewToUnfade.unfade()
            gridSlotViews[position].unhide()
        }
        
        // hover life over dead
        else if tileView.tile.type == "life" {
            gridSlotViews[position].unsuggestRebirth()
        }
    }
    
    func handleDrop(tileView: TileView, position: Int) {
        
        endActiveHover(tileView: tileView, position: position)
        
        // drop on blank
        if grid.tiles[position].type == "null" {
            tileView.slideToGridPosition(position: position, duration: vc.dropDuration)
            takeTile(tileView: tileView, position: position)
            endActiveHover(tileView: tileView, position: position)
        }
        
        // drop on tile
        else if tileView.tile.type == "trash" {
            let tileToTrash = vc.tileViewWithGridPosition(tileViews: tileViews, position: position)
            giveTile(tileView: tileToTrash, position: position)
            endActiveHover(tileView: tileView, position: position)
        }
        
        else if tileView.tile.type == "life" {
            rebirth(position: position)
        }
    }
    
    
    
    /* BASIC CHANGES TO GRID COMPONENTS */
    
    func kill(position: Int) {
        grid.tiles[position].type = "dead"
        gridSlotViews[position].die()
    }
    
    func rebirth(position: Int) {
        grid.tiles[position].type = "null"
        gridSlotViews[position].rebirth()
    }
    
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
    
    
    
    /* CLEARING WORDS */
    
    func clearWordsIfPossible(position: Int) {
        
        grid.optimizeWilds(position: position)
        showChoicesForWilds()
        
        let wordPathsToClear = grid.wordPathsToClear()
        if wordPathsToClear.count > 0 {
            scoreAndClearWordPaths(wordPaths: wordPathsToClear)
        }
        
        gameView.scoreView.update()
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
            let position = vc.gridPositionForFrame(frame: tileView.depthFrame)
            
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
