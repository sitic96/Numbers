//
//  NumberCellViewModel.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/7/23.
//

import Foundation

enum NumberCellState {
    case empty
    case next
    case number(NumberCellViewModel)
}

struct NumberCellViewModel {
    let item: Cell?
    let isSelected: Bool
}
