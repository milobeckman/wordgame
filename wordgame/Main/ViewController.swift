//
//  ViewController.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import UIKit

// universal
var device = Device()
var rules = Rules()
var playtestOptions = PlaytestOptions()
var settings = Settings()
var storage = Storage()

// game-specific
var game = Game()
var backgroundView = BackgroundView()
var gameView = GameView(game: game)
var dragHandler = DragHandler(gameView: gameView)
var buttonHandler = ButtonHandler()

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isMultipleTouchEnabled = true
        
        if playtestOptions.wipeAllStorage {
            storage.forgetAll()
        }
        
        view.addSubview(backgroundView.view)
        view.addSubview(gameView.view)
        gameView.view.isUserInteractionEnabled = false
        
        dragHandler.gameView = gameView
        buttonHandler.viewController = self
        
        backgroundView.update()
    }
    
    func restart() {
        /* TODO : WHY DOES RESTART BREAK MULTITOUCH?? */
        
        // end existing game
        gameView.timerView.ticker.invalidate()
        buttonHandler.reset()
        
        // start new game
        game = Game()
        backgroundView = BackgroundView()
        gameView = GameView(game: game)
        viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            // pressing button
            if buttonHandler.press(touch: touch) {
                return
            }
            
            // dragging
            if device.rackPositionForPoint(point: touch.location(in: gameView.view)) != -1 {
                dragHandler.liftTile(touch: touch)
            }
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            // no need to handle buttons (temp)
            
            // dragging
            dragHandler.dragTile(touch: touch)
        }
        
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            // pressing button
            if buttonHandler.release(touch: touch) {
                return
            }
            
            // dragging
            dragHandler.dropTile(touch: touch)
        }
        
        super.touchesEnded(touches, with: event)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

