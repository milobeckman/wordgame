//
//  WordDataLineView.swift
//  wordgame
//
//  Created by Milo Beckman on 4/25/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


class WordDataLineView {
    
    var data: [String]
    
    var y: CGFloat
    var view: UIView
    
    var frame: CGRect
    var wordAndScoreFrame: CGRect
    var multiplierFrame: CGRect
    
    var wordLabel: UILabel
    var multiplierShadowLabel: UILabel
    var multiplierLabel: UILabel
    var scoreLabel: UILabel
    
    init(data: [String], i: Int) {
        
        self.data = data
        y = (device.statsHeight + device.paddingBetweenStats)*CGFloat(i) + device.paddingBetweenStats
        
        let width = device.wordDataFrame().width
        let multiplierX = width*device.wordDataMultiplierLocationRatio
        frame = CGRect(x: 0, y: y, width: width, height: device.statsHeight)
        wordAndScoreFrame = CGRect(x: device.paddingInsideWordData, y: 0,
                                   width: width - 2*device.paddingInsideWordData, height: device.statsHeight)
        multiplierFrame = CGRect(x: multiplierX, y: 0, width: width-multiplierX, height: device.statsHeight)
        
        wordLabel = UILabel(frame: wordAndScoreFrame)
        wordLabel.font = statsTextFont
        wordLabel.textColor = statsTextColor()
        wordLabel.textAlignment = .left
        wordLabel.adjustsFontSizeToFitWidth = true
        wordLabel.baselineAdjustment = .alignCenters
        wordLabel.text = data[0]
        
        multiplierShadowLabel = UILabel(frame: multiplierFrame.offsetBy(dx: device.multiplierShadowDepth,
                                                                        dy: device.multiplierShadowDepth))
        multiplierShadowLabel.font = statsNumberFont
        multiplierShadowLabel.textColor = UIColor.black
        multiplierShadowLabel.textAlignment = .left
        multiplierShadowLabel.adjustsFontSizeToFitWidth = true
        multiplierShadowLabel.baselineAdjustment = .alignCenters
        multiplierShadowLabel.text = data[1]
        multiplierShadowLabel.isHidden = game.currentLevel < 15
        
        multiplierLabel = UILabel(frame: multiplierFrame)
        multiplierLabel.font = statsNumberFont
        multiplierLabel.textColor = data[1] == "x2" ? badgeColorCombo : badgeColorStreak
        multiplierLabel.textAlignment = .left
        multiplierLabel.adjustsFontSizeToFitWidth = true
        multiplierLabel.baselineAdjustment = .alignCenters
        multiplierLabel.text = data[1]
        
        scoreLabel = UILabel(frame: wordAndScoreFrame)
        scoreLabel.font = statsNumberFont
        scoreLabel.textColor = statsNumberColor()
        scoreLabel.textAlignment = .right
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.baselineAdjustment = .alignCenters
        scoreLabel.text = data[2]
        
        view = UIView(frame: frame)
        view.addSubview(wordLabel)
        view.addSubview(multiplierShadowLabel)
        view.addSubview(multiplierLabel)
        view.addSubview(scoreLabel)
    }
    
    
    
    
}
