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
        
        // when
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 0)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        
        // then
        XCTAssertNil(engine.items[9])
        XCTAssertNil(engine.items[10])
    }
    
    func test_engine_removalPrevItems() {
        // given
        engine.start(with: .classic)
        
        // when
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 0)))
        
        // then
        XCTAssertNil(engine.items[9])
        XCTAssertNil(engine.items[10])
    }
    
    func test_engine_removalBelowItems() {
        // given
        engine.start(with: .classic)
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 2, item: 1)))
        
        // then
        XCTAssertNil(engine.items[10])
        XCTAssertNil(engine.items[19])
    }
    
    func test_engine_removalAboveItems() {
        // given
        engine.start(with: .classic)
        
        // test
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 2, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        
        // then
        XCTAssertNil(engine.items[10])
        XCTAssertNil(engine.items[19])
    }
    
    func test_engine_removalWithEmptyCellsBetween() {
        // given
        engine.start(with: .classic)
        
        // when
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 0)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        engine.didSelect(cell: Cell(number: 9, position: .init(row: 0, item: 8)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 2)))
        
        // then
        XCTAssertNil(engine.items[8])
        XCTAssertNil(engine.items[9])
        XCTAssertNil(engine.items[10])
        XCTAssertNil(engine.items[11])
    }
                                          
    // MARK: Tests selected item is first/last
    
    func test_engine_whenSelectedFirstAndSecondNotPair() {
        // given
        engine.start(with: .classic)
        
        // when
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 0)))
        engine.didSelect(cell: Cell(number: 2, position: .init(row: 0, item: 1)))
        
        // then
        XCTAssertNotNil(engine.items[0])
        XCTAssertNotNil(engine.items[1])
    }
    
    func test_engine_whenSelectedSecondAndFirst() {
        // given
        engine.start(with: .classic)
        
        // when
        engine.didSelect(cell: Cell(number: 2, position: .init(row: 0, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 0)))
        
        // then
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
        
        
        // when
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 0)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 1)))
        
        // then
        XCTAssertNil(engine.items[0])
        XCTAssertNil(engine.items[1])
        XCTAssertNotNil(engine.items[2])
    }
    
    // MARK: Selected cell
    
    func test_selectedCell() {
        // given
        engine.start(with: .classic)
        
        // when
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 0)))
        
        // then
        XCTAssertEqual(engine.selectedCell!.number, 1)
        XCTAssertEqual(engine.selectedCell!.position.row, 0)
        XCTAssertEqual(engine.selectedCell!.position.item, 0)
    }
    
    func test_unselectedCell() {
        // given
        engine.start(with: .classic)
        
        // when
        engine.didSelect(cell: Cell(number: 3, position: .init(row: 0, item: 2)))
        
        // then
        XCTAssertEqual(engine.selectedCell!.number, 3)
        XCTAssertEqual(engine.selectedCell!.position.row, 0)
        XCTAssertEqual(engine.selectedCell!.position.item, 2)
        
        // when
        engine.didSelect(cell: Cell(number: 3, position: .init(row: 0, item: 2)))
        
        // then
        XCTAssertNil(engine.selectedCell)
    }
    
    
    func testSelectedCell_whenCellRemoved() {
        // given
        engine.start(with: .classic)
        
        // when
        engine.didSelect(cell: Cell(number: 9, position: .init(row: 0, item: 8)))
        
        // then
        XCTAssertEqual(engine.selectedCell!.number, 9)
        XCTAssertEqual(engine.selectedCell!.position.row, 0)
        XCTAssertEqual(engine.selectedCell!.position.item, 8)
        
        // when
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 8)))
        
        // then
        XCTAssertNil(engine.selectedCell)
    }
    
    //MARK: - Remove line
    
    func test_removeLine() {
        // given
        let cells = [Cell(number: 1, position: .init(row: 0, item: 0)),
                     Cell(number: 1, position: .init(row: 0, item: 1)),
                     Cell(number: 1, position: .init(row: 0, item: 2)),
                     Cell(number: 1, position: .init(row: 0, item: 3)),
                     Cell(number: 1, position: .init(row: 0, item: 4)),
                     Cell(number: 1, position: .init(row: 0, item: 5)),
                     Cell(number: 1, position: .init(row: 0, item: 6)),
                     Cell(number: 1, position: .init(row: 0, item: 7)),
                     Cell(number: 1, position: .init(row: 0, item: 8)),
                     Cell(number: 1, position: .init(row: 1, item: 0)),
                     Cell(number: 1, position: .init(row: 1, item: 1)),
                     Cell(number: 1, position: .init(row: 1, item: 2)),
                     Cell(number: 1, position: .init(row: 1, item: 3)),
                     Cell(number: 1, position: .init(row: 1, item: 4)),
                     Cell(number: 1, position: .init(row: 1, item: 5)),
                     Cell(number: 1, position: .init(row: 1, item: 6)),
                     Cell(number: 1, position: .init(row: 1, item: 7)),
                     Cell(number: 1, position: .init(row: 1, item: 8)),
                     Cell(number: 2, position: .init(row: 2, item: 0))]
        given(randomizer.randomItems(count: 25)).willReturn(cells)
        engine.start(with: .random(randomizer))
        
        // when
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 1)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 2)))
        
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 3)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 4)))
        
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 5)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 6)))
        
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 8)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 0)))
        
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 7)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 7)))
        
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 2)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 3)))
        
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 4)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 5)))
        
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 6)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 8)))
        
        
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 0, item: 0)))
        engine.didSelect(cell: Cell(number: 1, position: .init(row: 1, item: 1)))
        
        // then
        XCTAssertEqual(engine.items[0]!.number, 2)
    }
}
