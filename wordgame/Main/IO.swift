//
//  IO.swift
//  wordgame
//
//  Created by Milo Beckman on 3/18/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

func readlines(filename: String) -> [String] {
    let fileInfo = filename.components(separatedBy: ".")
    if let path = Bundle.main.path(forResource: fileInfo[0], ofType: fileInfo[1]) {
        do {
            let data = try String(contentsOfFile: path, encoding: .utf8)
            return data.components(separatedBy: .newlines)
        } catch {
            print("file read error")
            return []
        }
    }
    
    print("file read error")
    return []
}
