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
    var topShadowView: UIView
    var bottomShadowView: UIView
    
    init() {
        ticker = Timer()
        totalTime = 0
        timeLeft = 0
        
        view = UIView(frame: vc.screenBounds)
        
        backgroundView = UIView(frame: vc.timerFrame())
        backgroundView.backgroundColor = vc.timerBackgroundColor
        
        barView = UIView(frame: vc.timerFrame())
        
        topShadowView = UIView(frame: vc.timerTopShadowFrame())
        let topShadow = CAGradientLayer()
        topShadow.frame = topShadowView.bounds
        topShadow.colors = [vc.timerShadowStartColor.cgColor, vc.timerShadowEndColor.cgColor]
        topShadowView.layer.insertSublayer(topShadow, at: 0)
        
        bottomShadowView = UIView(frame: vc.timerBottomShadowFrame())
        let bottomShadow = CAGradientLayer()
        bottomShadow.frame = bottomShadowView.bounds
        bottomShadow.colors = [vc.timerShadowEndColor.cgColor, vc.timerShadowStartColor.cgColor]
        bottomShadowView.layer.insertSublayer(bottomShadow, at: 0)
        
        view.addSubview(backgroundView)
        view.addSubview(barView)
        view.addSubview(topShadowView)
        //view.addSubview(bottomShadowView)
        
        resetTimer()
    }
    
    func resetTimer() {
        totalTime = rules.currentTimerLength()
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
        print("time's up!")
        ticker.invalidate()
        resetTimer()
    }
    
    func updateView() {
        let fraction = timeLeft / totalTime
        barView.frame = vc.timerBarFrame(fraction: fraction)
        barView.backgroundColor = vc.timerBarColor(fraction: fraction)
    }
    
    
}
