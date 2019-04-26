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
let scoreTextSize = CGFloat(60)
let levelTextSize = CGFloat(13)
let tileTextSize = CGFloat(40)
let tileScoreTextSize = CGFloat(18)
let badgeTextSize = CGFloat(20)
let bestTextSize = CGFloat(12)
let menuTextSize = CGFloat(24)
let playSomethingTextSize = CGFloat(22)
let statsTextSize = CGFloat(16)
let gameOverTextSize = CGFloat(26)

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
