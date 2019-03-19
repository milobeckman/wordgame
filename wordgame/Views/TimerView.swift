//
//  TimerView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/18/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class TimerView {
    
    var ticker: Timer
    
    var totalTime: Double
    var timeLeft: Double
    
    var view: UIView
    var backgroundView: UIView
    var barView: UIView
    var shadowView: UIView
    
    init() {
        ticker = Timer()
        totalTime = 0
        timeLeft = 0
        
        view = UIView(frame: vc.screenBounds)
        
        backgroundView = UIView(frame: vc.timerFrame())
        backgroundView.backgroundColor = vc.timerBackgroundColor
        
        barView = UIView(frame: vc.timerFrame())
        
        shadowView = UIView(frame: vc.timerShadowFrame())
        let shadow = CAGradientLayer()
        shadow.frame = shadowView.bounds
        shadow.colors = [vc.timerShadowStartColor.cgColor, vc.timerShadowEndColor.cgColor]
        shadowView.layer.insertSublayer(shadow, at: 0)
        
        view.addSubview(backgroundView)
        view.addSubview(barView)
        view.addSubview(shadowView)
        
        resetTimer()
    }
    
    func resetTimer() {
        ticker.invalidate()
        totalTime = rules.timerLength(level: game.currentLevel)
        timeLeft = totalTime
        startTicker()
    }
    
    func startTicker() {
        ticker = Timer.scheduledTimer(timeInterval: vc.tickInterval,
                                      target: self,
                                      selector: #selector(tick),
                                      userInfo: nil,
                                      repeats: true)
    }
    
    @objc func tick() {
        timeLeft -= vc.tickInterval
        if timeLeft <= 0 {
            timesUp()
        }
        
        updateView()
    }
    
    func timesUp() {
        gameView.timesUp()
        resetTimer()
    }
    
    func updateView() {
        let fraction = timeLeft / totalTime
        barView.frame = vc.timerBarFrame(fraction: fraction)
        barView.backgroundColor = vc.timerBarColor(fraction: fraction)
    }
    
    
}
