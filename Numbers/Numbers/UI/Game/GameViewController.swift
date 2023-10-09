//
//  ViewController.swift
//  Numbers
//
//  Created by Sitora Guliamova on 8/7/23.
//

import UIKit

final class GameViewController: UIViewController {
    @IBOutlet private weak var numbersCollectionView: UICollectionView!
    
    var engine: EngineProtocol!
    var engineIterator: EngineIteratorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        start()
    }
    
    private func setUp() {
        
    }
    
    private func start() {
        engineIterator.reset()
        engine.start(with: .classic, randomizer: Randomizer())
        numbersCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        engine.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCell", for: indexPath) as? NumberCell else {
            return UICollectionViewCell()
        }
        
        let item = engineIterator.next()
        cell.setUp(for: .init(item: item,
                              isSelected: engine.selectedCell == item &&
                              engine.selectedCell != nil ))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NumberCell,
              let item = cell.viewModel?.item else {
            return
        }
        engine.didSelect(cell: item)
        engineIterator.reset()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/9, height: collectionView.frame.width/9)
    }
}
