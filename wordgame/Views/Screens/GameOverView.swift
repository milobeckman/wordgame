//
//  GameOverView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/30/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


class GameOverView {
    
    var gridView: GridView
    var rackView: RackView
    
    var statsView: UIView
    var statsLabels: [UILabel]
    var statsStrings: [NSMutableAttributedString]
    
    var view: UIView
    
    
    init(gridView: GridView, rackView: RackView) {
        
        self.gridView = gridView
        self.rackView = rackView
        
        statsView = UIView(frame: device.statsFrame())
        statsLabels = []
        statsStrings = []
        
        view = UIView(frame: device.screenBounds)
    }
    
    func gameOver() {
        view.addSubview(gridView.view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + waitBeforeShrinking, execute: {
            self.shrinkGridView()
        })
    }
    
    func shrinkGridView() {
        let anchorX = device.gridX / view.frame.width
        let anchorY = device.gridY / view.frame.height
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: gridView.view)
        
        let scale = CGAffineTransform(scaleX: gameOverGridScale, y: gameOverGridScale)
        UIView.animate(withDuration: shrinkDuration, animations: {
            self.gridView.view.transform = scale
            self.rackView.view.alpha = 0.0
        }, completion: { (finished: Bool) in
            self.showStats()
        })
    }
    
    func showStats() {
        
        setupStatsStrings()
        setupStatsLabels()
        
        view.addSubview(statsView)
        
        for label in statsLabels {
            view.addSubview(label)
        }
        
    }
    
    
    func setupStatsStrings() {
        
        statsStrings = []
        
        let textStrings = ["Tiles dropped: ",
                           "",
                           "Words cleared: ",
                           "Avg. word score: ",
                           "Longest streak: "]
        let numberStrings = [String(game.tilesDropped),
                             "",
                             String(game.wordsCleared),
                             String(game.averageWordScore()),
                             String(game.longestStreak)]
        
        let textAttributes: [NSAttributedStringKey: Any] =
                                [.foregroundColor: statsTextColor,
                                 .font: statsTextFont as Any]
        let numberAttributes: [NSAttributedStringKey: Any] =
                                [.foregroundColor: statsNumberColor,
                                 .font: statsNumberFont as Any]
        
        for i in 0...4 {
            let newText = NSMutableAttributedString(string: textStrings[i], attributes: textAttributes)
            let newNumber = NSAttributedString(string: numberStrings[i], attributes: numberAttributes)
            newText.append(newNumber)
            statsStrings.append(newText)
        }
    }
    
    func setupStatsLabels() {
        
        statsLabels = []
        
        for i in 0...4 {
            let newLabel = UILabel(frame: device.statsLabelFrame(i: i))
            newLabel.attributedText = statsStrings[i]
            statsLabels.append(newLabel)
        }
    }
    
    
    
}
