//
//  TileView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class TileView: Hashable {
    
    var tile: Tile
    
    // frames
    var depthFrame: CGRect
    var tileFrame: CGRect
    var scoreFrame: CGRect
    
    // views
    var view: UIView
    var depthView: UIView
    var tileView: UIView
    var glintLabel: UILabel
    var label: UILabel
    var image: UIImageView
    var scoreGlintLabel: UILabel
    var scoreLabel: UILabel
    
    // dragging
    var lifted: Bool
    var shouldShowText: Bool
    var shouldShowScore: Bool
    var shouldShowGlint: Bool
    var shouldShowImage: Bool
    
    // conform to hashable
    var uniqueID: Int
    var hashValue: Int {
        return uniqueID.hashValue
    }
    
    static func ==(lhs: TileView, rhs: TileView) -> Bool {
        return lhs.uniqueID == rhs.uniqueID
    }
    
    init(tile: Tile) {
        
        self.tile = tile
        
        uniqueID = game.tileServer()
        
        depthFrame = CGRect()
        tileFrame = CGRect()
        scoreFrame = CGRect()
        
        // views
        view = UIView(frame: device.screenBounds)
        
        depthView = UIView(frame: depthFrame)
        depthView.layer.cornerRadius = device.tileRadius
        depthView.backgroundColor = tileDepthColor(tile: tile)
        view.addSubview(depthView)
        
        tileView = UIView(frame: tileFrame)
        tileView.layer.cornerRadius = device.tileRadius
        tileView.backgroundColor = tileColor(tile: tile)
        view.addSubview(tileView)
        
        image = UIImageView(frame: tileFrame)
        image.layer.cornerRadius = device.tileRadius
        image.clipsToBounds = true
        if tile.type != "letter" {
            image.image = UIImage(named: tile.imageName())
            image.alpha = 0.5
            view.addSubview(image)
        } else if tile.text.count == 3 {
            let rainbowName = "rainbow" + String(randomElement(array: [1,2,3]))
            image.image = UIImage(named: rainbowName)
            image.alpha = 1.0
            view.addSubview(image)
        }
        
        glintLabel = UILabel(frame: tileFrame)
        glintLabel.font = tileFont
        glintLabel.textColor = tileGlintColor(tile: tile)
        glintLabel.textAlignment = .center
        glintLabel.adjustsFontSizeToFitWidth = true
        glintLabel.baselineAdjustment = .alignCenters
        glintLabel.text = tile.text
        view.addSubview(glintLabel)
        
        label = UILabel(frame: tileFrame)
        label.font = tileFont
        label.textColor = tileTextColor(tile: tile)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.text = tile.text
        view.addSubview(label)
        
        scoreGlintLabel = UILabel(frame: scoreFrame)
        scoreGlintLabel.font = tileScoreFont
        scoreGlintLabel.textColor = tileGlintColor(tile: tile)
        scoreGlintLabel.textAlignment = .center
        scoreGlintLabel.adjustsFontSizeToFitWidth = true
        scoreGlintLabel.baselineAdjustment = .alignCenters
        scoreGlintLabel.text = String(tile.score())
        view.addSubview(scoreGlintLabel)
        
        scoreLabel = UILabel(frame: scoreFrame)
        scoreLabel.font = tileScoreFont
        scoreLabel.textColor = tileTextColor(tile: tile)
        scoreLabel.textAlignment = .center
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.baselineAdjustment = .alignCenters
        scoreLabel.text = String(tile.score())
        view.addSubview(scoreLabel)
        
        lifted = false
        shouldShowText = tile.type == "letter"
        shouldShowScore = settings.showTileScores && tile.score() != 0
        shouldShowGlint = true
        shouldShowImage = tile.type != "letter" || tile.text.count == 3
        
        // tile position is not initialized
        // always use a convenience init
    }
    
    convenience init(tile: Tile, gridPosition: Int) {
        self.init(tile: tile)
        moveToGridPosition(position: gridPosition)
    }
    
    convenience init(tile: Tile, rackPosition: Int) {
        self.init(tile: tile)
        moveToRackPosition(position: rackPosition)
    }
    
    func updateFramesFromDepthFrame() {
        tileFrame = depthFrame.offsetBy(dx: -device.tileDepth, dy: -device.tileDepth)
        scoreFrame = device.scoreLabelFrame(tileFrame: tileFrame)
        
        depthView.frame = depthFrame
        tileView.frame = tileFrame
        glintLabel.frame = tileFrame.offsetBy(dx: device.tileGlintSize, dy: device.tileGlintSize)
        label.frame = tileFrame
        image.frame = tileFrame
        scoreGlintLabel.frame = scoreFrame.offsetBy(dx: device.tileScoreGlintSize, dy: device.tileScoreGlintSize)
        scoreLabel.frame = scoreFrame
    }
    
    func updateView() {
        updateFramesFromDepthFrame()
        updateContents()
    }
    
    func updateContents() {
        label.isHidden = !shouldShowText
        glintLabel.isHidden = !(shouldShowText && shouldShowGlint)
        scoreLabel.isHidden = !shouldShowScore
        scoreGlintLabel.isHidden = !(shouldShowScore && shouldShowGlint)
        image.isHidden = !shouldShowImage
    }
    
    func slideToGridPosition(position: Int, duration: Double) {
        depthFrame = device.gridSlotFrame(position: position)
        lifted = false
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.updateView()
        }, completion: nil)
    }
    
    func moveToGridPosition(position: Int) {
        depthFrame = device.gridSlotFrame(position: position)
        lifted = false
        self.updateView()
    }
    
    func slideToRackPosition(position: Int, duration: Double) {
        depthFrame = device.rackSlotFrame(position: position)
        lifted = false
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.updateView()
        }, completion: nil)
        
    }
    
    func moveToRackPosition(position: Int) {
        depthFrame = device.rackSlotFrame(position: position)
        tileFrame = self.depthFrame.offsetBy(dx: -device.tileDepth, dy: -device.tileDepth)
        lifted = false
        self.updateView()
    }
    
    func recenter(point: CGPoint) {
        let newX = point.x - device.tileSize/2
        let newY = point.y - device.tileSize/2
        
        self.depthFrame = CGRect(x: newX, y: newY, width: device.tileSize, height: device.tileSize)
        self.tileFrame = self.depthFrame.offsetBy(dx: -device.tileDepth, dy: -device.tileDepth)
        self.updateView()
    }
    
    func lift(point: CGPoint) {
        lifted = true
        recenter(point: point)
    }
    
    func fade() {
        view.alpha = fadedTileViewAlpha
    }
    
    func unfade() {
        view.alpha = 1.0
    }
    
    func updateAndShowText() {
        shouldShowText = true
        glintLabel.text = tile.text
        label.text = tile.text
        updateView()
    }
    
    func charm() {
        tile = wishLists[tile.text.count-1].charm(tile: tile)
        glintLabel.text = tile.text
        label.text = tile.text
        scoreGlintLabel.text = String(tile.score())
        scoreLabel.text = String(tile.score())
        shouldShowScore = true
        
        tile.waitingToBeCharmed = false
    }
    
    
    // animations
    
    func prepareToPop() {
        let anchorX = depthFrame.midX/view.frame.width
        let anchorY = depthFrame.midY/view.frame.height
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: view)
        view.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    }
    
    func pop() {
        UIView.animate(withDuration: popDuration, delay: 0, usingSpringWithDamping: popDamping, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.view.transform = .identity
        }, completion: nil)
    }
    
    func evaporate() {
        
        depthView.backgroundColor = UIColor.black
        tileView.backgroundColor = UIColor.white
        tileView.layer.borderWidth = CGFloat(3)
        tileView.layer.borderColor = UIColor.black.cgColor
        
        label.textColor = UIColor.black
        scoreLabel.textColor = UIColor.black
        
        shouldShowScore = tile.score() > 0
        shouldShowGlint = false
        shouldShowImage = false
        updateContents()
        
        UIView.animate(withDuration: evaporateDuration, animations: {
            self.view.alpha = 0.0
            self.view.frame = device.screenBounds.offsetBy(dx: 0, dy: -evaporateHeight)
        }, completion: { (finished: Bool) in
            self.view.removeFromSuperview()
        })
        
    }
    
    func wiggle() {
        if shouldShowText {
            return
        }
        
        let anchorX = depthFrame.midX/view.frame.width
        let anchorY = depthFrame.midY/view.frame.height
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: view)
        UIView.animate(withDuration: wiggleDuration/8.0, delay: 0, options: .curveLinear, animations: {
            self.view.transform = CGAffineTransform(rotationAngle: -wiggleAngle)
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: wiggleDuration/4.0, delay: 0, options: .curveLinear, animations: {
                self.view.transform = CGAffineTransform(rotationAngle: wiggleAngle)
            }, completion: { (finished: Bool) in
                UIView.animate(withDuration: wiggleDuration/4.0, delay: 0, options: .curveLinear, animations: {
                    self.view.transform = CGAffineTransform(rotationAngle: -wiggleAngle)
                }, completion: { (finished: Bool) in
                    UIView.animate(withDuration: wiggleDuration/4.0, delay: 0, options: .curveLinear, animations: {
                        self.view.transform = CGAffineTransform(rotationAngle: wiggleAngle)
                    }, completion: { (finished: Bool) in
                        UIView.animate(withDuration: wiggleDuration/8.0, delay: 0, options: .curveLinear, animations: {
                            self.view.transform = .identity
                        }, completion: nil)
                    })
                })
            })
        })
    }
    
    func wigglePartTwo() {
        
    }
    
    func expire() {
        let anchorX = depthFrame.midX/view.frame.width
        let anchorY = depthFrame.midY/view.frame.height
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: view)
        
        UIView.animate(withDuration: expireDuration, animations: {
            self.view.alpha = 0.0
            self.view.transform = CGAffineTransform(scaleX: expireScale, y: expireScale)
        }, completion: { (finished: Bool) in
            self.view.removeFromSuperview()
        })
    }
    
    
    
    
    
}
