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
            var lines = data.components(separatedBy: .newlines)
            while lines[lines.count-1].count == 0 {
                lines = Array(lines[0..<lines.count-1])
            }
            
            return lines
        } catch {
            print("file read error")
            return []
        }
    }
    
    print("file read error")
    return []
}

// TODO : WORDLIST DOESN'T INCLUDE ALL WORD LENGTHS
func loadWordLists(filename: String) -> [Int : [String]] {
    var wordLists = [Int : [String]]()
    
    for i in 3...12 {
        wordLists[i] = []
    }
    
    let lines = readlines(filename: filename)
    for line in lines {
        if (3...12).contains(line.count) {
            wordLists[line.count]!.append(line)
        }
    }
    
    print(wordLists[9]!)
    return wordLists
}
