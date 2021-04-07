//
//  ListViewController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import UIKit

final class ListViewController: DataLoadingViewController {
    
    private let logic = ListLogicController()
    
    private lazy var dataSource = ListDataSource(collectionView: collectionView, delegate: self)
    
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        render(.loading)
        
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
    private func render(_ state: MovieList.State) {
        switch state {
        case .loading:
            showLoadingView()
        case .presenting(let list):
            hideLoadingView()
            
            dataSource.movies = list
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .failed:
            hideLoadingView()
            
            print("Failed to load")
        }
    }
}

// MARK: - ListDataSourceDelegate
extension ListViewController: ListDataSourceDelegate {
    func moveToDetail() {
        let detailVC = DetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
