//
//  NumberCell.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/7/23.
//

import UIKit

protocol NumberCellProtocol {
    var viewModel: NumberCellModel? { get }
    
    func setUp(for viewModel: NumberCellModel)
}

final class NumberCell: UICollectionViewCell {
    @IBOutlet private var numberImageView: UIImageView!
    @IBOutlet private var overlayImageView: UIImageView!
    
    var viewModel: NumberCellModel?
    
    // MARK: - Override
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewModel = nil
    }
    
    // MARK: - Private
    
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
    func setUp(for viewModel: NumberCellModel) {
        self.viewModel = viewModel
        
        if let cell = viewModel.item {
            numberImageView.image = imageForNumber(cell.number)
            overlayImageView.isHidden = !viewModel.isSelected
        } else {
            numberImageView.image = nil
            overlayImageView.isHidden = true
        }
    }
}
