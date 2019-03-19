//
//  Other.swift
//  wordgame
//
//  Created by Milo Beckman on 3/18/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation


func randomDouble() -> Double {
    let max = 1000000
    let rand = Int(arc4random_uniform(UInt32(max)))
    return Double(rand)/Double(max)
}
