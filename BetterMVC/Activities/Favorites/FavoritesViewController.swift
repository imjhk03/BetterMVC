//
//  FavoritesViewController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 08..
//

import UIKit

final class FavoritesViewController: DataLoadingViewController {
    
    private let logic = FavoritesLogicController()
    
    private lazy var dataSource = FavoritesDataSource(collectionView: collectionView,
                                                      delegate: self,
                                                      provider: logic)
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        logic.load { [weak self] state in
            self?.render(state)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        logic.load { [weak self] state in
            self?.render(state)
        }
    }

    private func setupView() {
        navigationItem.title = "저장됨"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
    }
    
}

// MARK: - Render
private extension FavoritesViewController {
    private func render(_ state: ViewState<[Movie]>) {
        switch state {
        case .loading:
            showLoadingView()
        case .presenting:
            hideLoadingView()
            
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
extension FavoritesViewController: FavoritesDataSourceDelegate {
    func moveToDetail(_ movieID: Int) {
        let detailVC = DetailViewController.initialize(with: movieID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
