//
//  GridSlotView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class GridSlotView {
    
    // location
    var gridPosition: Int
    
    // frames
    var slotFrame: CGRect
    
    // views
    var view: UIView
    var slotView: UIView
    
    init(position: Int) {
        
        gridPosition = position
        slotFrame = device.gridSlotFrame(position: gridPosition)
        
        // views
        view = UIView(frame: device.screenBounds)
        view.alpha = gridSlotAlpha
        
        slotView = UIView(frame: slotFrame)
        slotView.layer.cornerRadius = device.tileRadius
        slotView.backgroundColor = gridSlotColor
        view.addSubview(slotView)
        
    }
    
    convenience init() {
        self.init(position: 0)
    }
    
    func highlight() {
        slotView.backgroundColor = gridSlotColorHighlight
    }
    
    func unhighlight() {
        slotView.backgroundColor = gridSlotColor
    }
    
    func hide() {
        view.alpha = 0.0
    }
    
    func unhide() {
        view.alpha = gridSlotAlpha
    }
    
    func suggestRevival() {
        view.alpha = gridSlotAlpha
        slotView.backgroundColor = gridSlotColorRebirth
    }
    
    func unsuggestRevival() {
        view.alpha = 0.0
        slotView.backgroundColor = gridSlotColor
    }
    
    func die() {
        let anchorX = slotFrame.midX/view.frame.width
        let anchorY = slotFrame.midY/view.frame.height
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: view)
        slotView.backgroundColor = gridSlotColorDying

        UIView.animate(withDuration: dieDuration, animations: {
            self.slotView.backgroundColor = gridSlotColor
            self.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01).rotated(by: dieAngle)
            self.view.alpha = 0.0
        }, completion: { (finished: Bool) in

            // grid slot is still hidden, but back to normal size/shape
            self.view.transform = .identity
        })
        
        // make sure we don't drop on dead square
        dragHandler.doubleCheckBeforeDropping = true
    }
    
    func revive() {
        suggestRevival()
        
        UIView.animate(withDuration: reviveDuration, animations: {
            self.slotView.backgroundColor = gridSlotColor
        }, completion: nil)
        
        // check that completion nil is fine
    }
    
    
    
    
    
    
}
