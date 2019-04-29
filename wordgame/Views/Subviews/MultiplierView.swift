//
//  MultiplierView.swift
//  wordgame
//
//  Created by Milo Beckman on 4/26/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


class MultiplierView {
    
    var view: UIView
    var depthView: UIImageView
    var imageView: UIImageView
    var shineView: UIImageView
    
    init(multiplier: Int) {
        
        let assetName = multiplier == 2 ? "combo" : "streak"
        let assetNameShine = assetName + "-shine"
        
        let color = multiplier == 2 ? badgeColorCombo : badgeColorStreak
        let depthColor = multiplier == 2 ? comboDepthColor : streakDepthColor
        
        view = UIView(frame: device.screenBounds)
        
        depthView = UIImageView(frame: device.gridFrame().offsetBy(dx: device.multiplierDepth, dy: device.multiplierDepth))
        depthView.image = UIImage(named: assetName)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        depthView.tintColor = depthColor
        depthView.layer.shadowColor = badgeShadowColor.cgColor
        depthView.layer.shadowOpacity = 1
        depthView.layer.shadowOffset = CGSize.zero
        depthView.layer.shadowRadius = device.multiplierShadowRadius
        
        imageView = UIImageView(frame: device.gridFrame())
        imageView.image = UIImage(named: assetName)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imageView.tintColor = color
        
        shineView = UIImageView(frame: device.gridFrame())
        shineView.image = UIImage(named: assetNameShine)
        shineView.alpha = 0.6
        
        view.addSubview(depthView)
        view.addSubview(imageView)
        view.addSubview(shineView)
    }
    
    func pop() {
        
        view.alpha = 0.0
        view.transform = CGAffineTransform(translationX: 0, y: multiplierFadeInHeight)
        
        UIView.animate(withDuration: multiplierFadeInDuration, animations: {
            self.view.alpha = 1.0
            self.view.transform = .identity
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: multiplierFadeOutDuration,
                           delay: multiplierDisplayDuration, options: [], animations: {
                self.view.alpha = 0.0
            }, completion: { (finished: Bool) in
                self.view.removeFromSuperview()
            })
        })
        
    }
    
}






























