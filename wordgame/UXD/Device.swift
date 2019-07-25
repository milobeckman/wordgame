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
    var screenHeight: CGFloat
    
    // generators
    var statusBarHeight = CGFloat(20)
    var paddingAboveScore = CGFloat(0)
    var scoreHeight = CGFloat(60)
    var paddingAboveLevel = CGFloat(0)
    var levelHeight = CGFloat(18)
    
    var paddingAroundPauseBar = CGFloat(8)
    
    var paddingAboveGrid = CGFloat(10)
    var paddingToSideOfGrid = CGFloat(15)
    var paddingBetweenTiles = CGFloat(10)
    var tileRadius = CGFloat(10)
    var tileDepth = CGFloat(3)
    var tileGlintSize = CGFloat(1)
    var tileScoreGlintSize = CGFloat(1)
    
    var paddingAboveTimer = CGFloat(0)
    var timerHeight = CGFloat(50)
    
    var menuButtonHeight = CGFloat(50)
    var menuButtonRadius = CGFloat(10)
    var menuButtonBorderWidth = CGFloat(4)
    var paddingBetweenMenuButtons = CGFloat(10)
    var paddingToSideOfMenuButtons = CGFloat(60)
    var highScoreLabelHeight = CGFloat(22)
    
    var badgeRadius = CGFloat(20)
    var badgeShadowRadius = CGFloat(8)
    var badgeDX = CGFloat(-10)
    var badgeDY = CGFloat(2)
    
    var bestHeight = CGFloat(18)
    var bestWidth = CGFloat(38)
    var bestDepth = CGFloat(2)
    var bestRadius = CGFloat(4)
    
    var multiplierDepth = CGFloat(2)
    var multiplierShadowRadius = CGFloat(4)
    
    var spaceViewHeightRatio = CGFloat(8.0)
    var offsetPerLevelRaw = CGFloat(172.3)
    
    var gameOverGridScale = CGFloat(0.45)
    var paddingAroundStatsView = CGFloat(15)
    var paddingBetweenStats = CGFloat(5)
    var gameOverHeight = CGFloat(30)
    var statsHeight = CGFloat(22)
    var paddingAroundWordData = CGFloat(8)
    var wordDataWidthRatio = CGFloat(0.6)
    var wordDataMultiplierLocationRatio = CGFloat(0.7)
    var multiplierShadowDepth = CGFloat(1)
    var playAgainHeight = CGFloat(70)
    var playAgainWidthRatio = CGFloat(3.0)
    
    var fontScale = CGFloat(1.0)
    
    
    // calculated
    var scoreX = CGFloat(0)
    var scoreY = CGFloat(0)
    var levelX = CGFloat(0)
    var levelY = CGFloat(0)
    var pauseBarX = CGFloat(0)
    var pauseBarY = CGFloat(0)
    var gridX = CGFloat(0)
    var gridY = CGFloat(0)
    var rackX = CGFloat(0)
    var rackY = CGFloat(0)
    var tileSize = CGFloat(0)
    var timerX = CGFloat(0)
    var timerY = CGFloat(0)
    var shrunkenGridSize = CGFloat(0)
    var statsX = CGFloat(0)
    var statsY = CGFloat(0)
    var wordDataX = CGFloat(0)
    var wordDataY = CGFloat(0)
    
    

    
    
    init() {
        screenBounds = UIScreen.main.bounds
        screenWidth = screenBounds.width
        screenHeight = screenBounds.height
        
        // calculate
        setGeneratorsFromDeviceSize()
        calculateAllValues()
    }
    
    func setGeneratorsFromDeviceSize() {
        
        switch UIScreen.main.nativeBounds.height {
            
        // iPhone SE
        case 1136:
            adjustGenerators(contentAdj: 0.85, paddingAdj: 0.75)
            gameOverGridScale = CGFloat(0.45)
            
        // iPhone 6,6s,7,8 Plus
        case 2208:
            print("hey")
            adjustGenerators(contentAdj: 1.00, paddingAdj: 1.8)

        default:
            adjustGenerators(contentAdj: 0.95, paddingAdj: 0.8)
            
        }
        
        
    }
    
    func adjustGenerators(contentAdj: CGFloat, paddingAdj: CGFloat) {
        
        paddingAboveScore *= paddingAdj
        paddingAboveLevel *= paddingAdj
        paddingAroundPauseBar *= paddingAdj
        paddingAboveGrid *= paddingAdj
        paddingToSideOfGrid *= paddingAdj
        paddingBetweenTiles *= paddingAdj
        tileRadius *= paddingAdj
        tileDepth *= paddingAdj
        paddingAboveTimer *= paddingAdj
        menuButtonBorderWidth *= paddingAdj
        menuButtonRadius *= paddingAdj
        paddingBetweenMenuButtons *= paddingAdj
        paddingToSideOfMenuButtons *= paddingAdj
        bestDepth *= paddingAdj
        bestRadius *= paddingAdj
        multiplierDepth *= paddingAdj
        paddingAroundStatsView *= paddingAdj
        paddingBetweenStats *= paddingAdj
        paddingAroundWordData *= paddingAdj

        scoreHeight *= contentAdj
        levelHeight *= contentAdj
        menuButtonHeight *= contentAdj
        badgeRadius *= contentAdj
        badgeShadowRadius *= contentAdj
        badgeDX *= contentAdj
        badgeDY *= contentAdj
        bestHeight *= contentAdj
        bestWidth *= contentAdj
        multiplierShadowRadius *= contentAdj
        gameOverHeight *= contentAdj
        statsHeight *= contentAdj
        playAgainHeight *= contentAdj
        fontScale *= contentAdj
 
    }
    
    func calculateAllValues() {
        scoreX = 0
        scoreY = statusBarHeight + paddingAboveScore
        levelX = 0
        levelY = scoreY + scoreHeight + paddingAboveLevel
        pauseBarX = 0
        pauseBarY = levelY + levelHeight + paddingAroundPauseBar
        gridY = pauseBarY + paddingAroundPauseBar + tileDepth
        
        pauseBarX = paddingToSideOfGrid - tileDepth
        gridX = paddingToSideOfGrid
        tileSize = (screenWidth - paddingToSideOfGrid*2 - paddingBetweenTiles*3) / 4
        
        rackX = 0
        rackY = screenBounds.height - timerHeight - tileSize - 2*paddingBetweenTiles - paddingAboveTimer
        
        timerX = 0
        timerY = screenBounds.height - timerHeight
        
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
    
    func timerFrameHidden() -> CGRect {
        return CGRect(x: 0, y: screenBounds.height, width: screenBounds.width, height: timerHeight)
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
    
    func pauseCurtainBottom() -> CGFloat {
        return game.currentLevel >= rules.timerActivationLevel ? timerY-1 : screenBounds.height-1
    }
    
    func pauseBarFrame() -> CGRect {
        return CGRect(x: pauseBarX, y: pauseBarY, width: screenWidth - 2.0*pauseBarX, height: 1)
    }
    
    func pauseBarFramePaused() -> CGRect {
        return CGRect(x: pauseBarX, y: pauseCurtainBottom(), width: screenWidth - 2.0*pauseBarX, height: 1)
    }
    
    func pauseCurtainFramePaused() -> CGRect {
        return CGRect(x: pauseBarX, y: pauseBarY, width: screenWidth - 2.0*pauseBarX, height: pauseCurtainBottom()-pauseBarY)
    }
    
    func contentMask() -> CGRect {
        return CGRect(x: 0, y: pauseBarY, width: screenWidth, height: pauseCurtainBottom()-pauseBarY)
    }
    
    func contentMaskPaused() -> CGRect {
        return CGRect(x: 0, y: pauseCurtainBottom(), width: screenWidth, height: 1)
    }
    
    func menuButtonFrame(numMenuButtons: Int, i: Int) -> CGRect {
        
        let curtainHeight = pauseCurtainFramePaused().height
        let curtainY = pauseCurtainFramePaused().minY
        let menuHeight = CGFloat(numMenuButtons)*menuButtonHeight + CGFloat(numMenuButtons-1)*paddingBetweenMenuButtons
        
        let x = paddingToSideOfMenuButtons
        let y = curtainY + 0.5*(curtainHeight - menuHeight) + CGFloat(i)*(menuButtonHeight + paddingBetweenMenuButtons)
        let width = screenWidth - 2*paddingToSideOfMenuButtons
        
        return CGRect(x: x, y: y, width: width, height: menuButtonHeight)
    }
    
    func highScoreLabelFrame(numMenuButtons: Int) -> CGRect {
        let topButtonFrame = menuButtonFrame(numMenuButtons: numMenuButtons, i: 0)
        let y = topButtonFrame.minY - paddingBetweenMenuButtons - highScoreLabelHeight
        return CGRect(x: 0, y: y, width: screenWidth, height: highScoreLabelHeight)
    }
    
    
    // BadgeView
    func badgeFrame(gridPosition: Int) -> CGRect {
        let centerX = gridSlotFrame(position: gridPosition).maxX + badgeDX
        let centerY = gridSlotFrame(position: gridPosition).minY - badgeDY
        return CGRect(x: centerX - badgeRadius, y: centerY - badgeRadius, width: 2*badgeRadius, height: 2*badgeRadius)
    }
    
    
    func spaceViewFrame(level: Double) -> CGRect {
        let height = screenWidth*spaceViewHeightRatio
        let y = CGFloat(level)*(offsetPerLevelRaw*screenWidth/1000.0)-height
        return CGRect(x: 0, y: y, width: screenWidth, height: height)
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
    
    func playAgainButtonFrame() -> CGRect {
        let width = playAgainHeight*playAgainWidthRatio
        let x = (screenWidth - width)/2
        let y = timerY - playAgainHeight - paddingAroundWordData
        return CGRect(x: x, y: y, width: width, height: playAgainHeight)
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
