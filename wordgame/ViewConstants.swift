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
    var tileRadius = CGFloat(10)
    var tileDepth = CGFloat(3)
    var tileGlintSize = CGFloat(2)
    
    // calculated
    var gridX = CGFloat(0)
    var gridY = CGFloat(100) // temp: hard-coded
    var rackX = CGFloat(0)
    var rackY = CGFloat(0)
    var tileSize = CGFloat(0)
    
    // colors
    var backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1)
    
    var tileColor = UIColor(red: 0.9, green: 0.84, blue: 0.7, alpha: 1)
    var tileDepthColor = UIColor(red: 0.7, green: 0.64, blue: 0.5, alpha: 1)
    var tileTextColor = UIColor(red: 0.3, green: 0.24, blue: 0.1, alpha: 1)
    var tileGlintColor = UIColor(red: 0.95, green: 0.89, blue: 0.78, alpha: 1)
    
    var gridSlotColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    var gridSlotColorHighlight = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
    
    var rackColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    var rackSlotColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
    var rackSlotWidth = CGFloat(4)
    
    // fonts
    var tileTextSize = CGFloat(40)
    var tileFont = UIFont(name: "BanglaSangamMN-Bold", size: 40)
    var rackSlotTextSize = CGFloat(60)
    var rackSlotFont = UIFont(name: "BanglaSangamMN-Bold", size: 80)
    
    // animations
    var dragDuration = 0.2
    var evaporateDuration = 0.5
    var evaporateHeight = CGFloat(6.0)
    
    
    init() {
        screenBounds = UIScreen.main.bounds
        screenWidth = screenBounds.width
        
        calculateValues()
    }
    
    func calculateValues() {
        
        tileSize = (screenWidth - paddingToSideOfGrid*2 - paddingBetweenTiles*3) / 4
        
        gridX = paddingToSideOfGrid
        
        rackY = gridY + 4*tileSize + 3*paddingBetweenTiles + paddingAboveRack
        
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
