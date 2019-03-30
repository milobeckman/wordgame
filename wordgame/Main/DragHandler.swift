//
//  DragHandler.swift
//  wordgame
//
//  Created by Milo Beckman on 3/14/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class DragHandler {
    
    var gameView: GameView
    
    var tileViewForTouch: [UITouch: TileView]
    var rackPositionForTouch: [UITouch: Int]
    var gridPositionForTouch: [UITouch: Int]
    
    var doubleCheckBeforeDropping: Bool
    
    init(gameView: GameView) {
        self.gameView = gameView
        
        tileViewForTouch = [:]
        rackPositionForTouch = [:]
        gridPositionForTouch = [:]
        
        doubleCheckBeforeDropping = false
    }
    
    func liftTile(touch: UITouch) {
        if game.paused || game.over {
            return
        }
        
        let point = touch.location(in: gameView.view)
        let rackPosition = device.rackPositionForPoint(point: point)
        
        if rackPosition == -1 {
            return
        }
        
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
        if game.paused || game.over {
            return
        }
        
        let point = touch.location(in: gameView.view)
        if let tileView = tileViewForTouch[touch] {
            tileView.recenter(point: point)
            
            let gridPosition = gridPositionForTouch[touch]!
            let rackPosition = rackPositionForTouch[touch]!
            let newRackPosition = device.rackPositionForPoint(point: point)
                
            // unhighlight (grid)
            if gridPosition != -1 && !gameView.gridView.gridSlotViews[gridPosition].slotFrame.contains(point) {
                gameView.gridView.endActiveHover(tileView: tileView, position: gridPosition)
                gridPositionForTouch[touch] = -1
            }
            
            // highlight (grid)
            if gridPosition == -1 {
                let newGridPosition = device.gridPositionForPoint(point: point)
                if newGridPosition != -1 {
                    let gridTile = gameView.gridView.grid.tiles[newGridPosition]
                    if rules.canDrop(tile: tileView.tile, gridTile: gridTile) {
                        gameView.gridView.beginActiveHover(tileView: tileView, position: newGridPosition)
                        gridPositionForTouch[touch] = newGridPosition
                    }
                }
            }
            
            // trash highlights rack
            if tileView.tile.type == "trash" && !device.gridFrame().contains(point) {
                
                if newRackPosition != rackPosition {
                    gameView.rackView.unsuggestTrashing(position: rackPosition)
                }
                
                if newRackPosition != -1 {
                    gameView.rackView.suggestTrashing(position: newRackPosition)
                }
                
                rackPositionForTouch[touch] = newRackPosition
            }
            
            // if in rack, rearrange rack (except trash!)
            else if device.rackFrame().contains(point) {
                
                let rackPosition = rackPositionForTouch[touch]!
                let newRackPosition = device.rackPositionForPoint(point: point)
                
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
        if game.paused || game.over {
            return
        }
        
        if let tileView = tileViewForTouch[touch] {
            
            if doubleCheckBeforeDropping {
                if gridPositionForTouch[touch]! != -1 {
                    let gridTile = gameView.gridView.grid.tiles[gridPositionForTouch[touch]!]
                    if !rules.canDrop(tile: tileView.tile, gridTile: gridTile) {
                        gridPositionForTouch[touch] = -1
                    }
                }
                
                doubleCheckBeforeDropping = false
            }
            
            let gridPosition = gridPositionForTouch[touch]!
            let rackPosition = rackPositionForTouch[touch]!
            

            tileView.view.removeFromSuperview()
            
            if gridPosition == -1 {
                
                if tileView.tile.type == "trash" {
                    gameView.rackView.dropTrash(position: rackPosition, trashTileView: tileView)
                }
                
                else {
                    tileView.slideToRackPosition(position: rackPosition, duration: dropDuration)
                    gameView.rackView.takeTile(tileView: tileView, position: rackPosition)
                }
                
            } else {
                gameView.gridView.handleDrop(tileView: tileView, position: gridPosition)
                gameView.refillRack()
            }
            
            tileViewForTouch.removeValue(forKey: touch)
            rackPositionForTouch.removeValue(forKey: touch)
            gridPositionForTouch.removeValue(forKey: touch)

            
        }
    }

    
}
