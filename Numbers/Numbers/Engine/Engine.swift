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
    case test
}

protocol EngineProtocol {
    var items: [Cell?] { get }
    var itemsCount: Int { get }
    var selectedCell: Cell? { get }
    
    func start(with mode: EngineMode)
    func didSelect(cell: Cell)
}

final class Engine {
    static let shared: EngineProtocol = Engine()
    
    var items = [Cell?]()
    
    private var randomizer: RandomizerProtocol!
    private(set) var selectedCell: Cell?
    
    private init() { }
    
    private func reset() {
        items = []
        selectedCell = nil
    }
    
    private func canBeRemoved(_ cell: Cell) -> Bool {
        guard let selectedCell,
              selectedCell.number == cell.number ||
                selectedCell.number + cell.number == 10 else {
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
        guard let firstIndex = items.firstIndex(of: firstCell) else {
            return
        }
        items[firstIndex] = nil
        checkLine(forCell: firstCell, atIndex: firstIndex)
        
        guard let secondIndex = items.firstIndex(of: secondCell),
        let secondItem = items[secondIndex] else {
            return
        }
        items[secondIndex] = nil
        checkLine(forCell: secondItem, atIndex: secondIndex)
    }
    
    private func checkLine(forCell cell: Cell, atIndex index: Int) {
        let itemsInFirstRow = items.filterWhile(condition: {
            $0?.position.row == cell.position.row
        }, stopWhen: {
            $0?.position.row ?? -1 > cell.position.row
        })
        
        let startRange = index.quotientAndRemainder(dividingBy: 9).quotient * 9
        if itemsInFirstRow.isEmpty {
            items.removeSubrange(startRange...min(startRange+8, itemsCount-1))
            recalculateLines(startingFrom: cell.position.row)
        }
    }
    
    private func recalculateLines(startingFrom removedLine: Int) {
        items.enumerated().forEach {
            if $1?.position.row ?? -1 >= removedLine {
                items[$0]?.position.row-=1
            }
        }
    }
    
    private func isTop(_ cell: Cell, to selectedCell: Cell) -> Bool {
        if cell.position.item == selectedCell.position.item {
            var currentRow = selectedCell.position.row - 1
            
            while currentRow >= 0 {
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
        let visibleItems = items.compactMap { $0 }
        
        guard let index = visibleItems.firstIndex(of: selectedCell),
              index < visibleItems.count-1 else {
            return false
        }
        return visibleItems[index+1].position == cell.position
    }
    
    private func isPrev(_ cell: Cell, to selectedCell: Cell) -> Bool {
        let visibleItems = items.compactMap { $0 }
        guard let index = visibleItems.firstIndex(of: selectedCell),
              index > 0 else {
            return false
        }
        
        return visibleItems[index-1].position == cell.position
    }
}

// MARK: - EngineProtocol

extension Engine: EngineProtocol {
    var itemsCount: Int {
        items.count
    }
    
    func start(with mode: EngineMode) {
        self.randomizer = nil
        reset()
        
        switch mode {
        case .classic:
            items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8]
                .enumerated()
                .map {
                    Cell(id: UUID(), number: $1, position: Position(row: $0.quotientAndRemainder(dividingBy: 9).quotient,
                                                        item: $0 % 9))
                }
        case .random(let randomizer):
            self.randomizer = randomizer
            items = randomizer.randomItems(count: 25)
        case .test:
            items = Array<Int>(repeating: 1, count: 25)
                .enumerated()
                .map {
                    Cell(id: UUID(), number: $1, position: Position(row: $0.quotientAndRemainder(dividingBy: 9).quotient,
                                                        item: $0 % 9))
                }
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
