//
//  BackgroundView.swift
//  wordgame
//
//  Created by Milo Beckman on 4/9/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


class BackgroundView {
    
    var view: UIView
    var gradient: CAGradientLayer
    var middleView: UIView
    
    init() {
        view = UIView(frame: device.screenBounds)
        
        gradient = CAGradientLayer()
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
        
        middleView = UIView(frame: device.screenBounds)
        middleView.backgroundColor = middleColor
        view.addSubview(middleView)
    }
    
    func update() {
        let trueLevel = rules.trueLevel(tilesServed: game.tilesServed)
        
        let bottom = gradientBottomColor(level: trueLevel).cgColor
        let top = gradientTopColor(level: trueLevel).cgColor
        gradient.colors = [top, bottom]
    }
    
}
