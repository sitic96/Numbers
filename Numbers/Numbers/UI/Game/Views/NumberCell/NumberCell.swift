//
//  NumberCell.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/7/23.
//

import UIKit

protocol NumberCellProtocol {
    func setUp(for state: NumberCellState)
}

final class NumberCell: UICollectionViewCell {
    @IBOutlet private var numberImageView: UIImageView!
    @IBOutlet private var overlayImageView: UIImageView!
    
    private func imageForNumber(_ number: Int) -> UIImage? {
        switch number {
        case 1:
            return R.image.number1()
        case 2:
            return R.image.number2()
        case 3:
            return R.image.number3()
        case 4:
            return R.image.number4()
        case 5:
            return R.image.number5()
        case 6:
            return R.image.number6()
        case 7:
            return R.image.number7()
        case 8:
            return R.image.number8()
        case 9:
            return R.image.number9()
        default:
            return nil
        }
    }
}

// MARK: - NumberCellProtocol

extension NumberCell: NumberCellProtocol {
    func setUp(for state: NumberCellState) {
        switch state {
        case .empty:
            numberImageView.image = nil
            overlayImageView.isHidden = true
        case .next:
            numberImageView.image = R.image.next()
            overlayImageView.isHidden = true
        case .number(let viewModel):
            if let number = viewModel.number {
                numberImageView.image = imageForNumber(number)
            }
            overlayImageView.isHidden = !viewModel.isSelected
        }
    }
}
