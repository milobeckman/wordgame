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
    
    var statsStrings: [NSMutableAttributedString]
    
    var gridView: GridView
    var rackView: RackView
    
    var statsView: UIView
    var gameOverLabel: UILabel
    var gameOverLabelShadow: UILabel
    var statsLabels: [UILabel]
    var bestViews: [BestView]
    
    var wordDataView: UIScrollView
    var wordDataTopBar: UIView
    var wordDataBottomBar: UIView
    
    var playAgainButton: UIImageView
    var playAgainButtonGlow: UIImageView
    var glowing: Bool
    
    var view: UIView
    
    
    init(gridView: GridView, rackView: RackView) {
        
        statsStrings = []
        
        self.gridView = gridView
        self.rackView = rackView
        
        statsView = UIView(frame: device.statsFrame())
        gameOverLabelShadow = UILabel(frame: device.gameOverFrame().offsetBy(dx: -device.gameOverDepth, dy: device.gameOverDepth))
        gameOverLabel = UILabel(frame: device.gameOverFrame())
        statsLabels = []
        bestViews = []
        
        wordDataView = UIScrollView(frame: device.wordDataFrame())
        wordDataTopBar = UIView(frame: device.wordDataTopBarFrame())
        wordDataBottomBar = UIView(frame: device.wordDataBottomBarFrame())
        
        playAgainButton = UIImageView(frame: device.playAgainButtonFrame())
        playAgainButton.image = UIImage(named: "play-again")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        playAgainButtonGlow = UIImageView(frame: device.playAgainButtonFrame())
        playAgainButtonGlow.image = UIImage(named: "play-again")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        glowing = false
        
        view = UIView(frame: device.screenBounds)
    }
    
    func gameOver() {
        view.addSubview(gridView.view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + waitBeforeShrinking, execute: {
            self.shrinkGridView()
            // after shrinking this also displays everything
        })
    }
    
    func shrinkGridView() {
        let anchorX = device.gridX / view.frame.width
        let anchorY = device.gridY / view.frame.height
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: gridView.view)
        
        let scale = CGAffineTransform(scaleX: device.gameOverGridScale, y: device.gameOverGridScale)
        UIView.animate(withDuration: shrinkDuration, animations: {
            self.gridView.view.transform = scale
            self.rackView.view.alpha = 0.0
            gameView.timerView.view.alpha = 0.0
        }, completion: { (finished: Bool) in
            self.showStats()
            self.showWordData()
        })
    }
    
    func showStats() {
        
        gameOverLabelShadow.textColor = gameOverShadowColor()
        gameOverLabel.textColor = gameOverLabelColor()
        
        for label in [gameOverLabelShadow, gameOverLabel] {
            label.font = gameOverFont
            label.textAlignment = .left
            label.adjustsFontSizeToFitWidth = true
            label.baselineAdjustment = .alignCenters
            if game.currentScore > storage.getInt(key: "bestScore") {
                label.text = "High score!"
            } else {
                label.text = "Game over"
            }
            view.addSubview(label)
        }
    
        
        setupStatsStrings()
        setupStatsLabels()
        showBestViews()
        view.addSubview(statsView)
        
        for label in statsLabels {
            view.addSubview(label)
        }
        
        view.addSubview(playAgainButton)
        view.addSubview(playAgainButtonGlow)
        buttonHandler.addButton(frame: playAgainButton.frame, action: "restart")
        playAgainButton.tintColor = levelTextColor(level: game.currentLevel)
        glowing = true
        startGlowingPlayAgainButton()
        
        storage.updateHighscores()
        storage.updateStats()
        
    }
    
    func showWordData() {
        
        let wordData = sortedWordData(unsorted: game.wordData)
        let numWords = max(wordData.count, 1) // take care of the empty case!!
        let height = CGFloat(numWords)*(device.statsHeight + device.paddingBetweenStats) + device.paddingBetweenStats
        wordDataView.contentSize = CGSize(width: wordDataView.frame.width, height: height)
        
        var i = 0
        for wordDataLine in wordData {
            let wordDataLineView = WordDataLineView(data: wordDataLine, i: i)
            wordDataView.addSubview(wordDataLineView.view)
            i += 1
        }
        
        wordDataView.backgroundColor = wordDataBackgroundColor
        wordDataTopBar.layer.borderWidth = CGFloat(1.0)
        wordDataTopBar.layer.borderColor = barColor.cgColor
        wordDataBottomBar.layer.borderWidth = CGFloat(1.0)
        wordDataBottomBar.layer.borderColor = barColor.cgColor
        
        view.addSubview(wordDataView)
        view.addSubview(wordDataTopBar)
        view.addSubview(wordDataBottomBar)
    }
    
    
    func setupStatsStrings() {
        
        statsStrings = []
        
        let textStrings = ["Words cleared: ",
                           "Average word: ",
                           "Longest streak: "]
        let numberStrings = [String(game.wordsCleared),
                             String(game.averageWordScore()),
                             String(game.longestStreak)]
        
        let textAttributes: [NSAttributedString.Key: Any] =
                                [.foregroundColor: statsTextColor(),
                                 .font: statsTextFont as Any]
        let numberAttributes: [NSAttributedString.Key: Any] =
                                [.foregroundColor: statsNumberColor(),
                                 .font: statsNumberFont as Any]
        
        for i in 0..<textStrings.count {
            let newText = NSMutableAttributedString(string: textStrings[i], attributes: textAttributes)
            let newNumber = NSAttributedString(string: numberStrings[i], attributes: numberAttributes)
            newText.append(newNumber)
            statsStrings.append(newText)
        }
    }
    
    func setupStatsLabels() {
        
        statsLabels = []
        
        for i in 0..<statsStrings.count {
            let newLabel = UILabel(frame: device.statsLabelFrame(i: i))
            newLabel.attributedText = statsStrings[i]
            newLabel.textAlignment = .left
            statsLabels.append(newLabel)
        }
    }
    
    func showBestViews() {
        
        let bestBools = [game.wordsCleared > storage.getInt(key: "bestWordsCleared"),
                         game.averageWordScore() > storage.getDouble(key: "bestAverageWordScore"),
                         game.longestStreak > storage.getInt(key: "bestStreak")]
        
        for i in 0..<bestBools.count {
            if bestBools[i] {
                let newBestView = BestView()
                let x = device.statsLabelFrame(i: i).maxX - device.bestWidth + device.bestDepth
                let y = device.statsLabelFrame(i: i).minY
                newBestView.moveTo(x: x, y: y)
                bestViews.append(newBestView)
                view.addSubview(newBestView.view)
            }
        }
    }
    
    func startGlowingPlayAgainButton() {
        if !glowing {
            return
        }
        
        playAgainButtonGlow.tintColor = UIColor.white
        playAgainButtonGlow.alpha = 0.0
        UIView.animate(withDuration: glowUpDuration, animations: {
            self.playAgainButtonGlow.alpha = playAgainButtonGlowAlpha()
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: glowUpDuration, animations: {
                self.playAgainButtonGlow.alpha = 0.0
            }, completion: { (finished: Bool) in
                self.startGlowingPlayAgainButton()
            })
        })
    }
    
    func sortedTileIDs(unsorted: [String: Double]) -> [String] {
        return Array(unsorted.keys).sorted() {
            let obj1 = unsorted[$0]!
            let obj2 = unsorted[$1]!
            return obj1 > obj2
        }
    }
    
    func sortedWordData(unsorted: [[String]]) -> [[String]] {
        return unsorted.sorted() {
            let score1 = Int($0[2])!
            let score2 = Int($1[2])!
            return score1 > score2
        }
    }
    
    
    
}
