//
//  DetailViewController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

final class DetailViewController: DataLoadingViewController {
    
    private let logic = DetailLogicController()
    private lazy var dataSource = DetailDataSource(collectionView: collectionView)
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        render(.loading)
        
        logic.load { [weak self] state in
            self?.render(state)
        }
    }
    
    private func setupView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }

}

// MARK: - Render
private extension DetailViewController {
    private func render(_ state: MovieDetail.State) {
        switch state {
        case .loading:
            showLoadingView()
        case .presenting(let detail):
            hideLoadingView()
            
            dataSource.movie = detail
            DispatchQueue.main.async {
                self.navigationItem.title = detail.title
                self.collectionView.reloadData()
            }
        case .failed:
            hideLoadingView()
            
            print("Failed to load")
        }
    }
}
