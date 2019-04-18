//
//  ScoreView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/22/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


let levelPrefix = "Level: "

class ScoreView {
    
    var game: Game
    var displayScore: Int
    
    var view: UIView
    var scoreView: UILabel
    var levelView: UILabel
    
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
        
    }
    
    func updateView() {
        scoreView.text = String(displayScore)
        scoreView.textColor = scoreTextColor(level: game.currentLevel)
        
        levelView.text = levelPrefix + String(game.currentLevel)
        levelView.textColor = levelTextColor(level: game.currentLevel)
    }
    
    func showyUpdate() {
        updateView()
        
        if displayScore < game.currentScore {
            displayScore += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + scoreTickInterval, execute: {
                self.showyUpdate()
            })
        }
    }
    
}
