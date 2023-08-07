//
//  EngineIterator.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/8/23.
//

import Foundation

protocol EngineIteratorProtocol {
    func next() -> Int?
    func reset()
}

final class EngineIterator: EngineIteratorProtocol {
    
    private let engine: EngineProtocol
    private var currentRow: Int
    private var currentItem: Int
    
    init(engine: EngineProtocol) {
        self.engine = engine
        self.currentRow = 0
        self.currentItem = 0
    }
    
    private func item(at row: Int, item: Int) -> Int? {
        currentItem+=1
        return engine.items[row][item]
    }
    
    func next() -> Int? {
        if engine.items.count > currentRow {
            if engine.items[currentRow].count > currentItem {
                return item(at: currentRow, item: currentItem)
            } else {
                currentRow+=1
                currentItem = 0
                return next()
            }
        } else {
            return nil
        }
    }
    
    func reset() {
        self.currentRow = 0
        self.currentItem = 0
    }
}
