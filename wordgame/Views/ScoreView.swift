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
    
    var view: UIView
    var scoreView: UILabel
    var levelView: UILabel
    
    init(game: Game) {
        
        self.game = game
        
        
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
    
    func update() {
        scoreView.text = String(game.currentScore)
        levelView.text = levelPrefix + String(game.currentLevel)
    }
    
}
