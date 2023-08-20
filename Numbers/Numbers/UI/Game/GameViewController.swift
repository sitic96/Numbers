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

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        engine.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCell", for: indexPath) as? NumberCell else {
            return UICollectionViewCell()
        }
        
        cell.setUp(for: .number(.init(item: engineIterator.next(),
                                      isSelected: false)))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/9, height: collectionView.frame.width/9)
    }
}
