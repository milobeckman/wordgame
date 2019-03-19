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
    
    var gridView: GridView
    var rackView: RackView
    var timerView: TimerView
    
    var view: UIView
    
    init() {
        
        game = Game()
        
        gridView = GridView(grid: game.grid)
        rackView = RackView(rack: game.rack)
        timerView = TimerView()
        
        view = UIView(frame: vc.screenBounds)
        view.backgroundColor = vc.backgroundColor
        view.addSubview(gridView.view)
        view.addSubview(timerView.view)
        view.addSubview(rackView.view)
        
        newGame()
    }
    
    func newGame() {
        for i in 0...3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)*vc.popDelay, execute: {
                self.rackView.serveNewTile(position: i)
            })
        }
    }
    
    func serveNewTile(rackPosition: Int) {
        timerView.resetTimer()
        rackView.serveNewTile(position: rackPosition)
    }
    
}
