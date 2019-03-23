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
        
        view = UIView(frame: vc.screenBounds)
        
        scoreView = UILabel(frame: vc.scoreFrame())
        scoreView.font = vc.scoreFont
        scoreView.textColor = vc.scoreTextColor
        scoreView.textAlignment = .center
        scoreView.adjustsFontSizeToFitWidth = true
        scoreView.baselineAdjustment = .alignCenters
        scoreView.text = String(game.currentScore)
        view.addSubview(scoreView)
        
        levelView = UILabel(frame: vc.levelFrame())
        levelView.font = vc.levelFont
        levelView.textColor = vc.levelTextColor
        levelView.textAlignment = .center
        levelView.adjustsFontSizeToFitWidth = true
        levelView.baselineAdjustment = .alignCenters
        levelView.text = levelPrefix + String(game.currentLevel)
        view.addSubview(levelView)
        
    }
    
    func updateView() {
        scoreView.text = String(displayScore)
        levelView.text = levelPrefix + String(game.currentLevel)
    }
    
    func showyUpdate() {
        updateView()
        
        if displayScore < game.currentScore {
            displayScore += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + vc.scoreTickInterval, execute: {
                self.showyUpdate()
            })
        }
    }
    
}
