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
        for tileView in gameView.rackView.tileViews {
            if tileView.tileFrame.contains(point) && tileView.tile.type != "null" {
                tileView.lift(point: point)
                
                tileViewForTouch[touch] = tileView
                rackPositionForTouch[touch] = vc.rackPositionForPoint(point: point)
                gridPositionForTouch[touch] = -1
            }
        }
    }
    
    func dragTile(touch: UITouch) {
        let point = touch.location(in: gameView.view)
        if let tileView = tileViewForTouch[touch] {
            tileView.drag(point: point)
            
            // if in grid, highlight drop slot
            if vc.gridFrame().contains(point) {
                let gridPosition = gridPositionForTouch[touch]!
                print(gridPosition)
                
                // unhighlight
                if gridPosition != -1 && !gameView.gridView.gridSlotViews[gridPosition].slotFrame.contains(point) {
                    gameView.gridView.unhighlight(position: gridPosition)
                    gridPositionForTouch[touch] = -1
                }
                
                // highlight
                if gridPosition == -1 {
                    let newGridPosition = vc.gridPositionForPoint(point: point)
                    if newGridPosition != -1 {
                        if gameView.gridView.grid.tiles[newGridPosition].type == "null" {
                            gameView.gridView.highlight(position: newGridPosition)
                            gridPositionForTouch[touch] = newGridPosition
                        }
                    }
                }
                
            }
            
            // if in rack, rearrange rack
        }
    }
    
    func dropTile(touch: UITouch) {
        let point = touch.location(in: gameView.view)
        if let tileView = tileViewForTouch[touch] {
            tileView.drop(point: point)
            tileViewForTouch.removeValue(forKey: touch)
        }
    }
    
}
