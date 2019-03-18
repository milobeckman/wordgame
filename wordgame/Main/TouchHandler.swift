//
//  TouchHandler.swift
//  wordgame
//
//  Created by Milo Beckman on 3/14/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class TouchHandler {
    
    var gameView: GameView
    
    var tileViewForTouch: [UITouch: TileView]
    var rackPositionForTouch: [UITouch: Int]
    var gridPositionForTouch: [UITouch: Int]
    
    init(gameView: GameView) {
        self.gameView = gameView
        
        tileViewForTouch = [:]
        rackPositionForTouch = [:]
        gridPositionForTouch = [:]
    }
    
    func liftTile(touch: UITouch) {
        let point = touch.location(in: gameView.view)
        let rackPosition = vc.rackPositionForPoint(point: point)
        
        for tileView in gameView.rackView.tileViews {
            if tileView.tileFrame.contains(point) && tileView.tile.type != "null" {
                tileView.lift(point: point)
                
                tileViewForTouch[touch] = tileView
                rackPositionForTouch[touch] = rackPosition
                gridPositionForTouch[touch] = -1
                
                // gameView takes over custody of tile
                gameView.rackView.giveTile(tileView: tileView, position: rackPosition)
                gameView.view.addSubview(tileView.view)
            }
        }
    }
    
    func dragTile(touch: UITouch) {
        let point = touch.location(in: gameView.view)
        if let tileView = tileViewForTouch[touch] {
            tileView.recenter(point: point)
            
            // if in grid, highlight drop slot
            let gridPosition = gridPositionForTouch[touch]!
            
            // unhighlight
            if gridPosition != -1 && !gameView.gridView.gridSlotViews[gridPosition].slotFrame.contains(point) {
                gameView.gridView.unhighlight(position: gridPosition)
                gridPositionForTouch[touch] = -1
            }
            
            // highlight
            if gridPosition == -1 {
                let newGridPosition = vc.gridPositionForPoint(point: point)
                if newGridPosition != -1 {
                    let gridTile = gameView.gridView.grid.tiles[newGridPosition]
                    if rules.canDrop(tile: tileView.tile, gridTile: gridTile) {
                        gameView.gridView.highlight(position: newGridPosition)
                        gridPositionForTouch[touch] = newGridPosition
                    }
                }
            }
            
            // if in rack, rearrange rack
            if vc.rackFrame().contains(point) {
                let rackPosition = rackPositionForTouch[touch]!
                let newRackPosition = vc.rackPositionForPoint(point: point)
                
                if newRackPosition != -1 && newRackPosition != rackPosition {
                    if newRackPosition < rackPosition {
                        gameView.rackView.push(from: newRackPosition, direction: 1)
                    } else {
                        gameView.rackView.push(from: newRackPosition, direction: -1)
                    }
                    
                    rackPositionForTouch[touch] = newRackPosition
                }
            }
        }
    }
    
    func dropTile(touch: UITouch) {
        if let tileView = tileViewForTouch[touch] {
            
            let gridPosition = gridPositionForTouch[touch]!
            let rackPosition = rackPositionForTouch[touch]!
            
            tileView.view.removeFromSuperview()
            
            if gridPosition == -1 {
                tileView.moveToRackPosition(position: rackPosition)
                gameView.rackView.takeTile(tileView: tileView, position: rackPosition)
            } else {
                tileView.moveToGridPosition(position: gridPosition)
                gameView.gridView.takeTile(tileView: tileView, position: gridPosition)
                gameView.gridView.unhighlight(position: gridPositionForTouch[touch]!)
            }
            
            tileViewForTouch.removeValue(forKey: touch)
            rackPositionForTouch.removeValue(forKey: touch)
            gridPositionForTouch.removeValue(forKey: touch)
            
        }
    }
    
}
