//
//  ScoreView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/22/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


let levelPrefix = "Level "

class ScoreView {
    
    var game: Game
    var displayScore: Int
    
    var view: UIView
    var scoreView: UILabel
    var levelView: UILabel
    
    var bestScoreView: BestView
    var showBestScoreView: Bool
    var bestLevelView: BestView
    var showBestLevelView: Bool
    
    init(game: Game) {
        
        self.game = game
        displayScore = 0
        
        view = UIView(frame: device.screenBounds)
        
        scoreView = UILabel(frame: device.scoreFrame())
        scoreView.font = scoreFont
        scoreView.textColor = scoreTextColor(level: game.currentLevel)
        scoreView.textAlignment = .center
        scoreView.adjustsFontSizeToFitWidth = true
        scoreView.baselineAdjustment = .alignCenters
        scoreView.text = String(game.currentScore)
        view.addSubview(scoreView)
        
        levelView = UILabel(frame: device.levelFrame())
        levelView.font = levelFont
        levelView.textColor = levelTextColor(level: game.currentLevel)
        levelView.textAlignment = .center
        levelView.adjustsFontSizeToFitWidth = true
        levelView.baselineAdjustment = .alignCenters
        levelView.text = levelPrefix + String(game.currentLevel)
        view.addSubview(levelView)
        
        bestScoreView = BestView()
        view.addSubview(bestScoreView.view)
        showBestScoreView = false
        bestLevelView = BestView()
        view.addSubview(bestLevelView.view)
        showBestLevelView = false
        
        updateView()
        
    }
    
    func updateView() {
        scoreView.text = String(displayScore)
        scoreView.textColor = scoreTextColor(level: game.currentLevel)
        
        levelView.text = levelPrefix + String(game.currentLevel)
        levelView.textColor = levelTextColor(level: game.currentLevel)
        
        bestScoreView.view.isHidden = !showBestScoreView
        if [10,100,1000].contains(displayScore) {
            repositionBestScoreView()
        }
        bestLevelView.view.isHidden = !showBestLevelView
        if [10,100].contains(game.currentLevel) {
            repositionBestLevelView()
        }
    }
    
    func showyUpdate() {
        updateView()
        
        if displayScore < game.currentScore {
            displayScore += 1
            if !showBestScoreView {
                showBestIfBest()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + scoreTickInterval, execute: {
                self.showyUpdate()
            })
        }
    }
    
    func showBestIfBest() {
        let bestScore = storage.getInt(key: "bestScore")
        if displayScore > bestScore && bestScore > 0 {
            showBestScoreView = true
            repositionBestScoreView()
        }
        let bestLevel = storage.getInt(key: "bestLevel")
        if game.currentLevel > bestLevel && bestLevel > 0 {
            showBestLevelView = true
            repositionBestLevelView()
        }
    }
    
    func repositionBestScoreView() {
        let x = CGFloat(String(displayScore).count)*characterWidthPerFontSize*0.5*scoreTextSize + device.screenWidth*0.5
        bestScoreView.moveTo(x: x, y: device.scoreY)
    }
    
    func repositionBestLevelView() {
        let x = CGFloat((String(game.currentLevel) + levelPrefix).count)*characterWidthPerFontSize*0.5*levelTextSize + device.screenWidth*0.5
        bestLevelView.moveTo(x: x, y: device.levelY - device.bestHeight*0.5)
    }
    
}
