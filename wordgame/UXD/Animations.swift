//
//  Animations.swift
//  wordgame
//
//  Created by Milo Beckman on 3/30/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit



// TileView.pop()
let popDuration = 0.5
let popDelay = 0.15
let popDamping = CGFloat(0.6)

// RackView.slideTile(), takeTile()
let slideDuration = 0.2
let dropDuration = 0.1

// TileView.evaporate()
let evaporateDuration = 1.0         // 1.5
let evaporateHeight = CGFloat(0.0)  // 6.0

// GridSlotView.die(), revive()
let dieDuration = 1.0
let dieAngle = CGFloat(1.0 * .pi)
let reviveDuration = 0.5

// PauseView.pause()
let pauseDuration = 0.8

// GameView.shrinkGridView()
let gameOverGridScale = CGFloat(0.5)
let waitBeforeShrinking = 0.8
let shrinkDuration = 0.65

// GameView.bomb()
let bombInterval = 0.05
let bombRadius = 15.0
let bombRadiusMultipliers = [1.0, 0.9, 0.7, 0.4, 0.15, 0.0]

// BadgeView.display()
let badgeDisplayDuration = 1.4
let badgeFadeDuration = 0.4
let badgeFadeHeight = CGFloat(12.0)

// MultiplierView.pop()
let multiplierFadeInDuration = 0.1
let multiplierFadeInHeight = CGFloat(2.0)
let multiplierDisplayDuration = 1.5
let multiplierFadeOutDuration = 0.2


// screen refresh times
let tickInterval = 0.02
let scoreTickInterval = 0.02





func setAnchorPoint(anchorPoint: CGPoint, view: UIView) {
    var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x,
                           y: view.bounds.size.height * anchorPoint.y)
    
    
    var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x,
                           y: view.bounds.size.height * view.layer.anchorPoint.y)
    
    newPoint = newPoint.applying(view.transform)
    oldPoint = oldPoint.applying(view.transform)
    
    var position = view.layer.position
    position.x -= oldPoint.x
    position.x += newPoint.x
    
    position.y -= oldPoint.y
    position.y += newPoint.y
    
    view.layer.position = position
    view.layer.anchorPoint = anchorPoint
}

func animateMaskToRect(mask: CAShapeLayer, rect: CGRect, duration: Double) {
    
    let newPath = CGPath(rect: rect, transform: nil)
    let animation = CABasicAnimation(keyPath: "path")
    
    animation.fromValue = mask.path
    animation.toValue = newPath
    animation.duration = duration
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    mask.add(animation, forKey: nil)
    
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    mask.path = newPath
    CATransaction.commit()
}
