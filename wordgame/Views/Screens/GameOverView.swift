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
    var tileIDs: [String]
    
    var gridView: GridView
    var rackView: RackView
    
    var statsView: UIView
    var statsLabels: [UILabel]
    var tinyTileViews: [TileView]
    
    let tinyTileMode = false
    
    var view: UIView
    
    
    init(gridView: GridView, rackView: RackView) {
        
        statsStrings = []
        tileIDs = []
        
        self.gridView = gridView
        self.rackView = rackView
        
        statsView = UIView(frame: device.statsFrame())
        statsLabels = []
        tinyTileViews = []
        
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
        if tinyTileMode {
            setupTinyTileViews()
        }
        
        view.addSubview(statsView)
        
        for label in statsLabels {
            view.addSubview(label)
        }
        
        if tinyTileMode {
            for tinyTileView in tinyTileViews {
                view.addSubview(tinyTileView.view)
            }
        }
        
    }
    
    
    func setupStatsStrings() {
        
        statsStrings = []
        tileIDs = sortedTileIDs(unsorted: game.tileCounts)
        
        var textStrings = ["Tiles dropped: "]
        var numberStrings = [String(game.tilesDropped)]
        
        if tinyTileMode {
            for tileID in tileIDs {
                textStrings.append("")
                numberStrings.append(String(game.tileCounts[tileID]!))
            }
        }
        
        textStrings += ["Words cleared: ",
                        "Avg. word score: ",
                        "Longest streak: "]
        numberStrings += [String(game.wordsCleared),
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
            if tinyTileMode {
                if (1...tileIDs.count).contains(i) {
                    newLabel.frame = device.indentedStatsLabelFrame(i: i)
                }
            }
            
            newLabel.attributedText = statsStrings[i]
            statsLabels.append(newLabel)
        }
    }
    
    func setupTinyTileViews() {
        
        for i in 1...tileIDs.count {
            let tile = sampleTile(tileID: tileIDs[i-1])
            let tinyTileView = TileView(tile: tile)
            tinyTileView.moveToTinyPosition(position: i)
            tinyTileViews.append(tinyTileView)
        }
    }
    
    func sortedTileIDs(unsorted: [String: Int]) -> [String] {
        return Array(unsorted.keys).sorted() {
            let obj1 = unsorted[$0]!
            let obj2 = unsorted[$1]!
            return obj1 > obj2
        }
    }
    
    
    
}
