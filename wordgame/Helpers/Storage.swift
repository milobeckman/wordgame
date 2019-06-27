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
    
    func getDouble(key: String) -> Double {
        if let value = Double(get(key: key)) {
            return value
        } else {
            return -1.0
        }
    }
    
    func getBool(key: String) -> Bool {
        if get(key: key) == "true" {
            return true
        } else {
            return false
        }
    }
    
    func put(key: String, value: String) {
        storedData[key] = value
        saveData()
    }
    
    func putInt(key: String, value: Int) {
        put(key: key, value: String(value))
    }
    
    func putDouble(key: String, value: Double) {
        put(key: key, value: String(value))
    }
    
    func putBool(key: String, value: Bool) {
        if value {
            put(key: key, value: "true")
        } else {
            put(key: key, value: "false")
        }
    }
    
    func forget(key: String) {
        storedData.removeValue(forKey: key)
        saveData()
    }
    
    func forgetAll() {
        storedData = [String: String]()
        saveData()
    }
    
    
    
    func updateHighscores() {
        if game.currentScore > storage.getInt(key: "bestScore") {
            storage.putInt(key: "bestScore", value: game.currentScore)
        }
        if game.currentLevel > storage.getInt(key: "bestLevel") {
            storage.putInt(key: "bestLevel", value: game.currentLevel)
        }
    }
    
    func updateStats() {
        if game.tilesDropped > storage.getInt(key: "bestTilesDropped") {
            storage.putInt(key: "bestTilesDropped", value: game.tilesDropped)
        }
        if game.wordsCleared > storage.getInt(key: "bestWordsCleared") {
            storage.putInt(key: "bestWordsCleared", value: game.wordsCleared)
        }
        if game.averageWordScore() > storage.getDouble(key: "bestAverageWordScore") {
            storage.putDouble(key: "bestAverageWordScore", value: game.averageWordScore())
        }
        if game.longestStreak > storage.getInt(key: "bestStreak") {
            storage.putInt(key: "bestStreak", value: game.longestStreak)
        }
    }
    
    
}
