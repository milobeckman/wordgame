//
//  ViewController.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import UIKit

var vc = ViewConstants()
var rules = Rules()

var game = Game()
var gameView = GameView(game: game)

var dragHandler = DragHandler(gameView: gameView)
var buttonHandler = ButtonHandler()

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isMultipleTouchEnabled = true
        
        view.addSubview(gameView.view)
        gameView.view.isUserInteractionEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            // pressing button
            if buttonHandler.press(touch: touch) {
                return
            }
            
            // dragging
            if !game.paused && vc.rackPositionForPoint(point: touch.location(in: gameView.view)) != -1 {
                dragHandler.liftTile(touch: touch)
            }
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            // no need to handle buttons (temp)
            
            if !game.paused {
                dragHandler.dragTile(touch: touch)
            }
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
            if !game.paused {
                dragHandler.dropTile(touch: touch)
            }
        }
        
        super.touchesEnded(touches, with: event)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

