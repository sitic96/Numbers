//
//  Randomizer.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/7/23.
//

import Foundation

protocol RandomizerProtocol {
    func randomItems(count: Int) -> [Cell]
}

struct Randomizer: RandomizerProtocol {
    private func randomNumber() -> Int {
        Int.random(in: 1...9)
    }
    
    func randomItems(count: Int) -> [Cell] {
        var array = [Int]()
        for _ in 0..<count {
            array.append(randomNumber())
        }
        return array.enumerated().map {
            Cell(number: $1,
                 position: Position(row: $0.quotientAndRemainder(dividingBy: 9).quotient, item: $0 % 9))
        }
    }
}
