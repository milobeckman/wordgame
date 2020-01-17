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
    var streakView: UIImageView
    var middleView: UIView
    
    var spaceView: UIImageView
    var cloudView: UIImageView
    
    var progress = 1.0
    
    init() {
        view = UIView(frame: device.screenBounds)
        
        gradient = CAGradientLayer()
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
        
        streakView = UIImageView()
        
        spaceView = UIImageView(frame: device.spaceViewFrame(level: 1.0))
        spaceView.image = UIImage(named: "space-v7.png")
        view.addSubview(spaceView)
        
        cloudView = UIImageView(frame: device.cloudViewFrame(level: 1.0))
        cloudView.image = UIImage(named: "cloud.png")
        view.addSubview(cloudView)
        
        middleView = UIView(frame: device.screenBounds)
        middleView.backgroundColor = middleColor
        view.addSubview(middleView)
        
        updateView()
    }
    
    func update() {
        
        let maxIncrementWithoutLevelIncrease = 1.5
        let incrementPerTileDropped = 0.2
        
        let increment = incrementPerTileDropped * Double(game.tilesDroppedSinceLastLevelIncrease)
        let newProgress = Double(game.currentLevel) + min(increment, maxIncrementWithoutLevelIncrease)
        
        if newProgress > progress {
            progress = newProgress
            updateView()
        }
    }
    
    func updateView() {
        let bottom = gradientBottomColor(level: progress).cgColor
        let top = gradientTopColor(level: progress).cgColor
        gradient.colors = [top, bottom]
        
        UIView.animate(withDuration: backgroundRiseDuration, animations: {
            self.spaceView.frame = device.spaceViewFrame(level: self.progress)
            self.cloudView.frame = device.cloudViewFrame(level: self.progress)
        })
    }
    
    func showOrIncreaseStreakView(multiplier: Int) {
        if multiplier == 2 {
            showStreakView()
        } else {
            increaseStreakView()
        }
    }
    
    func showStreakView() {
        
        let height = device.screenWidth * zigzagHeight / zigzagWidth
        let streakImageFrame = CGRect(x: 0, y: 0, width: device.screenWidth, height: height)
        streakView = UIImageView(frame: streakImageFrame)
        streakView.image = UIImage(named: "zigzag")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        streakView.tintColor = badgeColorCombo
        streakView.alpha = streakViewAlpha
        view.addSubview(streakView)
        
        streakView.alpha = 0.0
        UIView.animate(withDuration: streakViewFadeDuration, animations: {
            self.streakView.alpha = streakViewAlpha
        }, completion: nil)
        
        moveStreakView()
    }
    
    func moveStreakView() {
        if game.currentMultiplier() == 1 {
            return
        }
        
        let duration = game.currentMultiplier() == 2 ? repeatTimeCombo : repeatTimeStreak
        let dy = repeatHeightInZigzagImage * device.screenWidth / zigzagWidth
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
            self.streakView.transform = CGAffineTransform(translationX: 0, y: -dy)
        }, completion: { (finished: Bool) in
            self.streakView.transform = .identity
            self.moveStreakView()
        })
    }
    
    
    func ice() {
        middleView.backgroundColor = iceColor
        middleView.alpha = 0.6
    }
    
    func unice() {
        UIView.animate(withDuration: expireDuration, animations: {
            self.middleView.backgroundColor = middleColor
            self.middleView.alpha = 1.0
        })
    }
    
    
    
    
    
    // trash
    func increaseStreakView() {
        UIView.animate(withDuration: streakViewFadeDuration, animations: {
            self.streakView.tintColor = badgeColorStreak
        }, completion: nil)
    }
    
    func hideStreakView() {
        UIView.animate(withDuration: streakViewFadeDuration, animations: {
            self.streakView.alpha = 0.0
        }, completion: { (finished: Bool) in
            self.streakView.removeFromSuperview()
        })
    }
    
}
