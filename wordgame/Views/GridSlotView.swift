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
        slotFrame = vc.gridSlotFrame(position: gridPosition)
        
        // views
        view = UIView(frame: vc.screenBounds)
        view.alpha = vc.gridSlotAlpha
        
        slotView = UIView(frame: slotFrame)
        slotView.layer.cornerRadius = vc.tileRadius
        slotView.backgroundColor = vc.gridSlotColor
        view.addSubview(slotView)
        
    }
    
    convenience init() {
        self.init(position: 0)
    }
    
    func highlight() {
        slotView.backgroundColor = vc.gridSlotColorHighlight
    }
    
    func unhighlight() {
        slotView.backgroundColor = vc.gridSlotColor
    }
    
    func hide() {
        view.alpha = 0.0
    }
    
    func unhide() {
        view.alpha = vc.gridSlotAlpha
    }
    
    func suggestRebirth() {
        view.alpha = vc.gridSlotAlpha
        slotView.backgroundColor = vc.gridSlotColorRebirth
    }
    
    func unsuggestRebirth() {
        view.alpha = 0.0
        slotView.backgroundColor = vc.gridSlotColor
    }
    
    func die() {
        let anchorX = slotFrame.midX/view.frame.width
        let anchorY = slotFrame.midY/view.frame.height
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: view)

        UIView.animate(withDuration: vc.dieDuration, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01).rotated(by: vc.dieAngle)
            self.view.alpha = 0.0
        }, completion: { (finished: Bool) in

            // grid slot is still hidden, but back to normal size/shape
            self.view.transform = .identity
        })
        
        // make sure we don't drop on dead square
        touchHandler.doubleCheckBeforeDropping = true
    }
    
    func rebirth() {
        suggestRebirth()
        
        UIView.animate(withDuration: vc.rebirthDuration, animations: {
            self.slotView.backgroundColor = vc.gridSlotColor
        }, completion: nil)
        
        // check that completion nil is fine
    }
    
    
    
    
    
    
}
