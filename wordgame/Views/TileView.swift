//
//  TileView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class TileView {
    
    var tile: Tile
    
    // screen location
    var xPos: CGFloat
    var yPos: CGFloat
    
    // frames
    var depthFrame: CGRect
    var tileFrame: CGRect
    
    // views
    var view: UIView
    var depthView: UIView
    var tileView: UIView
    var glintLabel: UILabel
    var label: UILabel
    
    init(tile: Tile) {
        
        self.tile = tile
        
        xPos = CGFloat(0)
        yPos = CGFloat(0)
        
        depthFrame = CGRect(x: xPos, y: yPos, width: vc.tileSize, height: vc.tileSize)
        tileFrame = CGRect(x: xPos - vc.tileDepth, y: yPos - vc.tileDepth, width: vc.tileDepth, height: vc.tileDepth)
        
        // views
        view = UIView(frame: vc.screenBounds)
        
        depthView = UIView(frame: depthFrame)
        depthView.layer.cornerRadius = vc.tileRadius
        depthView.backgroundColor = vc.tileDepthColor
        view.addSubview(depthView)
        
        tileView = UIView(frame: tileFrame)
        tileView.layer.cornerRadius = vc.tileRadius
        tileView.backgroundColor = vc.tileColor
        view.addSubview(tileView)
        
        glintLabel = UILabel(frame: tileFrame)
        glintLabel.font = vc.tileFont
        glintLabel.textColor = vc.tileGlintColor
        glintLabel.textAlignment = .center
        glintLabel.adjustsFontSizeToFitWidth = true
        glintLabel.baselineAdjustment = .alignCenters
        glintLabel.text = tile.text
        view.addSubview(glintLabel)
        
        label = UILabel(frame: tileFrame)
        label.font = vc.tileFont
        label.textColor = vc.tileTextColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.text = tile.text
        view.addSubview(label)
        
        // tile position is not initialized
        // always use a convenience init
    }
    
    convenience init(tile: Tile, gridPosition: Int) {
        self.init(tile: tile)
        moveToGridPosition(position: gridPosition)
    }
    
    func updateView() {
        depthView.frame = depthFrame
        tileView.frame = tileFrame
        glintLabel.frame = tileFrame.offsetBy(dx: vc.tileGlintSize, dy: vc.tileGlintSize)
        label.frame = tileFrame
    }
    
    func moveToGridPosition(position: Int) {
        depthFrame = vc.gridSlotFrame(position: position)
        tileFrame = depthFrame.offsetBy(dx: -vc.tileDepth, dy: -vc.tileDepth)
        
        updateView()
    }
    
    func evaporate() {
        
        depthView.backgroundColor = UIColor.black
        tileView.backgroundColor = UIColor.white
        tileView.layer.borderWidth = CGFloat(3)
        tileView.layer.borderColor = UIColor.black.cgColor
        
        glintLabel.alpha = 0
        label.textColor = UIColor.black
        
        UIView.animate(withDuration: vc.evaporateDuration, animations: {
            self.view.alpha = 0.0
            self.view.frame = vc.screenBounds.offsetBy(dx: 0, dy: -vc.evaporateHeight)
        }, completion: nil)
        
    }
    
    
    
    
    
}
