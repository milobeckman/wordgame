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
    
    
    init() {
        
        view = UIView(frame: device.screenBounds)
        
        pauseButton = UIImageView(frame: device.pauseButtonFrame())
        pauseButton.image = UIImage(named: "pause")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pauseButton.tintColor = gridSlotColorHighlight()
        
        buttonHandler.addButton(frame: pauseButton.frame, action: "pause")
        view.addSubview(pauseButton)
        
        curtainView = UIView(frame: device.pauseBarFrame())
        view.addSubview(curtainView)
        
        barView = UIView(frame: device.pauseBarFrame())
        barView.layer.borderWidth = CGFloat(1.0)
        barView.layer.borderColor = pauseBarColor.cgColor
        view.addSubview(barView)
    }
    
    func pause() {
        pauseButton.image = UIImage(named: "resume")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pauseButton.tintColor = gridSlotColorHighlight()
        
        UIView.animate(withDuration: pauseDuration, animations: {
            self.curtainView.frame = device.pauseCurtainFramePaused()
            self.barView.frame = device.pauseBarFramePaused()
        }, completion: { (finished: Bool) in
            self.barView.alpha = CGFloat(0.0)
        })
    }
    
    func unpause() {
        pauseButton.image = UIImage(named: "pause")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pauseButton.tintColor = gridSlotColorHighlight()
        self.barView.alpha = 1.0
        
        UIView.animate(withDuration: pauseDuration, animations: {
            self.curtainView.frame = device.pauseBarFrame()
            self.barView.frame = device.pauseBarFrame()
        }, completion: { (finished: Bool) in
            self.barView.alpha = 1.0
        })
    }
    
    func switchToNightMode() {
        pauseButton.tintColor = gridSlotColorHighlight()
    }
    
}
