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
    var tileViews: Set<TileView>
    
    // rack object keeps track of [0,1,2,3] what's going on at each slot
    // tileViews is a set of moving tileView objects
    
    var rackFrame: CGRect
    
    var view: UIView
    var rackView: UIView
    
    init(rack: Rack) {
        
        self.rack = rack
        
        rackSlotViews = []
        tileViews = Set<TileView>()
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
        
        createTiles()
    }
    
    func createTiles() {
        
        for i in 0...3 {
            if rack.tiles[i].type != "null" {
                let tileView = TileView(tile: rack.tiles[i], rackPosition: i)
                tileViews.insert(tileView)
                view.addSubview(tileView.view)
            }
        }
        
    }
    
    func giveTile(tileView: TileView, position: Int) {
        rack.tiles[position] = Tile()
        tileViews.remove(tileView)
        tileView.view.removeFromSuperview()
    }
    
    func takeTile(tileView: TileView, position: Int) {
        rack.tiles[position] = tileView.tile
        tileViews.insert(tileView)
        view.addSubview(tileView.view)
    }
    

    // BAD!
    func push(from: Int, direction: Int) {
        rack.push(from: from, direction: direction)
        //createTiles()
    }
    
    
}



















