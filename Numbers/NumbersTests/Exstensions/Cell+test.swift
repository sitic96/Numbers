//
//  Cell+test.swift
//  NumbersTests
//
//  Created by Sitora Guliamova on 4/14/24.
//

import Foundation
@testable import Numbers

extension Cell {
    init(number: Int, position: Position) {
        self.init(id: UUID(), number: number, position: position)
    }
}
