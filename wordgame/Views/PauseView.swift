//
//  PauseView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/22/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


class PauseView {
    
    
    
    var view: UIView
    
    var pauseButton: UIImageView
    var barView: UIView
    var curtainView: UIView
    
    var curtainMask: CAShapeLayer
    
    var restartButton: UIView
    var restartLabel: UILabel
    
    
    init() {
        
        view = UIView(frame: device.screenBounds)
        
        pauseButton = UIImageView(frame: device.pauseButtonFrame())
        pauseButton.image = UIImage(named: "pause")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pauseButton.tintColor = gridSlotColorHighlight()
        buttonHandler.addButton(frame: pauseButton.frame, action: "pause")
        view.addSubview(pauseButton)
        
        barView = UIView(frame: device.pauseBarFrame())
        barView.layer.borderWidth = CGFloat(1.0)
        barView.layer.borderColor = barColor.cgColor
        view.addSubview(barView)
        
        curtainView = UIView(frame: device.screenBounds)
        view.addSubview(curtainView)
        curtainMask = CAShapeLayer()
        curtainMask.path = CGPath(rect: device.pauseBarFrame(), transform: nil)
        curtainView.layer.mask = curtainMask
        
        restartButton = UIView(frame: device.menuButtonFrame(i: 0))
        restartButton.backgroundColor = menuButtonColor()
        restartButton.layer.cornerRadius = device.menuButtonRadius
        curtainView.addSubview(restartButton)
        
        restartLabel = UILabel(frame: device.menuButtonFrame(i: 0))
        restartLabel.font = menuFont
        restartLabel.textColor = menuTextColor()
        restartLabel.textAlignment = .center
        restartLabel.adjustsFontSizeToFitWidth = true
        restartLabel.baselineAdjustment = .alignCenters
        restartLabel.text = "Restart"
        curtainView.addSubview(restartLabel)
        
    }
    
    func pause() {
        pauseButton.image = UIImage(named: "resume")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pauseButton.tintColor = gridSlotColorHighlight()
        
        animateMaskToRect(mask: curtainMask, rect: device.pauseCurtainFramePaused(), duration: pauseDuration)
        
        UIView.animate(withDuration: pauseDuration, animations: {
            //self.curtainView.frame = device.pauseCurtainFramePaused()
            self.barView.frame = device.pauseBarFramePaused()
        }, completion: { (finished: Bool) in
            self.barView.alpha = CGFloat(0.0)
        })
    }
    
    func unpause() {
        pauseButton.image = UIImage(named: "pause")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pauseButton.tintColor = gridSlotColorHighlight()
        self.barView.alpha = 1.0
        
        animateMaskToRect(mask: curtainMask, rect: device.pauseBarFrame(), duration: pauseDuration)
        
        UIView.animate(withDuration: pauseDuration, animations: {
            //self.curtainView.frame = device.pauseBarFrame()
            self.barView.frame = device.pauseBarFrame()
        }, completion: { (finished: Bool) in
            self.barView.alpha = 1.0
        })
    }
    
    func switchToNightMode() {
        pauseButton.tintColor = gridSlotColorHighlight()
    }
    
}
