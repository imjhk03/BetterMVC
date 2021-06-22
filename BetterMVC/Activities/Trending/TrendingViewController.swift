//
//  TrendingViewController.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 06. 22..
//

import UIKit

final class TrendingViewController: DataLoadingViewController {
    
    private let logic = TrendingLogicController()
    
    private lazy var dataSource = TrendingDataSource(collectionView: collectionView,
                                                 delegate: self,
                                                 provider: logic)
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        render(.loading)
        
        logic.load { [weak self] state in
            self?.render(state)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupView() {
        navigationItem.title = "Trending"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
    }

}

// MARK: - Render
private extension TrendingViewController {
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
extension TrendingViewController: TrendingDataSourceDelegate {
    func moveToDetail(_ movieID: Int) {
        let detailVC = DetailViewController.initialize(with: movieID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
