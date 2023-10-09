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
    private var randomizer: RandomizerProtocolMock!
    
    override func setUp() {
        super.setUp()
        engine = Engine.shared
        randomizer = mock(RandomizerProtocol.self)
    }
    
    // MARK: Tests
    
    // MARK: Tests for the situation when items are next to each others
    
    func test_engine_removalNextItems() {
        // given
        engine.start(with: .classic)
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 0)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        
        //expect
        XCTAssertNil(engine.items[9])
        XCTAssertNil(engine.items[10])
    }
    
    func test_engine_removalPrevItems() {
        // given
        engine.start(with: .classic)
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 0)))
        
        //expect
        XCTAssertNil(engine.items[9])
        XCTAssertNil(engine.items[10])
    }
    
    func test_engine_removalBelowItems() {
        // given
        engine.start(with: .classic)
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 2, item: 1)))
        
        //expect
        XCTAssertNil(engine.items[10])
        XCTAssertNil(engine.items[19])
    }
    
    func test_engine_removalAboveItems() {
        // given
        engine.start(with: .classic)
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 2, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        
        //expect
        XCTAssertNil(engine.items[10])
        XCTAssertNil(engine.items[19])
    }
    
    // MARK: Tests selected item is first/last
    
    func test_engine_whenSelectedFirstAndSecond() {
        // given
        engine.start(with: .classic)
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 0)))
        engine.didSelect(cell: Cell(number: 2, position: .init(row: 0, item: 1)))
        
        //expect
        XCTAssertNotNil(engine.items[0])
        XCTAssertNotNil(engine.items[1])
    }
    
    func test_engine_whenSelectedSecondAndFirst() {
        // given
        engine.start(with: .classic)
        
        // test
        engine.didSelect(cell: Cell(number: 2, position: .init(row: 0, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 0)))
        
        //expect
        XCTAssertNotNil(engine.items[0])
        XCTAssertNotNil(engine.items[1])
    }
    
    func test_engine_whenFirstAndSecondShouldBeRemoved() {
        // given
        let cells = [Cell(number: 1, position: .init(row: 0, item: 0)),
                     Cell(number: 1, position: .init(row: 0, item: 1)),
                     Cell(number: 2, position: .init(row: 0, item: 6))]
        given(randomizer.randomItems(count: any())).willReturn(cells)
        randomizer.useDefaultValues(from: .standardProvider)
        engine.start(with: .random(randomizer))
        
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 0)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 1)))
        
        //expect
        XCTAssertNil(engine.items[0])
        XCTAssertNil(engine.items[1])
    }
    
}
