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
    var tileViews: Set<TileView>
    
    // rack object keeps track of [0,1,2,3] what's going on at each slot
    // tileViews is a set of moving tileView objects
    
    var rackFrame: CGRect
    
    var view: UIView
    var rackView: UIView
    
    init(rack: Rack) {
        
        self.rack = rack
        
        tileViews = Set<TileView>()
        view = UIView(frame: vc.screenBounds)
        
        // THIS ISN'T USED ATM
        rackFrame = vc.rackFrame()
        rackView = UIView(frame: rackFrame)
        rackView.backgroundColor = vc.rackColor
        rackView.layer.shadowColor = UIColor.black.cgColor
        //rackView.layer.shadowOpacity = 0.5
        rackView.layer.shadowRadius = 3
        rackView.layer.shadowOffset = CGSize(width: 0, height: 5)
        
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
    
    func serveNewTile(position: Int) {
        let tile = rules.newTile()
        let tileView = TileView(tile: tile, rackPosition: position)

        rack.tiles[position] = tileView.tile
        tileViews.insert(tileView)
        
        view.addSubview(tileView.view)
        tileView.prepareToPop()
        tileView.pop()
        
        game.checkIfGameOver()
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
    
    func push(from: Int, direction: Int) {
        
        var i = from + direction
        while (rack.tiles[i].type != "null") {
            i += direction
        }
        while i != from {
            slideTile(from: i-direction, direction: direction)
            i -= direction
        }
        
        rack.push(from: from, direction: direction)
    }
    
    func slideTile(from: Int, direction: Int) {
        for tileView in tileViews {
            if vc.rackPositionForPoint(point: tileView.depthFrame.origin) == from {
                tileView.slideToRackPosition(position: from + direction, duration: vc.slideDuration)
            }
        }
    }
    
    
}



















