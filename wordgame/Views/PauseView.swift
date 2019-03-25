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
        
        view = UIView(frame: vc.screenBounds)
        
        pauseButton = UIImageView(frame: vc.pauseButtonFrame())
        pauseButton.image = UIImage(named: "pause")
        buttonHandler.addButton(frame: pauseButton.frame, action: "pause")
        view.addSubview(pauseButton)
        
        curtainView = UIView(frame: vc.pauseBarFrame())
        curtainView.backgroundColor = vc.backgroundColor
        view.addSubview(curtainView)
        
        barView = UIView(frame: vc.pauseBarFrame())
        barView.layer.borderWidth = CGFloat(1.0)
        barView.layer.borderColor = vc.pauseBarColor.cgColor
        view.addSubview(barView)
    }
    
    func pause() {
        pauseButton.image = UIImage(named: "resume")
        
        UIView.animate(withDuration: vc.pauseDuration, animations: {
            self.curtainView.frame = vc.pauseCurtainFramePaused()
            self.barView.frame = vc.pauseBarFramePaused()
        }, completion: { (finished: Bool) in
            self.barView.alpha = CGFloat(0.0)
        })
    }
    
    func unpause() {
        pauseButton.image = UIImage(named: "pause")
        self.barView.alpha = 1.0
        
        UIView.animate(withDuration: vc.pauseDuration, animations: {
            self.curtainView.frame = vc.pauseBarFrame()
            self.barView.frame = vc.pauseBarFrame()
        }, completion: { (finished: Bool) in
            self.barView.alpha = 1.0
        })
    }
    
}
