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
    func start(with mode: EngineMode, randomizer: RandomizerProtocol)
    
    func didSelect(cell: Cell)
}

final class Engine {
    static let shared: EngineProtocol = Engine()
    
    var items = [Cell?]()
    var randomizer: RandomizerProtocol!
    
    private init() { }
}

// MARK: - EngineProtocol

extension Engine: EngineProtocol {
    var itemsCount: Int {
        items.count
    }
    
    func start(with mode: EngineMode, randomizer: RandomizerProtocol) {
        self.randomizer = randomizer
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
        
    }
}
