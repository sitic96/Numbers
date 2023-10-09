//
//  Engine.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/7/23.
//

import Foundation

enum EngineMode {
    case classic
    case random(RandomizerProtocol)
}

protocol EngineProtocol {
    var items: [Cell?] { get set }
    var itemsCount: Int { get }
    var selectedCell: Cell? { get }
    
    func start(with mode: EngineMode, randomizer: RandomizerProtocol)
    func didSelect(cell: Cell)
}

final class Engine {
    static let shared: EngineProtocol = Engine()
    
    var items = [Cell?]()
    var randomizer: RandomizerProtocol!
    
    private(set) var selectedCell: Cell?
    
    private init() { }
    
    private func reset() {
        items = []
        selectedCell = nil
    }
    
    private func canBeRemoved(_ cell: Cell) -> Bool {
        guard let selectedCell,
              selectedCell.number == cell.number else {
            return false
        }
        
        if isTop(cell, to: selectedCell) || isBelow(cell, to: selectedCell)
            || isNext(cell, to: selectedCell) || isPrev(cell, to: selectedCell) {
            return true
        }
        return false
    }
    
    private func remove(_ firstCell: Cell, _ secondCell: Cell) {
        selectedCell = nil
        guard let firstIndex = items.firstIndex(of: firstCell),
              let secondIndex = items.firstIndex(of: secondCell) else {
            return
        }
        items[firstIndex] = nil
        items[secondIndex] = nil
    }
    
    private func isTop(_ cell: Cell, to selectedCell: Cell) -> Bool {
        if cell.position.item == selectedCell.position.item {
            var currentRow = selectedCell.position.row - 1
            
            while currentRow > 0 {
                if let newCell = items.first(where: { $0?.position.item == cell.position.item && $0?.position.row == currentRow }),
                   let newCell {
                    if newCell.position == cell.position {
                        return true
                    }
                    return false
                }
                currentRow-=1
            }
        }
        return false
    }
    
    private func isBelow(_ cell: Cell, to selectedCell: Cell) -> Bool {
        if cell.position.item == selectedCell.position.item {
            var currentRow = selectedCell.position.row + 1
            guard let maxRow = items.last??.position.row else { return false }
            
            while currentRow <= maxRow {
                if let newCell = items.first(where: { $0?.position.item == cell.position.item && $0?.position.row == currentRow }),
                   let newCell {
                    if newCell.position == cell.position {
                        return true
                    }
                    return false
                }
                currentRow+=1
            }
        }
        return false
    }
    
    private func isNext(_ cell: Cell, to selectedCell: Cell) -> Bool {
        let nextCell = items
            .compactMap { $0 }
            .first(where: { $0.position.row > selectedCell.position.row || $0.position.item > selectedCell.position.item })
        
        return nextCell?.position == cell.position
    }
    
    private func isPrev(_ cell: Cell, to selectedCell: Cell) -> Bool {
        let nextCell = items
            .compactMap { $0 }
            .first(where: { $0.position.row < selectedCell.position.row || $0.position.item < selectedCell.position.item })
        
        return nextCell?.position == cell.position
    }
}

// MARK: - EngineProtocol

extension Engine: EngineProtocol {
    var itemsCount: Int {
        items.count
    }
    
    func start(with mode: EngineMode, randomizer: RandomizerProtocol) {
        self.randomizer = randomizer
        reset()
        
        switch mode {
        case .classic:
            items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8]
                .enumerated()
                .map {
                    Cell(number: $1, position: Position(row: $0.quotientAndRemainder(dividingBy: 9).quotient,
                                                        item: $0 % 9))
                }
        case .random(let randomizer):
            self.randomizer = randomizer
            items = randomizer.randomItems(count: 25)
        }
    }
    
    func didSelect(cell: Cell) {
        if let selectedCell {
            if selectedCell == cell {
                self.selectedCell = nil
            } else if canBeRemoved(cell) {
                remove(cell, selectedCell)
            } else {
                self.selectedCell = cell
            }
        } else {
            selectedCell = cell
        }
    }
}
