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
var gameView = GameView()
var touchHandler = TouchHandler(gameView: gameView)

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isMultipleTouchEnabled = true
        view.addSubview(gameView.view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if vc.rackFrame().contains(touch.location(in: gameView.view)) {
                touchHandler.liftTile(touch: touch)
            }
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved")
        if let touch = touches.first {
            touchHandler.dragTile(touch: touch)
        }
        
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchHandler.dropTile(touch: touch)
        }
        
        super.touchesEnded(touches, with: event)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

