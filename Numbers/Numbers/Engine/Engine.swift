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
    var items: [[Int?]] { get set }
    var itemsCount: Int { get }
    func start(with mode: EngineMode)
}

final class Engine {
    static let shared: EngineProtocol = Engine()
    
    var items = [[Int?]]()
    private var randomizer: RandomizerProtocol
    
    private init() {
        randomizer = Randomizer()
    }
}

// MARK: - EngineProtocol

extension Engine: EngineProtocol {
    var itemsCount: Int {
        items.flatMap { $0 }.count
    }
    func start(with mode: EngineMode) {
        switch mode {
        case .classic:
            items = [[1, 2, 3, 4, 5, 6, 7, 8, 9],
                     [1, 1, 1, 2, 1, 3, 1, 4, 1],
                     [5, 1, 6, 1, 7, 1, 8]]
        case .random(let randomizer):
            self.randomizer = randomizer
            items = [randomizer.randomNumbers(count: 9),
                     randomizer.randomNumbers(count: 9),
                     randomizer.randomNumbers(count: 7)]
        }
    }
}
