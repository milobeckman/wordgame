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
    
    func highlight(position: Int) {
        gridSlotViews[position].highlight()
    }
    
    func unhighlight(position: Int) {
        gridSlotViews[position].unhighlight()
    }
    
    func giveTile(tileView: TileView, position: Int) {
        grid.tiles[position] = Tile()
        tileViews.remove(tileView)
        
        tileView.evaporate()
    }
    
    func takeTile(tileView: TileView, position: Int) {
        grid.tiles[position] = tileView.tile
        tileViews.insert(tileView)
        view.addSubview(tileView.view)
        
        checkWords()
    }
    
    func checkWords() {
        let wordPathsToClear = grid.wordPathsToClear()
        if wordPathsToClear.count > 0 {
            scoreAndClearWordPaths(wordPaths: wordPathsToClear)
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
                giveTile(tileView: tileView, position: position)
            }
        }
        
        
    }
    
}
