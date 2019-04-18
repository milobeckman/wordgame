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
    
    // visual properties
    var hidden: Bool
    var highlighted: Bool
    
    // frames
    var slotFrame: CGRect
    
    // views
    var view: UIView
    var slotView: UIView
    
    init(position: Int) {
        
        gridPosition = position
        slotFrame = device.gridSlotFrame(position: gridPosition)
        
        hidden = false
        highlighted = false
        
        // views
        view = UIView(frame: device.screenBounds)
        
        slotView = UIView(frame: slotFrame)
        slotView.layer.cornerRadius = device.tileRadius
        slotView.backgroundColor = gridSlotColor()
        view.addSubview(slotView)
        
    }
    
    convenience init() {
        self.init(position: 0)
    }
    
    func update() {
        if hidden {
            view.isHidden = true
        } else {
            view.isHidden = false
        }
        
        if highlighted {
            slotView.backgroundColor = gridSlotColorHighlight()
        } else {
            slotView.backgroundColor = gridSlotColor()
        }
    }
    
    func highlight() {
        highlighted = true
        update()
    }
    
    func unhighlight() {
        highlighted = false
        update()
    }
    
    func hide() {
        hidden = true
        update()
    }
    
    func unhide() {
        hidden = false
        update()
    }
    
    func suggestRevival() {
        view.isHidden = false
        slotView.backgroundColor = gridSlotColorReviving()
    }
    
    func unsuggestRevival() {
        view.isHidden = true
        slotView.backgroundColor = gridSlotColor()
    }
    
    func die() {
        let anchorX = slotFrame.midX/view.frame.width
        let anchorY = slotFrame.midY/view.frame.height
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: view)
        slotView.backgroundColor = gridSlotColorDying()

        UIView.animate(withDuration: dieDuration, animations: {
            self.slotView.backgroundColor = gridSlotColor()
            self.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01).rotated(by: dieAngle)
            self.view.alpha = 0.0
        }, completion: { (finished: Bool) in

            // grid slot is still hidden, but back to normal size/shape
            self.hidden = true
            self.update()
            self.view.transform = .identity
            self.view.alpha = 1.0
        })
        
        // make sure we don't drop on dead square
        dragHandler.doubleCheckBeforeDropping = true
    }
    
    func revive() {
        suggestRevival()
        self.hidden = false
        
        UIView.animate(withDuration: reviveDuration, animations: {
            self.slotView.backgroundColor = gridSlotColor()
        }, completion: { (finished: Bool) in
            self.update()
        })
    }
    
    
    
    
    
    
}
