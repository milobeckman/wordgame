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
    var multiplierLabel: UILabel
    var scoreLabel: UILabel
    
    init(data: [String], i: Int) {
        
        self.data = data
        y = (device.statsHeight + device.paddingBetweenStats)*CGFloat(i) + device.paddingBetweenStats
        
        let width = device.wordDataFrame().width
        let multiplierX = width*device.wordDataMultiplierLocationRatio
        frame = CGRect(x: 0, y: y, width: width, height: device.statsHeight)
        wordAndScoreFrame = CGRect(x: 0, y: 0, width: width, height: device.statsHeight)
        multiplierFrame = CGRect(x: multiplierX, y: 0, width: width-multiplierX, height: device.statsHeight)
        
        wordLabel = UILabel(frame: wordAndScoreFrame)
        wordLabel.font = statsTextFont
        wordLabel.textColor = statsTextColor()
        wordLabel.textAlignment = .left
        wordLabel.adjustsFontSizeToFitWidth = true
        wordLabel.baselineAdjustment = .alignCenters
        wordLabel.text = data[0]
        
        multiplierLabel = UILabel(frame: multiplierFrame)
        multiplierLabel.font = statsNumberFont
        multiplierLabel.textColor = data[1] == "x2" ? badgeColorDouble : badgeColorTriple
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
        view.addSubview(multiplierLabel)
        view.addSubview(scoreLabel)
    }
    
    
    
    
}
