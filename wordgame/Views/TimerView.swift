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
    
    init() {
        ticker = Timer()
        totalTime = 0
        timeLeft = 0
        
        view = UIView(frame: vc.screenBounds)
        backgroundView = UIView(frame: vc.timerFrame())
        barView = UIView(frame: vc.timerFrame())
        barView.backgroundColor = UIColor.red
        
        view.addSubview(backgroundView)
        view.addSubview(barView)
        
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
    }
    
    
}
