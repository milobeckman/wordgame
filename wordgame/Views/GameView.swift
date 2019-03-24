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
    
    var scoreView: ScoreView
    var gridView: GridView
    var rackView: RackView
    var timerView: TimerView
    var pauseView: PauseView
    
    var view: UIView
    
    init(game: Game) {
        
        self.game = game
        
        scoreView = ScoreView(game: game)
        pauseView = PauseView()
        gridView = GridView(grid: game.grid)
        rackView = RackView(rack: game.rack)
        timerView = TimerView()
        
        view = UIView(frame: vc.screenBounds)
        view.backgroundColor = vc.backgroundColor
        view.addSubview(scoreView.view)
        view.addSubview(gridView.view)
        view.addSubview(timerView.view)
        view.addSubview(rackView.view)
        view.addSubview(pauseView.view)
        
        newGame()
    }
    
    func newGame() {
        for i in 0...3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)*vc.popDelay, execute: {
                self.rackView.serveNewTile(position: i)
            })
        }
        
        game.over = false
    }
    
    func serveNewTile(rackPosition: Int) {
        timerView.resetTimer()
        rackView.serveNewTile(position: rackPosition)
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
    
    func pause() {
        timerView.pauseTimer()
        pauseView.pause()
        game.paused = true
    }
    
    func unpause() {
        game.paused = false
        pauseView.unpause()
        DispatchQueue.main.asyncAfter(deadline: .now() + vc.pauseDuration, execute: {
            self.timerView.resumeTimer()
        })
    }
    
    func gameOver() {
        print("game over!")
        timerView.pauseTimer()
        game.over = true
    }
    
}
