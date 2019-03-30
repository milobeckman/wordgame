//
//  Colors.swift
//  wordgame
//
//  Created by Milo Beckman on 3/30/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


// GameView
let backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1)

// ScoreView
let scoreTextColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
let levelTextColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)

// RackView
let rackColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1)
let rackSlotColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
let rackSlotWidth = CGFloat(4)

// TimerView
let timerBackgroundColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
let timerBarStartRGB = [0.0,1.0,0.0]
let timerBarMidRGB = [1.0,1.0,0.0]
let timerBarEndRGB = [1.0,0.0,0.0]
let timerBarMidpoint = 0.3
let timerShadowSize = CGFloat(7)
let timerShadowStartColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
let timerShadowEndColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
let playSomethingBackgroundColor = [UIColor.red, UIColor.white]
let playSomethingTextColor = [UIColor.white, UIColor.red]

// PauseView
let pauseBarColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1)

// TileView
let tileColor = UIColor(red: 0.9, green: 0.84, blue: 0.7, alpha: 1)
let tileDepthColor = UIColor(red: 0.7, green: 0.64, blue: 0.5, alpha: 1)
let tileTextColor = UIColor(red: 0.3, green: 0.24, blue: 0.1, alpha: 1)
let tileGlintColor = UIColor(red: 0.95, green: 0.89, blue: 0.78, alpha: 1)
let fadedTileViewAlpha = CGFloat(0.3)

let wildColor = UIColor(red: 0.9843, green: 0.8078, blue: 0.2471, alpha: 1.0)
let wildDepthColor = UIColor(red: 0.749, green: 0.6078, blue: 0.1882, alpha: 1.0)

let trashColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
let trashDepthColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)

let lifeColor = UIColor(red: 0.9451, green: 0.5686, blue: 0.6706, alpha: 1.0)
let lifeDepthColor = UIColor(red: 0.749, green: 0.3373, blue: 0.4039, alpha: 1.0)

// GridSlotView
let gridSlotColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
let gridSlotColorHighlight = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
let gridSlotColorDying = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.6)
let gridSlotColorRebirth = UIColor(red: 0.8471, green: 0.7451, blue: 0.7686, alpha: 1.0)
let gridSlotAlpha = CGFloat(1.0)

// GameOverView
let statsTextColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)
let statsNumberColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)



// tile colors

func tileDepthColor(type: String) -> UIColor {
    switch type {
    case "wild":
        return wildDepthColor
    case "trash":
        return trashDepthColor
    case "life":
        return lifeDepthColor
    default:
        return tileDepthColor
    }
}

func tileColor(type: String) -> UIColor {
    switch type {
    case "wild":
        return wildColor
    case "trash":
        return trashColor
    case "life":
        return lifeColor
    default:
        return tileColor
    }
}

func tileGlintColor(type: String) -> UIColor {
    switch type {
    default:
        return tileGlintColor
    }
}

func tileTextColor(type: String) -> UIColor {
    switch type {
    default:
        return tileTextColor
    }
}


// interpolation

func timerBarColor(fraction: Double) -> UIColor {
    if fraction > timerBarMidpoint {
        let p = (1.0 - fraction) / (1.0 - timerBarMidpoint)
        return interpolateColor(start: timerBarStartRGB, end: timerBarMidRGB, fraction: p)
    } else {
        let p = (timerBarMidpoint - fraction) / (timerBarMidpoint)
        return interpolateColor(start: timerBarMidRGB, end: timerBarEndRGB, fraction: p)
    }
}

func interpolateColor(start: [Double], end: [Double], fraction: Double) -> UIColor {
    let r = CGFloat(start[0]*(1-fraction) + end[0]*fraction)
    let g = CGFloat(start[1]*(1-fraction) + end[1]*fraction)
    let b = CGFloat(start[2]*(1-fraction) + end[2]*fraction)
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
}


