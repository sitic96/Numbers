//
//  Cell.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/17/23.
//

import Foundation

struct Cell: Equatable {
    let id: UUID
    let number: Int
    var position: Position
    
    static func ==(lhs: Cell, rhs: Cell) -> Bool {
        return lhs.id == rhs.id
    }
}
