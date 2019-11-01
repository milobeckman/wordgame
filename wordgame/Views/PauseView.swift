//
//  PauseView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/22/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


class PauseView {
    
    
    
    var view: UIView
    
    var pauseButton: UIImageView
    var barView: UIView
    var curtainView: UIView
    
    var curtainMask: CAShapeLayer
    
    let numMenuButtons = 1
    var menuButtons: [UIView]
    var menuLabels: [UILabel]
    var highScoreLabel: UILabel
    
    
    
    init() {
        
        view = UIView(frame: device.screenBounds)
        
        pauseButton = UIImageView(frame: device.pauseButtonFrame())
        pauseButton.image = UIImage(named: "pause")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        pauseButton.tintColor = pauseButtonColor()
        buttonHandler.addButton(frame: pauseButton.frame, action: "pause")
        view.addSubview(pauseButton)
        
        barView = UIView(frame: device.pauseBarFrame())
        barView.layer.borderWidth = CGFloat(1.0)
        barView.layer.borderColor = barColor.cgColor
        view.addSubview(barView)
        
        curtainView = UIView(frame: device.screenBounds)
        view.addSubview(curtainView)
        curtainMask = CAShapeLayer()
        curtainMask.path = CGPath(rect: device.pauseBarFrame(), transform: nil)
        curtainView.layer.mask = curtainMask
        
        menuButtons = []
        menuLabels = []
        highScoreLabel = UILabel()
        
        addMenuButton(action: "restart", labelText: "Restart")
        setupMenu()
        makeButtonsInactive()
        
    }
    
    func addMenuButton(action: String, labelText: String) {
        let newButton = UIView(frame: device.menuButtonFrame(numMenuButtons: numMenuButtons, i: menuButtons.count))
        buttonHandler.addButton(frame: newButton.frame, action: action)
        menuButtons.append(newButton)
        
        let newLabel = UILabel(frame: device.menuButtonFrame(numMenuButtons: numMenuButtons, i: menuLabels.count))
        newLabel.text = labelText
        menuLabels.append(newLabel)
    }
    
    func setupMenu() {
        for button in menuButtons {
            button.backgroundColor = menuButtonColor()
            button.layer.borderWidth = device.menuButtonBorderWidth
            button.layer.borderColor = menuButtonBorderColor().cgColor
            button.layer.cornerRadius = device.menuButtonRadius
            curtainView.addSubview(button)
        }
        
        for label in menuLabels {
            label.font = menuFont
            label.textColor = menuButtonBorderColor()
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.baselineAdjustment = .alignCenters
            curtainView.addSubview(label)
        }
        
        highScoreLabel = UILabel(frame: device.highScoreLabelFrame(numMenuButtons: numMenuButtons))
        highScoreLabel.font = highScoreFont
        highScoreLabel.textColor = levelTextColor(level: game.currentLevel)
        highScoreLabel.textAlignment = .center
        highScoreLabel.adjustsFontSizeToFitWidth = true
        highScoreLabel.baselineAdjustment = .alignCenters
        let highScore = storage.getInt(key: "bestScore")
        if highScore > 0 {
            highScoreLabel.text = "High score: " + String(highScore)
        }
        curtainView.addSubview(highScoreLabel)
        
    }
    
    func updateColors() {
        pauseButton.tintColor = pauseButtonColor()
        for menuButton in menuButtons {
            menuButton.backgroundColor = menuButtonColor()
            menuButton.layer.borderColor = menuButtonBorderColor().cgColor
        }
        for menuLabel in menuLabels {
            menuLabel.textColor = menuButtonBorderColor()
        }
    }
    
    func pause() {
        pauseButton.image = UIImage(named: "resume")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        updateColors()
        
        animateMaskToRect(mask: curtainMask, rect: device.pauseCurtainFramePaused(), duration: pauseDuration)
        
        UIView.animate(withDuration: pauseDuration, animations: {
            self.barView.frame = device.pauseBarFramePaused()
        }, completion: { (finished: Bool) in
            self.barView.alpha = CGFloat(0.0)
            self.makeButtonsActive()
        })
    }
    
    func unpause() {
        makeButtonsInactive()
        
        pauseButton.image = UIImage(named: "pause")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        pauseButton.tintColor = pauseButtonColor()
        self.barView.alpha = 1.0
        
        animateMaskToRect(mask: curtainMask, rect: device.pauseBarFrame(), duration: pauseDuration)
        
        UIView.animate(withDuration: pauseDuration, animations: {
            self.barView.frame = device.pauseBarFrame()
        }, completion: { (finished: Bool) in
            self.barView.alpha = 1.0
        })
    }
    
    func makeButtonsActive() {
        for button in menuButtons {
            buttonHandler.makeButtonActive(frame: button.frame)
        }
    }
    
    func makeButtonsInactive() {
        for button in menuButtons {
            buttonHandler.makeButtonInactive(frame: button.frame)
        }
    }
    
    func switchToNightMode() {
        
        for button in menuButtons {
            button.backgroundColor = menuButtonColor()
            button.layer.borderColor = menuButtonBorderColor().cgColor
        }
        
        for label in menuLabels {
            label.textColor = menuButtonBorderColor()
        }
        
        highScoreLabel.textColor = levelTextColor(level: game.currentLevel)
    }
    
    func gameOver() {
        buttonHandler.makeButtonInactive(frame: pauseButton.frame)
        UIView.animate(withDuration: shrinkDuration, delay: waitBeforeShrinking, options: .curveLinear, animations: {
            self.pauseButton.alpha = 0.0
        }, completion: nil)
    }
    
}
