//
//  GridView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/12/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class RackView {
    
    var rack: Rack
    
    var rackSlotViews: [RackSlotView]
    var tileViews: [TileView]
    
    var rackFrame: CGRect
    
    var view: UIView
    var rackView: UIView
    
    var tileViewForTouch: [UITouch: TileView]
    
    init(rack: Rack) {
        
        self.rack = rack
        
        rackSlotViews = []
        tileViews = []
        view = UIView(frame: vc.screenBounds)
        
        // slots
        for i in 0...3 {
            let newRackSlot = RackSlotView(position: i)
            rackSlotViews.append(newRackSlot)
            view.addSubview(newRackSlot.view)
        }
        
        rackFrame = vc.rackFrame()
        rackView = UIView(frame: rackFrame)
        view.addSubview(rackView)
        
        tileViewForTouch = [:]
        
        updateTiles()
    }
    
    func updateTiles() {
        
        // clean
        for tileView in tileViews {
            tileView.view.removeFromSuperview()
        }
        
        // update
        tileViews = []
        for i in 0...3 {
            if rack.tiles[i].type != "null" {
                let tileView = TileView(tile: rack.tiles[i], rackPosition: i)
                tileViews.append(tileView)
            }
        }
        
        // draw
        for tileView in tileViews {
            view.addSubview(tileView.view)
        }
    }
    
    func liftTile(touch: UITouch) {
        let point = touch.location(in: view)
        for tileView in tileViews {
            if tileView.tileFrame.contains(point) && tileView.tile.type != "null" {
                tileView.lift(point: point)
                tileViewForTouch[touch] = tileView
            }
        }
    }
    
    func dragTile(touch: UITouch) {
        if let tileView = tileViewForTouch[touch] {
            tileView.drag(point: touch.location(in: view))
        }
    }
    
    func dropTile(touch: UITouch) {
        if let tileView = tileViewForTouch[touch] {
            tileView.drop(point: touch.location(in: view))
        }
    }
}



















