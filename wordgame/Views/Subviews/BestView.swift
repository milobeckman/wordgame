//
//  BestView.swift
//  wordgame
//
//  Created by Milo Beckman on 4/26/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class BestView {
    
    
    var view: UIView
    
    var depthView: UIView
    var bestView: UIView
    var label: UILabel
    
    
    init() {
        
        let frame = CGRect(x: 0, y: 0, width: device.bestWidth, height: device.bestHeight)
        
        depthView = UIView(frame: frame.offsetBy(dx: device.bestDepth, dy: device.bestDepth))
        depthView.backgroundColor = bestDepthColor
        depthView.layer.cornerRadius = device.bestRadius
        
        bestView = UIView(frame: frame)
        bestView.backgroundColor = bestColor
        bestView.layer.cornerRadius = device.bestRadius
        
        label = UILabel(frame: frame)
        label.font = bestFont
        label.textColor = bestTextColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.text = "BEST!"
        
        view = UIView(frame: device.screenBounds)
        view.addSubview(depthView)
        view.addSubview(bestView)
        view.addSubview(label)
        
    }
    
    func moveTo(x: CGFloat, y: CGFloat) {
        view.transform = CGAffineTransform(translationX: x, y: y)
    }
    
    
}
