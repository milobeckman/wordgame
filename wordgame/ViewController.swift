//
//  ViewController.swift
//  wordgame
//
//  Created by Milo Beckman on 3/10/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import UIKit

var vc = ViewConstants()
var gameView = GameView()

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(gameView.view)
        
        /*
        let testTile = Tile(type: "letter", text: "m")
        let testTileView = TileView(tile: testTile)
        testTileView.moveToGridPosition(position: 5)
        view.addSubview(testTileView.view)*/

        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            testTileView.evaporate()
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

