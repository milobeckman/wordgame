//
//  Fonts.swift
//  wordgame
//
//  Created by Milo Beckman on 3/30/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation
import UIKit


// fonts
let font = "BanglaSangamMN"
let fontBold = "BanglaSangamMN-Bold"

// sizes
let scoreTextSize = CGFloat(60)*device.fontScale
let levelTextSize = CGFloat(13)*device.fontScale
let tileTextSize = CGFloat(40)*device.fontScale
let tileScoreTextSize = CGFloat(18)*device.fontScale
let badgeTextSize = CGFloat(20)*device.fontScale
let bestTextSize = CGFloat(12)*device.fontScale
let menuTextSize = CGFloat(24)*device.fontScale
let playSomethingTextSize = CGFloat(22)*device.fontScale
let statsTextSize = CGFloat(16)*device.fontScale
let gameOverTextSize = CGFloat(26)*device.fontScale

// combined
let scoreFont = UIFont(name: fontBold, size: scoreTextSize)
let levelFont = UIFont(name: fontBold, size: levelTextSize)
let tileFont = UIFont(name: fontBold, size: tileTextSize)
let tileScoreFont = UIFont(name: fontBold, size: tileScoreTextSize)
let badgeFont = UIFont(name: fontBold, size: badgeTextSize)
let bestFont = UIFont(name: fontBold, size: bestTextSize)
let menuFont = UIFont(name: fontBold, size: menuTextSize)
let playSomethingFont = UIFont(name: fontBold, size: playSomethingTextSize)
let gameOverFont = UIFont(name: fontBold, size: gameOverTextSize)
let statsTextFont = UIFont(name: font, size: statsTextSize)
let statsNumberFont = UIFont(name: fontBold, size: statsTextSize)

// other
let characterWidthPerFontSize = CGFloat(0.5)
