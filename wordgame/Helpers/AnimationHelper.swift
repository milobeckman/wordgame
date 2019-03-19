//
//  AnimationHelper.swift
//  wordgame
//
//  Created by Milo Beckman on 3/18/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

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
