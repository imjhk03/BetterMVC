//
//  ListViewController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import UIKit

enum ViewState<Movie> {
    case loading
    case presenting([Movie])
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

// MARK: - Render
private extension ListViewController {
    private func render(_ state: ViewState<Movie>) {
        switch state {
        case .loading:
            break
        case .presenting(let list):
            dataSource.movies = list
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .failed:
            print("Failed to load")
        }
    }
}
