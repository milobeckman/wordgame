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
    var statsLabels: [UILabel]
    var bestViews: [BestView]
    
    var wordDataView: UIScrollView
    var wordDataTopBar: UIView
    var wordDataBottomBar: UIView
    
    var view: UIView
    
    
    init(gridView: GridView, rackView: RackView) {
        
        statsStrings = []
        
        self.gridView = gridView
        self.rackView = rackView
        
        statsView = UIView(frame: device.statsFrame())
        gameOverLabel = UILabel(frame: device.gameOverFrame())
        statsLabels = []
        bestViews = []
        
        wordDataView = UIScrollView(frame: device.wordDataFrame())
        wordDataTopBar = UIView(frame: device.wordDataTopBarFrame())
        wordDataBottomBar = UIView(frame: device.wordDataBottomBarFrame())
        
        view = UIView(frame: device.screenBounds)
    }
    
    func gameOver() {
        view.addSubview(gridView.view)
        handleHighscores()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + waitBeforeShrinking, execute: {
            self.shrinkGridView()
            // after shrinking this also displays everything
        })
    }
    
    func handleHighscores() {
        if game.currentScore > storage.getInt(key: "bestScore") {
            storage.putInt(key: "bestScore", value: game.currentScore)
        }
        if game.currentLevel > storage.getInt(key: "bestLevel") {
            storage.putInt(key: "bestLevel", value: game.currentLevel)
        }
        if game.tilesDropped > storage.getInt(key: "bestTilesDropped") {
            storage.putInt(key: "bestTilesDropped", value: game.tilesDropped)
        }
        if game.wordsCleared > storage.getInt(key: "bestWordsCleared") {
            storage.putInt(key: "wordsCleared", value: game.wordsCleared)
        }
        if game.averageWordScore() > storage.getDouble(key: "bestAverageWordScore") {
            storage.putDouble(key: "bestAverageWordScore", value: game.averageWordScore())
        }
        if game.longestStreak > storage.getInt(key: "bestStreak") {
            storage.putInt(key: "bestStreak", value: game.longestStreak)
        }
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
            self.showWordData()
        })
    }
    
    func showStats() {
        
        gameOverLabel.font = gameOverFont
        gameOverLabel.textColor = statsNumberColor()
        gameOverLabel.textAlignment = .left
        gameOverLabel.adjustsFontSizeToFitWidth = true
        gameOverLabel.baselineAdjustment = .alignCenters
        gameOverLabel.text = "Game over"
        view.addSubview(gameOverLabel)
        
        setupStatsStrings()
        setupStatsLabels()
        view.addSubview(statsView)
        
        for label in statsLabels {
            view.addSubview(label)
        }
        
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
        
        var textStrings = ["Tiles dropped: ",
                           "Words cleared: ",
                           "Avg. word score: ",
                           "Longest streak: "]
        var numberStrings = [String(game.tilesDropped),
                             String(game.wordsCleared),
                             String(game.averageWordScore()),
                             String(game.longestStreak)]
        
        let textAttributes: [NSAttributedStringKey: Any] =
                                [.foregroundColor: statsTextColor(),
                                 .font: statsTextFont as Any]
        let numberAttributes: [NSAttributedStringKey: Any] =
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
            statsLabels.append(newLabel)
        }
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
