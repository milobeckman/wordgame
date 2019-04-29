//
//  Device.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class Device {
    
    // device
    var screenBounds: CGRect
    var screenWidth: CGFloat
    
    // generators
    let paddingAboveScore = CGFloat(20)
    let scoreHeight = CGFloat(60)
    let paddingAboveLevel = CGFloat(0)
    let levelHeight = CGFloat(14)
    
    let paddingAroundPauseBar = CGFloat(8)
    
    let paddingAboveGrid = CGFloat(10)
    let paddingToSideOfGrid = CGFloat(15)
    let paddingBetweenTiles = CGFloat(10)
    let tileRadius = CGFloat(10)
    let tileDepth = CGFloat(3)
    let tileGlintSize = CGFloat(1)
    let tileScoreGlintSize = CGFloat(1)
    
    let paddingAboveRack = CGFloat(80)
    
    let paddingAboveTimer = CGFloat(0)
    
    let menuButtonHeight = CGFloat(50)
    let menuButtonRadius = CGFloat(10)
    let paddingBetweenMenuButtons = CGFloat(10)
    let paddingToSideOfMenuButtons = CGFloat(60)
    
    let badgeRadius = CGFloat(20)
    let badgeShadowRadius = CGFloat(8)
    let badgeDX = CGFloat(-10)
    let badgeDY = CGFloat(2)
    
    let bestHeight = CGFloat(18)
    let bestWidth = CGFloat(38)
    let bestDepth = CGFloat(2)
    let bestRadius = CGFloat(4)
    
    let multiplierDepth = CGFloat(2)
    let multiplierShadowRadius = CGFloat(4)
    
    let paddingAroundStatsView = CGFloat(15)
    let paddingBetweenStats = CGFloat(5)
    let gameOverHeight = CGFloat(30)
    let statsHeight = CGFloat(20)
    let paddingAroundWordData = CGFloat(8)
    let wordDataWidthRatio = CGFloat(0.5)
    let wordDataMultiplierLocationRatio = CGFloat(0.7)
    let playAgainHeight = CGFloat(35)
    
    
    // calculated
    var scoreX: CGFloat
    var scoreY: CGFloat
    var levelX: CGFloat
    var levelY: CGFloat
    var pauseBarX: CGFloat
    var pauseBarY: CGFloat
    var gridX: CGFloat
    var gridY: CGFloat
    var rackX: CGFloat
    var rackY: CGFloat
    var tileSize: CGFloat
    var timerX: CGFloat
    var timerY: CGFloat
    var timerHeight: CGFloat
    var shrunkenGridSize: CGFloat
    var statsX: CGFloat
    var statsY: CGFloat
    var wordDataX: CGFloat
    var wordDataY: CGFloat
    
    

    
    
    init() {
        screenBounds = UIScreen.main.bounds
        screenWidth = screenBounds.width
        //screenHeight = screenBounds.height
        
        // calculate
        scoreX = 0
        scoreY = paddingAboveScore
        levelX = 0
        levelY = scoreY + scoreHeight + paddingAboveLevel
        pauseBarX = 0
        pauseBarY = levelY + levelHeight + paddingAroundPauseBar
        gridY = pauseBarY + paddingAroundPauseBar + tileDepth
        
        pauseBarX = paddingToSideOfGrid - tileDepth
        gridX = paddingToSideOfGrid
        tileSize = (screenWidth - paddingToSideOfGrid*2 - paddingBetweenTiles*3) / 4
        
        rackX = 0
        rackY = gridY + 4*tileSize + 3*paddingBetweenTiles + paddingAboveRack
        
        timerX = 0
        timerY = rackY + tileSize + 2*paddingBetweenTiles + paddingAboveTimer
        timerHeight = screenBounds.height - timerY
        
        shrunkenGridSize = gameOverGridScale*(4*tileSize + 3*paddingBetweenTiles)
        statsX = gridX + shrunkenGridSize + paddingAroundStatsView
        statsY = pauseBarY + paddingAroundStatsView
        
        wordDataX = (screenWidth*(1-wordDataWidthRatio))/2
        wordDataY = statsY + shrunkenGridSize + paddingAroundWordData
    }
    

    
    
    // ScoreView
    func scoreFrame() -> CGRect {
        return CGRect(x: 0, y: scoreY, width: screenWidth, height: scoreHeight)
    }
    
    func levelFrame() -> CGRect {
        return CGRect(x: 0, y: levelY, width: screenWidth, height: levelHeight)
    }
    
    
    // GridView
    func gridFrame() -> CGRect {
        return CGRect(x: 0, y: gridY, width: screenBounds.width, height: 4*tileSize + 3*paddingBetweenTiles)
    }
    
    func gridSlotFrame(x: Int, y: Int) -> CGRect {
        let xMin = gridX + CGFloat(x) * (tileSize + paddingBetweenTiles)
        let yMin = gridY + CGFloat(y) * (tileSize + paddingBetweenTiles)
        return CGRect(x: xMin, y: yMin, width: tileSize, height: tileSize)
    }
    
    func gridSlotFrame(position: Int) -> CGRect {
        let x = position % 4
        let y = (position - x) / 4
        return gridSlotFrame(x: x, y: y)
    }
    
    
    // RackView
    func rackFrame() -> CGRect {
        return CGRect(x: 0, y: rackY, width: screenBounds.width, height: tileSize + 2*paddingBetweenTiles)
    }
    
    func rackSlotFrame(position: Int) -> CGRect {
        let x = paddingToSideOfGrid + CGFloat(position) * (tileSize + paddingBetweenTiles)
        return CGRect(x: x, y: rackY + paddingBetweenTiles, width: tileSize, height: tileSize)
    }
    
    
    // TileView
    func scoreLabelFrame(tileFrame: CGRect) -> CGRect {
        let x = tileFrame.minX + 0.68*tileSize
        let y = tileFrame.minY
        let size = 0.32*tileSize
        return CGRect(x: x, y: y, width: size, height: size)
    }
    
    
    // TimerView
    func timerFrame() -> CGRect {
        return CGRect(x: 0, y: timerY, width: screenBounds.width, height: timerHeight)
    }
    
    func timerBarFrame(fraction: Double) -> CGRect {
        return CGRect(x: 0, y: timerY, width: CGFloat(fraction)*screenBounds.width, height: timerHeight)
    }
    
    func timerShadowFrame() -> CGRect {
        return CGRect(x: 0, y: timerY, width: screenWidth, height: timerShadowSize)
    }
    
    
    // PauseButton
    func pauseButtonFrame() -> CGRect {
        let size = pauseBarY - paddingAroundPauseBar - scoreY
        let x = screenWidth - paddingAboveScore - size
        return CGRect(x: x, y: scoreY, width: size, height: size)
    }
    
    func pauseBarFrame() -> CGRect {
        return CGRect(x: pauseBarX, y: pauseBarY, width: screenWidth - 2.0*pauseBarX, height: 1)
    }
    
    func pauseBarFramePaused() -> CGRect {
        return CGRect(x: pauseBarX, y: timerY-1, width: screenWidth - 2.0*pauseBarX, height: 1)
    }
    
    func pauseCurtainFramePaused() -> CGRect {
        return CGRect(x: pauseBarX, y: pauseBarY, width: screenWidth - 2.0*pauseBarX, height: timerY-1-pauseBarY)
    }
    
    func menuButtonFrame(i: Int) -> CGRect {
        let totalMenuButtons = CGFloat(1)
        
        let curtainHeight = pauseCurtainFramePaused().height
        let curtainY = pauseCurtainFramePaused().minY
        let menuHeight = totalMenuButtons*menuButtonHeight + (totalMenuButtons-1)*paddingBetweenMenuButtons
        
        let x = paddingToSideOfMenuButtons
        let y = curtainY + 0.5*(curtainHeight - menuHeight) + CGFloat(i)*(menuButtonHeight + paddingBetweenMenuButtons)
        let width = screenWidth - 2*paddingToSideOfMenuButtons
        
        return CGRect(x: x, y: y, width: width, height: menuButtonHeight)
    }
    
    
    // BadgeView
    func badgeFrame(gridPosition: Int) -> CGRect {
        let centerX = gridSlotFrame(position: gridPosition).maxX + badgeDX
        let centerY = gridSlotFrame(position: gridPosition).minY - badgeDY
        return CGRect(x: centerX - badgeRadius, y: centerY - badgeRadius, width: 2*badgeRadius, height: 2*badgeRadius)
    }
    
    
    // GameOverView
    func statsFrame() -> CGRect {
        let width = screenWidth - statsX - paddingAroundStatsView
        let height = paddingAboveGrid + shrunkenGridSize - paddingAroundStatsView
    
        return CGRect(x: statsX, y: statsY, width: width, height: height)
    }
    
    func gameOverFrame() -> CGRect {
        return CGRect(x: statsX, y: statsY, width: statsFrame().width, height: gameOverHeight)
    }
    
    func statsLabelFrame(i: Int) -> CGRect {
        let y = statsY + gameOverHeight + paddingBetweenStats + CGFloat(i)*(statsHeight + paddingBetweenStats)
        let width = screenWidth - statsX - paddingAroundStatsView
        return CGRect(x: statsX, y: y, width: width, height: statsHeight)
    }
    
    func wordDataFrame() -> CGRect {
        let width = screenWidth * wordDataWidthRatio
        let height = timerY - wordDataY - playAgainHeight - 2*paddingAroundWordData
        return CGRect(x: wordDataX, y: wordDataY, width: width, height: height)
    }
    
    func wordDataTopBarFrame() -> CGRect {
        return CGRect(x: wordDataX, y: wordDataY, width: screenWidth*wordDataWidthRatio, height: 1)
    }
    
    func wordDataBottomBarFrame() -> CGRect {
        let y = timerY - playAgainHeight - 2*paddingAroundWordData
        return CGRect(x: wordDataX, y: y, width: screenWidth*wordDataWidthRatio, height: 1)
    }
    
    
    

    
    // efficiency could be improved
    func rackPositionForPoint(point: CGPoint) -> Int {
        for i in 0...3 {
            if rackSlotFrame(position: i).contains(point) {
                return i
            }
        }
        
        return -1
    }
    
    // efficiency could be improved
    func gridPositionForPoint(point: CGPoint) -> Int {
        for i in 0...15 {
            if gridSlotFrame(position: i).contains(point) {
                return i
            }
        }
        
        return -1
    }
    
    // efficiency could be improved
    func gridPositionForFrame(frame: CGRect) -> Int {
        for i in 0...15 {
            if gridSlotFrame(position: i) == frame {
                return i
            }
        }
        
        return -1
    }
    
    func rackPositionForFrame(frame: CGRect) -> Int {
        for i in 0...15 {
            if rackSlotFrame(position: i) == frame {
                return i
            }
        }
        
        return -1
    }
    
    func tileViewWithGridPosition(tileViews: Set<TileView>, position: Int) -> TileView {
        for tileView in tileViews {
            if gridPositionForFrame(frame: tileView.depthFrame) == position {
                return tileView
            }
        }
        
        print("error finding tileViewWithGridPosition")
        return TileView(tile: Tile())
    }
    
    func tileViewWithRackPosition(tileViews: Set<TileView>, position: Int) -> TileView {
        for tileView in tileViews {
            if rackPositionForFrame(frame: tileView.depthFrame) == position {
                return tileView
            }
        }
        
        print("error finding tileViewWithRackPosition")
        return TileView(tile: Tile())
    }
}
