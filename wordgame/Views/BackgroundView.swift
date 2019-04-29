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
    
    init() {
        view = UIView(frame: device.screenBounds)
        
        gradient = CAGradientLayer()
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
        
        streakView = UIImageView()
        
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
        streakView.image = UIImage(named: "zigzag")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
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
