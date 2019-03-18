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
    
    
    
    
    
    
    
}
