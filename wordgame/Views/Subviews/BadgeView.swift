//
//  BadgeView.swift
//  wordgame
//
//  Created by Milo Beckman on 4/22/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


class BadgeView {
    
    var score: Int
    var multiplier: Int
    var gridPosition: Int
    
    var badgeFrame: CGRect
    
    var view: UIView
    var badgeView: UIView
    var label: UILabel
    
    init(score: Int, gridPosition: Int) {
        
        self.score = score
        multiplier = game.currentMultiplier()
        self.gridPosition = gridPosition
        
        badgeFrame = device.badgeFrame(gridPosition: gridPosition)
        
        badgeView = UIView(frame: badgeFrame)
        badgeView.backgroundColor = badgeColor(multiplier: multiplier)
        badgeView.layer.cornerRadius = device.badgeRadius
        badgeView.layer.shadowColor = badgeShadowColor.cgColor
        badgeView.layer.shadowOpacity = 1
        badgeView.layer.shadowOffset = CGSize.zero
        badgeView.layer.shadowRadius = device.badgeShadowRadius
        
        label = UILabel(frame: badgeFrame)
        label.font = badgeFont
        label.textColor = badgeTextColor
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.text = "+" + String(score)
        
        view = UIView(frame: device.screenBounds)
        view.addSubview(badgeView)
        view.addSubview(label)
        
    }
    
    func display() {
        DispatchQueue.main.asyncAfter(deadline: .now() + badgeDisplayDuration, execute: {
            UIView.animate(withDuration: badgeFadeDuration, animations: {
                self.view.alpha = 0.0
            }, completion: nil)
        })
        
        UIView.animate(withDuration: badgeDisplayDuration + badgeFadeDuration, animations: {
            self.view.frame = device.screenBounds.offsetBy(dx: 0, dy: -badgeFadeHeight)
        }, completion: { (finished: Bool) in
            self.view.removeFromSuperview()
        })
    }
    
    
}
