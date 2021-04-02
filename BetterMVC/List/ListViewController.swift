//
//  ListViewController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import UIKit

enum ViewState<ProductList> {
    case loading
    case presenting(ProductList)
    case failed
}

final class ListViewController: UIViewController {
    
    private let logic = ListLogicController()
    
    private lazy var dataSource = ListDataSource(collectionView: collectionView)
    
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        logic.load { [weak self] state in
            self?.render(state)
        }
    }

    private func setupView() {
        navigationItem.title = "목록"
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
    }

}

private extension ListViewController {
    private func render(_ state: ViewState<ProductList>) {
        switch state {
        case .loading:
            break
        case .presenting(let list):
            break
        case .failed:
            break
        }
    }
}
