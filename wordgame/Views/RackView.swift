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
        
        refreshTiles()
    }
    
    func refreshTiles() {
        
        // clean
        var newTileViews = [TileView]()
        for tileView in tileViews {
            if tileView.lifted {
                newTileViews.append(tileView)
            }
            
            tileView.view.removeFromSuperview()
        }
        
        // update
        for i in 0...3 {
            if rack.tiles[i].type != "null" {
                let tileView = TileView(tile: rack.tiles[i], rackPosition: i)
                newTileViews.append(tileView)
            }
        }
        
        // draw
        tileViews = newTileViews
        for tileView in tileViews where !tileView.lifted {
            view.addSubview(tileView.view)
        }
        for tileView in tileViews where tileView.lifted {
            view.addSubview(tileView.view)
        }
    }
    
    func giveTile(tileView: TileView, position: Int) {
        rack.tiles[position] = Tile()
        refreshTiles()
    }
    
    func moveTile(from: Int, to: Int) {
        rack.moveTile(from: from, to: to)
        refreshTiles()
    }
    
    func takeTile(tileView: TileView, position: Int) {
        rack.tiles[position] = tileView.tile
        tileView.lifted = false
        tileView.moveToRackPosition(position: position, duration: 1.0)
        //refreshTiles()
    }
    
    func push(from: Int, direction: Int) {
        rack.push(from: from, direction: direction)
        refreshTiles()
    }
    
    
}



















