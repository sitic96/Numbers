//
//  Randomizer.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/7/23.
//

import Foundation

protocol RandomizerProtocol {
    func randomNumber() -> Int
    func randomNumbers(count: Int) -> [Int]
}

struct Randomizer: RandomizerProtocol {
    func randomNumber() -> Int {
        Int.random(in: 1...9)
    }
    
    func randomNumbers(count: Int) -> [Int] {
        var array = [Int]()
        for _ in 0..<count {
            array.append(randomNumber())
        }
        return array
    }
}
