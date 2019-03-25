//
//  ButtonHandler.swift
//  wordgame
//
//  Created by Milo Beckman on 3/25/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit

class ButtonHandler {
    
    var buttonFrames: [CGRect]
    var buttonTargets: [String]
    var buttonActive: [Bool]
    
    var indexForTouch: [UITouch: Int]
    
    init() {
        buttonFrames = []
        buttonTargets = []
        buttonActive = []
        
        indexForTouch = [:]
    }
    
    func addButton(frame: CGRect, action: String) {
        buttonFrames.append(frame)
        buttonTargets.append(action)
        buttonActive.append(true)
    }
    
    func makeButtonActive(frame: CGRect) {
        for i in 0..<buttonFrames.count {
            if buttonFrames[i] == frame {
                buttonActive[i] = true
            }
        }
    }
    
    func makeButtonInactive(frame: CGRect) {
        for i in 0..<buttonFrames.count {
            if buttonFrames[i] == frame {
                buttonActive[i] = false
            }
        }
    }
    
    func pressButton(index: Int) {
        if index < buttonTargets.count {
            
            let action = buttonTargets[index]
            
            switch action {
            case "pause":
                if game.paused {
                    gameView.unpause()
                } else {
                    gameView.pause()
                }
            default:
                print("unrecognized action")
            }
            
        } else {
            print("error: button index out of range")
        }
    }
    
    func press(touch: UITouch) -> Bool {
        let point = touch.location(in: gameView.view)
        for i in 0..<buttonFrames.count {
            if buttonFrames[i].contains(point) {
                indexForTouch[touch] = i
                return true
            }
        }
        
        return false
    }
    
    func release(touch: UITouch) -> Bool {
        let point = touch.location(in: gameView.view)
        if let i = indexForTouch[touch] {
            if buttonFrames[i].contains(point) {
                pressButton(index: indexForTouch[touch]!)
                return true
            }
        }
        
        return false
    }
    
    
}
