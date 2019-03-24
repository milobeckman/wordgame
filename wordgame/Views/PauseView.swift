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
    
    var barView: UIView
    var curtainView: UIView
    
    
    
    init() {
        
        view = UIView(frame: vc.screenBounds)
        
        curtainView = UIView(frame: vc.pauseBarFrame())
        curtainView.backgroundColor = vc.backgroundColor
        view.addSubview(curtainView)
        
        barView = UIView(frame: vc.pauseBarFrame())
        barView.layer.borderWidth = CGFloat(1.0)
        barView.layer.borderColor = vc.pauseBarColor.cgColor
        view.addSubview(barView)
        
        
    }
    
    func pause() {
        UIView.animate(withDuration: vc.pauseDuration, animations: {
            self.curtainView.frame = vc.pauseCurtainFramePaused()
            self.barView.frame = vc.pauseBarFramePaused()
        }, completion: { (finished: Bool) in
            self.barView.alpha = 0.0
        })
    }
    
    func unpause() {
        self.barView.alpha = 1.0
        
        UIView.animate(withDuration: vc.pauseDuration, animations: {
            self.curtainView.frame = vc.pauseBarFrame()
            self.barView.frame = vc.pauseBarFrame()
        }, completion: nil)
    }
    
}
