//
//  GameOverView.swift
//  wordgame
//
//  Created by Milo Beckman on 3/30/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


class GameOverView {
    
    var gridView: GridView
    var view: UIView
    
    
    init(gridView: GridView) {
        
        self.gridView = gridView
        view = UIView(frame: device.screenBounds)
    }
    
    func gameOver() {
        view.addSubview(gridView.view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + waitBeforeShrinking, execute: {
            self.shrinkGridView()
        })
    }
    
    func shrinkGridView() {
        let anchorX = device.gridX / view.frame.width
        let anchorY = device.gridY / view.frame.height
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: gridView.view)
        
        let scaleHalf = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: shrinkDuration, animations: {
            self.gridView.view.transform = scaleHalf
        }, completion: { (finished: Bool) in
            self.showStats()
        })
    }
    
    func showStats() {
        
    }
    
    
}
