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
    var playSomethingView: UILabel
    var shadowView: UIView
    
    let numCriticalPhases = 3
    
    init() {
        ticker = Timer()
        totalTime = 0
        timeLeft = 0
        
        view = UIView(frame: vc.screenBounds)
        
        backgroundView = UIView(frame: vc.timerFrame())
        backgroundView.backgroundColor = vc.timerBackgroundColor
        
        barView = UIView(frame: vc.timerFrame())
        
        playSomethingView = UILabel(frame: vc.timerFrame())
        playSomethingView.font = vc.playSomethingFont
        playSomethingView.textAlignment = .center
        playSomethingView.adjustsFontSizeToFitWidth = true
        playSomethingView.baselineAdjustment = .alignCenters
        playSomethingView.text = "Play something!"
        playSomethingView.isHidden = true
        
        shadowView = UIView(frame: vc.timerShadowFrame())
        let shadow = CAGradientLayer()
        shadow.frame = shadowView.bounds
        shadow.colors = [vc.timerShadowStartColor.cgColor, vc.timerShadowEndColor.cgColor]
        shadowView.layer.insertSublayer(shadow, at: 0)
        
        view.addSubview(backgroundView)
        view.addSubview(barView)
        view.addSubview(playSomethingView)
        view.addSubview(shadowView)
        
        resetTimer()
    }
    
    func resetTimer() {
        endCritical()
        
        if game.over {
            return
        }
        
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
        if game.paused || game.over || timeLeft <= 0 {
            return
        }
        
        timeLeft -= vc.tickInterval
        if timeLeft <= 0 {
            timesAlmostUp()
        }
        
        updateView()
    }
    
    func timesAlmostUp() {
        
        let phaseLength = rules.playSomethingDuration/Double(numCriticalPhases)
        for i in 0...numCriticalPhases-1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)*phaseLength, execute: {
                self.critical(phase: i)
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + rules.playSomethingDuration, execute: {
            self.timesUp()
        })
    }
    
    func critical(phase: Int) {
        if timeLeft > 0 {
            return
        }
            
        playSomethingView.isHidden = false
        
        switch phase % 2 {
        case 0:
            playSomethingView.backgroundColor = vc.playSomethingBackgroundColor[0]
            playSomethingView.textColor = vc.playSomethingTextColor[0]
        case 1:
            playSomethingView.backgroundColor = vc.playSomethingBackgroundColor[1]
            playSomethingView.textColor = vc.playSomethingTextColor[1]
            
        default:
            endCritical()
        }
    }
    
    func endCritical() {
        backgroundView.backgroundColor = vc.timerBackgroundColor
        playSomethingView.isHidden = true
    }
    
    func timesUp() {
        // if timeLeft > 0, we played in time
        if timeLeft <= 0 {
            gameView.timesUp()
            resetTimer()
        }
    }
    
    func updateView() {
        let fraction = timeLeft / totalTime
        barView.frame = vc.timerBarFrame(fraction: fraction)
        barView.backgroundColor = vc.timerBarColor(fraction: fraction)
    }
    
    
}
