//
//  GameView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/12/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class GameView {
    
    var game: Game
    
    var night: Bool
    
    var scoreView: ScoreView
    var gridView: GridView
    var rackView: RackView
    var timerView: TimerView
    var pauseView: PauseView
    
    var gameOverView: GameOverView
    
    var view: UIView
    
    var gridMask: CAShapeLayer
    var rackMask: CAShapeLayer
    
    init(game: Game) {
        
        self.game = game
        
        night = false
        
        scoreView = ScoreView(game: game)
        gridView = GridView(grid: game.grid)
        rackView = RackView(rack: game.rack)
        timerView = TimerView()
        pauseView = PauseView()
        gameOverView = GameOverView(gridView: gridView, rackView: rackView)
        
        view = UIView(frame: device.screenBounds)
        view.addSubview(backgroundView.view)
        view.addSubview(scoreView.view)
        view.addSubview(gridView.view)
        view.addSubview(timerView.view)
        view.addSubview(rackView.view)
        view.addSubview(pauseView.view)
        
        gridMask = CAShapeLayer()
        rackMask = CAShapeLayer()
        setupMasks()
        
        newGame()
    }
    
    func newGame() {
        for i in 0...3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)*popDelay, execute: {
                self.rackView.serveNewTile(position: i)
            })
        }
        
        game.over = false
        view.isUserInteractionEnabled = false
    }
    
    func refillRack() {
        for i in 0...3 {
            if rackView.rack.tiles[i].type == "null" {
                serveNewTile(rackPosition: i)
            }
        }
    }
    
    func serveNewTile(rackPosition: Int) {
        timerView.resetTimer()
        rackView.serveNewTile(position: rackPosition)
        backgroundView.update()
        if !night && nightMode(level: game.currentLevel) {
            switchToNightMode()
        }
    }
    
    func showScoreBadge(score: Int, wordPath: [Int], wordPaths: [[Int]]) {
        let badgePosition = positionForBadge(wordPath: wordPath, wordPaths: wordPaths)
        let badgeView = BadgeView(score: score, gridPosition: badgePosition)
        view.addSubview(badgeView.view)
        badgeView.display()
    }
    
    func showMultiplierView(multiplier: Int) {
        let multiplierView = MultiplierView(multiplier: multiplier)
        gridView.view.addSubview(multiplierView.view)
        multiplierView.display()
    }
    
    func switchToNightMode() {
        scoreView.updateView()
        pauseView.switchToNightMode()
        for gridSlotView in gridView.gridSlotViews {
            gridSlotView.update()
        }
    }
    
    func timesUp() {
        var candidatesToDie = [Int]()
        
        for i in 0...15 {
            if game.grid.tiles[i].type == "null" {
                candidatesToDie.append(i)
            }
        }
        
        if candidatesToDie.count == 0 {
            gameOver()
        } else {
            let positionToDie = randomElement(array: candidatesToDie)
            gridView.kill(position: positionToDie)
        }
    }
    
    func bomb() {
        
        let dtheta = (randomDouble()+0.5)*3.14
        
        for i in 0..<bombRadiusMultipliers.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + bombInterval*Double(i), execute: {
                let dx = CGFloat(bombRadius*cos(dtheta*Double(i+1))*bombRadiusMultipliers[i])
                let dy = CGFloat(bombRadius*sin(dtheta*Double(i+1))*bombRadiusMultipliers[i])
                self.gridView.view.transform = CGAffineTransform(translationX: dx, y: dy)
            })
        }
    }
    
    func setupMasks() {
        gridMask.path = CGPath(rect: device.contentMask(), transform: nil)
        rackMask.path = CGPath(rect: device.contentMask(), transform: nil)
        gridView.view.layer.mask = gridMask
        rackView.view.layer.mask = rackMask
    }
    
    func pause() {
        
        if playtestOptions.pauseButtonEndsGame {
            gameOver()
            return
        }
        
        if timerView.timeLeft < 0 || game.over {
            return
        }
        
        animateMaskToRect(mask: gridMask, rect: device.contentMaskPaused(), duration: pauseDuration)
        animateMaskToRect(mask: rackMask, rect: device.contentMaskPaused(), duration: pauseDuration)
        
        pauseView.pause()
        game.paused = true
    }
    
    func unpause() {
        animateMaskToRect(mask: gridMask, rect: device.contentMask(), duration: pauseDuration)
        animateMaskToRect(mask: rackMask, rect: device.contentMask(), duration: pauseDuration)
        
        game.paused = false
        pauseView.unpause()
    }
    
    func gameOver() {
        
        
        game.over = true
        gridView.view.removeFromSuperview()
        view.addSubview(gameOverView.view)
        gameOverView.gameOver()
        view.isUserInteractionEnabled = true
    }
    
}
