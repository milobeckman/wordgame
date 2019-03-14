//
//  GridSlotView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class RackSlotView {
    
    // location
    var rackPosition: Int
    
    // frames
    var slotFrame: CGRect
    
    // views
    var view: UIView
    var slotView: UIView
    var plusView: UILabel
    
    init(position: Int) {
        
        rackPosition = position
        slotFrame = vc.rackSlotFrame(position: rackPosition)
        
        // views
        view = UIView(frame: vc.screenBounds)
        
        slotView = UIView(frame: slotFrame)
        slotView.layer.cornerRadius = vc.tileRadius
        slotView.layer.borderWidth = vc.rackSlotWidth
        slotView.layer.borderColor = vc.rackSlotColor.cgColor
        view.addSubview(slotView)
        
        plusView = UILabel(frame: slotFrame)
        plusView.font = vc.rackSlotFont
        plusView.textColor = vc.rackSlotColor
        plusView.textAlignment = .center
        plusView.adjustsFontSizeToFitWidth = true
        plusView.baselineAdjustment = .alignCenters
        plusView.text = "+"
        view.addSubview(plusView)
        
        // todo -- figure out what rack slots should look like
        view.alpha = 0
        
    }
    
    convenience init() {
        self.init(position: 0)
    }
    
    
    
    
    
    
    
}
