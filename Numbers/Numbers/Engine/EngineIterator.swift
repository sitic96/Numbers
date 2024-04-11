//
//  EngineIterator.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/8/23.
//

import Foundation

protocol EngineIteratorProtocol {
    func next() -> Cell?
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
    
    private func item(at row: Int, item: Int) -> Cell? {
        currentItem+=1
        return engine.items.first(where: { $0?.position.row == row && $0?.position.item == item }) ?? nil
    }
    
    private func firstItem() -> Cell? {
        for item in engine.items {
            if item != nil {
                return item
            }
        }
        return nil
    }
    
    private func lastItem() -> Cell? {
        for item in engine.items.reversed() {
            if item != nil {
                return item
            }
        }
        return nil
    }
    
    func next() -> Cell? {
        if ((lastItem()?.position.row ?? 0) * 9).quotientAndRemainder(dividingBy: 9).quotient >= currentRow {
            if currentItem < 9 {
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
        self.currentRow = firstItem()?.position.row ?? 0
        self.currentItem = 0
    }
}
