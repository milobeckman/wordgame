//
//  Storage.swift
//  wordgame
//
//  Created by Milo Beckman on 4/26/19.
//  Copyright © 2019 Milo Beckman, Inc. All rights reserved.
//

import Foundation


class Storage {
    
    var storedData: [String: String]
    let storageFilename = "storage.txt"
    let seperatorChar = ":"
    
    init() {
        storedData = [String: String]()
        loadStoredData()
    }
    
    func loadStoredData() {
        storedData = [String: String]()
        let lines = IO.read(from: storageFilename)
        for line in lines {
            let components = line.components(separatedBy: seperatorChar)
            if components.count >= 2 {
                storedData[components[0]] = components[1]
            }
        }
    }
    
    func saveData() {
        var lines = [String]()
        for key in storedData.keys {
            let line = key + seperatorChar + storedData[key]!
            lines.append(line)
        }
        
        IO.write(to: storageFilename, lines: lines)
    }
    
    func get(key: String) -> String {
        if let value = storedData[key] {
            return value
        } else {
            return noneString
        }
    }
    
    func getInt(key: String) -> Int {
        if let value = Int(get(key: key)) {
            return value
        } else {
            return -1
        }
    }
    
    func put(key: String, value: String) {
        storedData[key] = value
        saveData()
    }
    
    func putInt(key: String, value: Int) {
        put(key: key, value: String(value))
    }
    
    func forget(key: String) {
        storedData.removeValue(forKey: key)
        saveData()
    }
    
    func forgetAll() {
        storedData = [String: String]()
        saveData()
    }
    
    
    
}
