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
let backgroundColor = UIColor(hue: 0.6167, saturation: 0.72, brightness: 0.66, alpha: 1.0)
let gradientNodes = [-8.0, 1.0, 9.0, 18.0, 25.0, 50.0, 100.0]
let gradientHSBs = [//[0.5111,0.14,1.00],
                    [0.4917,0.07,1.0],      // white-ish blue
                    [0.5222,0.14,0.86],     // sky blue
                    [0.6167,0.57,0.6],      // evening blue
                    [0.6167,0.0,0.0],       // black
                    [0.8083,0.0,0.0],       // black
                    [0.8083,0.64,0.81],     // violet
                    [0.8083,0.0,1.0]]       // white (never comes)
let middleColor = UIColor(hue: 0.5222, saturation: 0.14, brightness: 0.86, alpha: 0.1)

// BackgroundView
let gradientBottomMinus = 8.0
let streakViewAlpha = CGFloat(0.1)

// ScoreView
let scoreTextColorDay = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
let scoreTextColorNight = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
let levelTextColorDay = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)
let levelTextColorNight = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)

// RackView
let rackColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 0.0)
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
let barColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1)
let pauseButtonAlphaDay = CGFloat(0.35)
let pauseButtonAlphaNight = CGFloat(0.75)
let menuButtonAlpha = CGFloat(0.08)

// TileView
let tileColor = UIColor(red: 0.9, green: 0.84, blue: 0.7, alpha: 1)
let tileDepthColor = UIColor(red: 0.7, green: 0.64, blue: 0.5, alpha: 1)
let tileTextColor = UIColor(red: 0.3, green: 0.24, blue: 0.1, alpha: 1)
let tileGlintColor = UIColor(red: 0.95, green: 0.89, blue: 0.78, alpha: 1)
let fadedTileViewAlpha = CGFloat(0.3)

let doubleColor = UIColor(red: 0.3, green: 0.24, blue: 0.1, alpha: 1)
let doubleDepthColor = UIColor(red: 0.1, green: 0.04, blue: 0.0, alpha: 1)
let doubleTextColor = UIColor(red: 0.9, green: 0.84, blue: 0.7, alpha: 1)
let doubleGlintColor = UIColor(red: 0.1, green: 0.04, blue: 0.0, alpha: 1)

let tripleColor = UIColor(red: 0.3, green: 0.24, blue: 0.1, alpha: 1)
let tripleDepthColor = UIColor(red: 0.1, green: 0.04, blue: 0.0, alpha: 1)
let tripleTextColor = UIColor(red: 0.9, green: 0.84, blue: 0.7, alpha: 1)
let tripleGlintColor = UIColor(red: 0.1, green: 0.04, blue: 0.0, alpha: 1)

let wildColor = UIColor(red: 0.9843, green: 0.8078, blue: 0.2471, alpha: 1.0)
let wildDepthColor = UIColor(red: 0.749, green: 0.6078, blue: 0.1882, alpha: 1.0)

let trashColor = UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1.0)
let trashDepthColor = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)

let lifeColor = UIColor(red: 0.9451, green: 0.5686, blue: 0.6706, alpha: 1.0)
let lifeDepthColor = UIColor(red: 0.749, green: 0.3373, blue: 0.4039, alpha: 1.0)

let bombColor = UIColor(red: 0.7255, green: 0.4824, blue: 0.7686, alpha: 1.0)
let bombDepthColor = UIColor(red: 0.5569, green: 0.3451, blue: 0.6, alpha: 1.0)

let iceColor = UIColor(hue: 0.5333, saturation: 0.27, brightness: 0.87, alpha: 1.0)
let iceDepthColor = UIColor(hue: 0.5333, saturation: 0.38, brightness: 0.67, alpha: 1.0)

// GridSlotView [day, night]
let gridSlotHue = [0.0, 0.0]
let gridSlotBrightness = [0.55, 0.75]
let gridSlotAlpha = [0.3, 0.3]

let gridSlotHighlightBrightness = [0.45, 0.85]
let gridSlotHighlightAlpha = [0.5, 0.5]

let gridSlotDyingSaturation = [0.5, 0.5]
let gridSlotDyingAlpha = [0.6, 0.6]

let gridSlotRevivingHue = [0.875, 0.875]
let gridSlotRevivingSaturation = [0.5, 0.5]
let gridSlotRevivingAlpha = [0.3, 0.3]

// BadgeView
let badgeColor = UIColor(hue: 0.3472, saturation: 1.0, brightness: 0.81, alpha: 1.0)
let badgeColorCombo = UIColor(hue: 0.1111, saturation: 1.0, brightness: 0.94, alpha: 1.0)
let badgeColorStreak = UIColor(hue: 0.8111, saturation: 1.0, brightness: 0.78, alpha: 1.0)
let badgeTextColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 1.0, alpha: 0.8)
let badgeShadowColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 0.4)


// BestView
let bestColor = badgeColor
let bestDepthColor = UIColor(hue: 0.3472, saturation: 0.8, brightness: 0.61, alpha: 1.0)
let bestTextColor = badgeTextColor

// MultiplierView
let comboDepthColor = UIColor(hue: 0.1111, saturation: 0.8, brightness: 0.74, alpha: 1.0)
let streakDepthColor = UIColor(hue: 0.8111, saturation: 0.8, brightness: 0.58, alpha: 1.0)

// GameOverView
let statsTextColorDay = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
let statsTextColorNight = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
let statsNumberColorDay = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
let statsNumberColorNight = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)



// day/night

func levelTextColor(level: Int) -> UIColor {
    if nightMode(level: level) {
        return scoreTextColorNight
    } else {
        return scoreTextColorDay
    }
}

func scoreTextColor(level: Int) -> UIColor {
    if nightMode(level: level) {
        return scoreTextColorNight
    } else {
        return scoreTextColorDay
    }
}

func gridSlotColor() -> UIColor {
    let i = nightMode(level: game.currentLevel) ? 1 : 0
    let h = CGFloat(gridSlotHue[i])
    let s = CGFloat(0.0)
    let b = CGFloat(gridSlotBrightness[i])
    let a = CGFloat(gridSlotAlpha[i])
    return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
}

func gridSlotColorHighlight() -> UIColor {
    let i = nightMode(level: game.currentLevel) ? 1 : 0
    let h = CGFloat(gridSlotHue[i])
    let s = CGFloat(0.0)
    let b = CGFloat(gridSlotHighlightBrightness[i])
    let a = CGFloat(gridSlotHighlightAlpha[i])
    return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
}

func gridSlotColorDying() -> UIColor {
    let i = nightMode(level: game.currentLevel) ? 1 : 0
    let h = CGFloat(gridSlotHue[i])
    let s = CGFloat(gridSlotDyingSaturation[i])
    let b = CGFloat(gridSlotBrightness[i])
    let a = CGFloat(gridSlotDyingAlpha[i])
    return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
}

func gridSlotColorReviving() -> UIColor {
    let i = nightMode(level: game.currentLevel) ? 1 : 0
    let h = CGFloat(gridSlotRevivingHue[i])
    let s = CGFloat(gridSlotRevivingSaturation[i])
    let b = CGFloat(gridSlotBrightness[i])
    let a = CGFloat(gridSlotRevivingAlpha[i])
    return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
}

func pauseButtonAlpha() -> CGFloat {
    if nightMode(level: game.currentLevel) {
        return pauseButtonAlphaNight
    } else {
        return pauseButtonAlphaDay
    }
}

func pauseButtonColor() -> UIColor {
    
    return scoreTextColor(level: game.currentLevel).withAlphaComponent(pauseButtonAlpha())
    
    /*
    if !nightMode(level: game.currentLevel) {
        return gridSlotColorHighlight()
    } else {
        return scoreTextColor(level: game.currentLevel)
    }*/
}

func menuButtonColor() -> UIColor {
    return pauseButtonColor().withAlphaComponent(menuButtonAlpha)
}

func menuButtonBorderColor() -> UIColor {
    return pauseButtonColor()
}

func menuTextColor() -> UIColor {
    if nightMode(level: game.currentLevel) {
        return scoreTextColorDay
    } else {
        return scoreTextColorNight
    }
}

func statsTextColor() -> UIColor {
    if nightMode(level: game.currentLevel) {
        return statsTextColorDay
    } else {
        return statsTextColorNight
    }
}

func statsNumberColor() -> UIColor {
    if nightMode(level: game.currentLevel) {
        return statsNumberColorDay
    } else {
        return statsNumberColorNight
    }
}

func playAgainButtonGlowAlpha() -> CGFloat {
    if nightMode(level: game.currentLevel) {
        return glowAlphaNight
    } else {
        return glowAlphaDay
    }
}

func nightMode(level: Int) -> Bool {
    return level >= 10
}



// tile colors

func tileDepthColor(tile: Tile) -> UIColor {
    switch tile.type {
    case "wild":
        return wildDepthColor
    case "trash":
        return trashDepthColor
    case "life":
        return lifeDepthColor
    case "bomb":
        return bombDepthColor
    case "ice":
        return iceDepthColor
    default:
        switch tile.text.count {
        case 1:
            return tileDepthColor
        case 2:
            return doubleDepthColor
        default:
            return tripleDepthColor
        }
    }
}

func tileColor(tile: Tile) -> UIColor {
    switch tile.type {
    case "wild":
        return wildColor
    case "trash":
        return trashColor
    case "life":
        return lifeColor
    case "bomb":
        return bombColor
    case "ice":
        return iceColor
    default:
        switch tile.text.count {
        case 1:
            return tileColor
        case 2:
            return doubleColor
        default:
            return tripleColor
        }
    }
}

func tileGlintColor(tile: Tile) -> UIColor {
    switch tile.text.count {
    case 1:
        return tileGlintColor
    case 2:
        return doubleGlintColor
    default:
        return tripleGlintColor
    }
}

func tileTextColor(tile: Tile) -> UIColor {
    switch tile.text.count {
    case 1:
        return tileTextColor
    case 2:
        return doubleTextColor
    default:
        return tripleTextColor
    }
}


func badgeColor(multiplier: Int) -> UIColor {
    switch multiplier {
    case 3:
        return badgeColorStreak
    case 2:
        return badgeColorCombo
    default:
        return badgeColor
    }
}


// interpolation

func gradientBottomColor(level: Double) -> UIColor {
    return gradientTopColor(level: level - gradientBottomMinus)
}

func gradientTopColor(level: Double) -> UIColor {
    var stage = 0
    
    for i in 0..<gradientNodes.count-1 {
        if level >= gradientNodes[i] && level < gradientNodes[i+1] {
            stage = i
        }
    }
    
    let prevNode = gradientNodes[stage]
    let nextNode = gradientNodes[stage+1]
    
    let start = gradientHSBs[stage]
    let end = gradientHSBs[stage+1]
    
    let fraction = (level - prevNode) / (nextNode - prevNode)
    return interpolateColorHSB(start: start, end: end, fraction: fraction)
}

func timerBarColor(fraction: Double) -> UIColor {
    if fraction > timerBarMidpoint {
        let p = (1.0 - fraction) / (1.0 - timerBarMidpoint)
        return interpolateColorRGB(start: timerBarStartRGB, end: timerBarMidRGB, fraction: p)
    } else {
        let p = (timerBarMidpoint - fraction) / (timerBarMidpoint)
        return interpolateColorRGB(start: timerBarMidRGB, end: timerBarEndRGB, fraction: p)
    }
}

func interpolateColorRGB(start: [Double], end: [Double], fraction: Double) -> UIColor {
    let r = CGFloat(start[0]*(1-fraction) + end[0]*fraction)
    let g = CGFloat(start[1]*(1-fraction) + end[1]*fraction)
    let b = CGFloat(start[2]*(1-fraction) + end[2]*fraction)
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
}

func interpolateColorHSB(start: [Double], end: [Double], fraction: Double) -> UIColor {
    let h = CGFloat(start[0]*(1-fraction) + end[0]*fraction)
    let s = CGFloat(start[1]*(1-fraction) + end[1]*fraction)
    let b = CGFloat(start[2]*(1-fraction) + end[2]*fraction)
    return UIColor(hue: h, saturation: s, brightness: b, alpha: 1.0)
}



