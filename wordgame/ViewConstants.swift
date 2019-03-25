//
//  ViewConstants.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class ViewConstants {
    
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
    
    // colors
    var backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1)
    
    var scoreTextColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    var levelTextColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)
    
    var pauseBarColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1)
    
    var tileColor = UIColor(red: 0.9, green: 0.84, blue: 0.7, alpha: 1)
    var tileDepthColor = UIColor(red: 0.7, green: 0.64, blue: 0.5, alpha: 1)
    var tileTextColor = UIColor(red: 0.3, green: 0.24, blue: 0.1, alpha: 1)
    var tileGlintColor = UIColor(red: 0.95, green: 0.89, blue: 0.78, alpha: 1)
    var fadedTileViewAlpha = CGFloat(0.3)
    
    var wildColor = UIColor(red: 0.9843, green: 0.8078, blue: 0.2471, alpha: 1.0)
    var wildDepthColor = UIColor(red: 0.749, green: 0.6078, blue: 0.1882, alpha: 1.0)
    
    var trashColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
    var trashDepthColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
    
    var lifeColor = UIColor(red: 0.9451, green: 0.5686, blue: 0.6706, alpha: 1.0)
    var lifeDepthColor = UIColor(red: 0.749, green: 0.3373, blue: 0.4039, alpha: 1.0)
    
    var gridSlotColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    var gridSlotColorHighlight = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
    var gridSlotColorRebirth = UIColor(red: 0.8471, green: 0.7451, blue: 0.7686, alpha: 1.0)
    var gridSlotAlpha = CGFloat(1.0)
    
    var rackColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1)
    var rackSlotColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    var rackSlotWidth = CGFloat(4)
    
    var timerBackgroundColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
    var timerBarStartRGB = [0.0,1.0,0.0]
    var timerBarMidRGB = [1.0,1.0,0.0]
    var timerBarEndRGB = [1.0,0.0,0.0]
    var timerBarMidpoint = 0.3
    var timerShadowSize = CGFloat(7)
    let timerShadowStartColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    let timerShadowEndColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
    
    // fonts
    var scoreTextSize = CGFloat(60)
    var scoreFont = UIFont(name: "BanglaSangamMN-Bold", size: 40)
    var levelTextSize = CGFloat(13)
    var levelFont = UIFont(name: "BanglaSangamMN", size: 40)
    var tileTextSize = CGFloat(40)
    var tileFont = UIFont(name: "BanglaSangamMN-Bold", size: 40)
    var tileScoreTextSize = CGFloat(18)
    var tileScoreFont = UIFont(name: "BanglaSangamMN-Bold", size: 40)
    
    // animations
    var slideDuration = 0.2
    var dropDuration = 0.1
    
    var popDuration = 0.5
    var popDelay = 0.15
    var popDamping = CGFloat(0.6)
    
    var evaporateDuration = 2.0
    var evaporateHeight = CGFloat(6.0)
    
    var dieDuration = 1.0
    var dieAngle = CGFloat(1.0 * .pi)
    var reviveDuration = 0.5
    
    var pauseDuration = 0.8
    
    // other times
    var tickInterval = 0.02
    var scoreTickInterval = 0.02
    
    
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
        
        scoreFont = UIFont(name: "BanglaSangamMN-Bold", size: scoreTextSize)
        levelFont = UIFont(name: "BanglaSangamMN-Bold", size: levelTextSize)
        tileFont = UIFont(name: "BanglaSangamMN-Bold", size: tileTextSize)
        tileScoreFont = UIFont(name: "BanglaSangamMN-Bold", size: tileScoreTextSize)
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
    
    func timerBarColor(fraction: Double) -> UIColor {
        if fraction > timerBarMidpoint {
            let p = (1.0 - fraction) / (1.0 - timerBarMidpoint)
            return interpolateColor(start: timerBarStartRGB, end: timerBarMidRGB, fraction: p)
        } else {
            let p = (timerBarMidpoint - fraction) / (timerBarMidpoint)
            return interpolateColor(start: timerBarMidRGB, end: timerBarEndRGB, fraction: p)
        }
    }
    
    func interpolateColor(start: [Double], end: [Double], fraction: Double) -> UIColor {
        let r = CGFloat(start[0]*(1-fraction) + end[0]*fraction)
        let g = CGFloat(start[1]*(1-fraction) + end[1]*fraction)
        let b = CGFloat(start[2]*(1-fraction) + end[2]*fraction)
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    func tileDepthColor(type: String) -> UIColor {
        switch type {
        case "wild":
            return wildDepthColor
        case "trash":
            return trashDepthColor
        case "life":
            return lifeDepthColor
        default:
            return tileDepthColor
        }
    }
    
    func tileColor(type: String) -> UIColor {
        switch type {
        case "wild":
            return wildColor
        case "trash":
            return trashColor
        case "life":
            return lifeColor
        default:
            return tileColor
        }
    }
    
    func tileGlintColor(type: String) -> UIColor {
        switch type {
        default:
            return tileGlintColor
        }
    }
    
    func tileTextColor(type: String) -> UIColor {
        switch type {
        default:
            return tileTextColor
        }
    }
    
    
    
    
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
    
    func tileViewWithGridPosition(tileViews: Set<TileView>, position: Int) -> TileView {
        for tileView in tileViews {
            if gridPositionForFrame(frame: tileView.depthFrame) == position {
                return tileView
            }
        }
        
        print("error finding tileView")
        return TileView(tile: Tile())
    }
}
