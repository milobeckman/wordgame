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
    
    init(gameView: GameView) {
        self.gameView = gameView
        tileViewForTouch = [:]
    }
    
    
    func liftTile(touch: UITouch) {
        let point = touch.location(in: gameView.view)
        for tileView in gameView.rackView.tileViews {
            if tileView.tileFrame.contains(point) && tileView.tile.type != "null" {
                tileView.lift(point: point)
                tileViewForTouch[touch] = tileView
            }
        }
    }
    
    func dragTile(touch: UITouch) {
        if let tileView = tileViewForTouch[touch] {
            tileView.drag(point: touch.location(in: gameView.view))
        }
    }
    
    func dropTile(touch: UITouch) {
        if let tileView = tileViewForTouch[touch] {
            tileView.drop(point: touch.location(in: gameView.view))
        }
    }
    
}
