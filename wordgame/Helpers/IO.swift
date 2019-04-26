//
//  IO.swift
//  wordgame
//
//  Created by Milo Beckman on 3/18/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation

class IO {
    
    class func loadResource(resource: String) -> [String] {
        let fileInfo = resource.components(separatedBy: ".")
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
    
    
    class func read(from: String) -> [String] {
        
        let documentDirectory = try! FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirectory.appendingPathComponent(from)
        
        var contents : String
        var lines : [String]
        do {
            contents = try String(contentsOfFile: fileURL.path, encoding: String.Encoding.utf8)
            lines = Array(contents.components(separatedBy: "\n").dropLast())
        } catch {
            lines = [noneString]
            print("error reading from file " + from)
        }
        
        return lines
    }
    
    class func write(to: String, lines: [String]) {
        
        let documentDirectory = try! FileManager.default.url(
            for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDirectory.appendingPathComponent(to)
        
        var stringToWrite = ""
        for line in lines {
            stringToWrite += line + "\n"
        }
        
        do {
            try stringToWrite.write(to: fileURL, atomically: false, encoding: String.Encoding.utf8)
        } catch _ as NSError {
            print("error writing to file " + to)
        }
    }
}



// TODO : WORDLIST DOESN'T INCLUDE ALL WORD LENGTHS
func wordListForLength(length: Int) -> [String] {
    return IO.loadResource(resource: "WordList-" + String(length) + ".txt")
}
