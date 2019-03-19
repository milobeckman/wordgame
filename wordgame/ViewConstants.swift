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
    var paddingToSideOfGrid = CGFloat(15)
    var paddingBetweenTiles = CGFloat(10)
    var paddingAboveRack = CGFloat(80)
    var paddingAboveTimer = CGFloat(0)
    var timerHeight = CGFloat(15) // temp: hard-coded
    var tileRadius = CGFloat(10)
    var tileDepth = CGFloat(3)
    var tileGlintSize = CGFloat(2)
    
    // calculated
    var gridX = CGFloat(0)
    var gridY = CGFloat(100) // temp: hard-coded
    var rackX = CGFloat(0)
    var rackY = CGFloat(0)
    var tileSize = CGFloat(0)
    var timerX = CGFloat(0)
    var timerY = CGFloat(0)
    
    // colors
    var backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1)
    
    var tileColor = UIColor(red: 0.9, green: 0.84, blue: 0.7, alpha: 1)
    var tileDepthColor = UIColor(red: 0.7, green: 0.64, blue: 0.5, alpha: 1)
    var tileTextColor = UIColor(red: 0.3, green: 0.24, blue: 0.1, alpha: 1)
    var tileGlintColor = UIColor(red: 0.95, green: 0.89, blue: 0.78, alpha: 1)
    
    var gridSlotColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    var gridSlotColorHighlight = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
    
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
    var tileTextSize = CGFloat(40)
    var tileFont = UIFont(name: "BanglaSangamMN-Bold", size: 40)
    var rackSlotTextSize = CGFloat(60)
    var rackSlotFont = UIFont(name: "BanglaSangamMN-Bold", size: 80)
    
    // animations
    var slideDuration = 0.2
    var dropDuration = 0.1
    var popDuration = 0.5
    var popDamping = CGFloat(0.6)
    var evaporateDuration = 0.5
    var evaporateHeight = CGFloat(6.0)
    
    // other times
    var tickInterval = 0.02
    
    
    init() {
        screenBounds = UIScreen.main.bounds
        screenWidth = screenBounds.width
        
        calculateValues()
    }
    
    func calculateValues() {
        
        tileSize = (screenWidth - paddingToSideOfGrid*2 - paddingBetweenTiles*3) / 4
        
        gridX = paddingToSideOfGrid
        
        rackY = gridY + 4*tileSize + 3*paddingBetweenTiles + paddingAboveRack
        
        timerY = rackY + tileSize + 2*paddingBetweenTiles + paddingAboveTimer
        timerHeight = screenBounds.height - timerY
        
        tileFont = UIFont(name: "BanglaSangamMN-Bold", size: tileTextSize)
        rackSlotFont = UIFont(name: "BanglaSangamMN-Bold", size: rackSlotTextSize)
        
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
    
    func rackFrame() -> CGRect {
        return CGRect(x: 0, y: rackY, width: screenBounds.width, height: tileSize + 2*paddingBetweenTiles)
    }
    
    func gridFrame() -> CGRect {
        return CGRect(x: 0, y: gridY, width: screenBounds.width, height: 4*tileSize + 3*paddingBetweenTiles)
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
}
