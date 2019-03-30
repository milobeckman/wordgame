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
    
    var view: UIView
    
    
    init(gridView: GridView, rackView: RackView) {
        
        self.gridView = gridView
        self.rackView = rackView
        
        statsView = UIView(frame: device.statsFrame())
        statsLabels = []
        
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
        setupStatsLabels()
        
        
        view.addSubview(statsView)
        
        for label in statsLabels {
            print(label.frame)
            view.addSubview(label)
        }
        
    }
    
    func setupStatsLabels() {
        
        for i in 0...4 {
            let newLabel = UILabel(frame: device.statsLabelFrame(i: i))
            newLabel.font = statsFont
            newLabel.textColor = statsTextColor
            statsLabels.append(newLabel)
        }
        
        statsLabels[0].text = "Tiles dropped: " + String(game.tilesDropped)
        statsLabels[2].text = "Words cleared: " + String(game.wordsCleared)
        statsLabels[3].text = "Avg word score: " + String(game.averageWordScore())
        statsLabels[4].text = "Longest streak: " + String(game.longestStreak)
        
    }
    
    
}
