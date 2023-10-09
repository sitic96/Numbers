//
//  EngineTests.swift
//  NumbersTests
//
//  Created by Sitora Guliamova on 8/7/23.
//

import XCTest
import Mockingbird
@testable import Numbers

final class EngineTests: XCTestCase {

    private var engine: EngineProtocol!
    private var randomizer: RandomizerProtocol!
    
    override func setUp() {
        super.setUp()
        engine = Engine.shared
    }
    
    // MARK: Tests
    
    func test_engine_removalNextItems() {
        // given
        engine.start(with: .classic,
                     randomizer: mock(RandomizerProtocol.self))
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 0)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        
        //expect
        XCTAssertNil(engine.items[9])
        XCTAssertNil(engine.items[10])
    }
    
    func test_engine_removalPrevItems() {
        // given
        engine.start(with: .classic,
                     randomizer: mock(RandomizerProtocol.self))
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 0)))
        
        //expect
        XCTAssertNil(engine.items[9])
        XCTAssertNil(engine.items[10])
    }
    
    func test_engine_removalBelowItems() {
        // given
        engine.start(with: .classic,
                     randomizer: mock(RandomizerProtocol.self))
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 2, item: 1)))
        
        //expect
        XCTAssertNil(engine.items[10])
        XCTAssertNil(engine.items[19])
    }
    
    func test_engine_removalAboveItems() {
        // given
        engine.start(with: .classic,
                     randomizer: mock(RandomizerProtocol.self))
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 2, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        
        //expect
        XCTAssertNil(engine.items[10])
        XCTAssertNil(engine.items[19])
    }
}
