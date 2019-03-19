//
//  TileView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class TileView: Hashable {
    
    var tile: Tile
    
    // frames
    var depthFrame: CGRect
    var tileFrame: CGRect
    
    // views
    var view: UIView
    var depthView: UIView
    var tileView: UIView
    var glintLabel: UILabel
    var label: UILabel
    
    // dragging
    var lifted: Bool
    
    // conform to hashable
    var uniqueID: String {
        var id = ""
        id += tile.type + ";"
        id += tile.text + ";"
        id += depthFrame.minX.description + ";"
        id += depthFrame.minY.description + ";"
        id += lifted.description
        return id
    }
    
    var hashValue: Int {
        return uniqueID.hashValue
    }
    
    static func ==(lhs: TileView, rhs: TileView) -> Bool {
        return lhs.uniqueID == rhs.uniqueID
    }
    
    init(tile: Tile) {
        
        self.tile = tile
        
        depthFrame = CGRect()
        tileFrame = CGRect()
        
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
        
        lifted = false
        
        // tile position is not initialized
        // always use a convenience init
    }
    
    convenience init(tile: Tile, gridPosition: Int) {
        self.init(tile: tile)
        moveToGridPosition(position: gridPosition)
    }
    
    convenience init(tile: Tile, rackPosition: Int) {
        self.init(tile: tile)
        moveToRackPosition(position: rackPosition)
    }
    
    func updateView() {
        depthView.frame = depthFrame
        tileView.frame = tileFrame
        glintLabel.frame = tileFrame.offsetBy(dx: vc.tileGlintSize, dy: vc.tileGlintSize)
        label.frame = tileFrame
    }
    
    func slideToGridPosition(position: Int, duration: Double) {
        depthFrame = vc.gridSlotFrame(position: position)
        tileFrame = depthFrame.offsetBy(dx: -vc.tileDepth, dy: -vc.tileDepth)
        lifted = false
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.updateView()
        }, completion: nil)
    }
    
    func moveToGridPosition(position: Int) {
        depthFrame = vc.gridSlotFrame(position: position)
        tileFrame = depthFrame.offsetBy(dx: -vc.tileDepth, dy: -vc.tileDepth)
        lifted = false
        self.updateView()
    }
    
    func slideToRackPosition(position: Int, duration: Double) {
        depthFrame = vc.rackSlotFrame(position: position)
        tileFrame = self.depthFrame.offsetBy(dx: -vc.tileDepth, dy: -vc.tileDepth)
        lifted = false
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.updateView()
        }, completion: nil)
        
    }
    
    func moveToRackPosition(position: Int) {
        depthFrame = vc.rackSlotFrame(position: position)
        tileFrame = self.depthFrame.offsetBy(dx: -vc.tileDepth, dy: -vc.tileDepth)
        lifted = false
        self.updateView()
    }
    
    func recenter(point: CGPoint) {
        let newX = point.x - vc.tileSize/2
        let newY = point.y - vc.tileSize/2
        
        self.depthFrame = CGRect(x: newX, y: newY, width: vc.tileSize, height: vc.tileSize)
        self.tileFrame = self.depthFrame.offsetBy(dx: -vc.tileDepth, dy: -vc.tileDepth)
        self.updateView()
    }
    
    func lift(point: CGPoint) {
        lifted = true
        recenter(point: point)
        
        // a lifted tileView is NOT in the rack.tiles array
        // it is still in rack.tileViews
    }
    
    
    // animations
    
    func prepareToPop() {
        let anchorX = depthFrame.midX/view.frame.width
        let anchorY = depthFrame.midY/view.frame.height
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: view)
        view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    }
    
    func pop() {
        UIView.animate(withDuration: vc.popDuration, delay: 0, usingSpringWithDamping: vc.popDamping, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
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
