//
//  ViewController.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import UIKit

var vc = ViewConstants()

var gridSlotViews = [GridSlotView]()


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = vc.backgroundColor
        
        gridSlotViews = []
        for i in 0...15 {
            let newGridSlot = GridSlotView(position: i)
            gridSlotViews.append(newGridSlot)
            
            view.addSubview(newGridSlot.view)
        }
        
        
        let testTile = Tile(type: "letter", text: "m")
        let testTileView = TileView(tile: testTile)
        testTileView.moveToGridPosition(position: 5)
        view.addSubview(testTileView.view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

