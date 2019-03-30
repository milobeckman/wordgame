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
    var paddingAboveScore = CGFloat(20)
    var scoreHeight = CGFloat(60)
    var paddingAboveLevel = CGFloat(0)
    var levelHeight = CGFloat(14)
    var paddingAroundPauseBar = CGFloat(8)
    var paddingAboveGrid = CGFloat(10)
    var paddingToSideOfGrid = CGFloat(15)
    var paddingBetweenTiles = CGFloat(10)
    var paddingAboveRack = CGFloat(80)
    var paddingAboveTimer = CGFloat(0)
    var timerHeight = CGFloat(15) // temp: hard-coded
    var tileRadius = CGFloat(10)
    var tileDepth = CGFloat(3)
    var tileGlintSize = CGFloat(2)
    
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
    
    
    // fonts

    
    
    init() {
        screenBounds = UIScreen.main.bounds
        screenWidth = screenBounds.width
        
        calculateValues()
    }
    
    func calculateValues() {
        
        scoreY = paddingAboveScore
        levelY = scoreY + scoreHeight + paddingAboveLevel
        pauseBarY = levelY + levelHeight + paddingAroundPauseBar
        gridY = pauseBarY + paddingAroundPauseBar + tileDepth
        
        pauseBarX = paddingToSideOfGrid - tileDepth
        gridX = paddingToSideOfGrid
        tileSize = (screenWidth - paddingToSideOfGrid*2 - paddingBetweenTiles*3) / 4
        
        rackY = gridY + 4*tileSize + 3*paddingBetweenTiles + paddingAboveRack
        
        timerY = rackY + tileSize + 2*paddingBetweenTiles + paddingAboveTimer
        timerHeight = screenBounds.height - timerY
        

    }
    
    
    
    /* FRAMES */
    
    func scoreFrame() -> CGRect {
        return CGRect(x: 0, y: scoreY, width: screenWidth, height: scoreHeight)
    }
    
    func levelFrame() -> CGRect {
        return CGRect(x: 0, y: levelY, width: screenWidth, height: levelHeight)
    }
    
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
    
    func rackSlotFrame(position: Int) -> CGRect {
        let x = paddingToSideOfGrid + CGFloat(position) * (tileSize + paddingBetweenTiles)
        return CGRect(x: x, y: rackY + paddingBetweenTiles, width: tileSize, height: tileSize)
    }
    
    func scoreLabelFrame(tileFrame: CGRect) -> CGRect {
        let x = tileFrame.minX + 0.68*tileSize
        let y = tileFrame.minY
        let size = 0.32*tileSize
        return CGRect(x: x, y: y, width: size, height: size)
    }
    
    func gridFrame() -> CGRect {
        return CGRect(x: 0, y: gridY, width: screenBounds.width, height: 4*tileSize + 3*paddingBetweenTiles)
    }
    
    func rackFrame() -> CGRect {
        return CGRect(x: 0, y: rackY, width: screenBounds.width, height: tileSize + 2*paddingBetweenTiles)
    }
    
    func timerFrame() -> CGRect {
        return CGRect(x: 0, y: timerY, width: screenBounds.width, height: timerHeight)
    }
    
    func timerBarFrame(fraction: Double) -> CGRect {
        return CGRect(x: 0, y: timerY, width: CGFloat(fraction)*screenBounds.width, height: timerHeight)
    }
    
    func timerShadowFrame() -> CGRect {
        return CGRect(x: 0, y: timerY, width: screenWidth, height: timerShadowSize)
    }
    
    
    
    
    /* COLORS */
    
    
    
    
    /* FINDING STUFF */
    
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
        
        print("error finding tileView - grid")
        return TileView(tile: Tile())
    }
    
    func tileViewWithRackPosition(tileViews: Set<TileView>, position: Int) -> TileView {
        for tileView in tileViews {
            if rackPositionForFrame(frame: tileView.depthFrame) == position {
                return tileView
            }
        }
        
        print("error finding tileView - rack")
        return TileView(tile: Tile())
    }
}
