//
//  DetailViewController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

final class DetailViewController: DataLoadingViewController {
    
    static func initialize(with movieID: Int) -> DetailViewController {
        let vc = DetailViewController()
        vc.logic.movieID = String(movieID)
        return vc
    }
    
    private let logic = DetailLogicController()
    private lazy var dataSource = DetailDataSource(collectionView: collectionView, delegates: self)
    
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
    private func render(_ state: ViewState<MovieDetail>) {
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

// MARK: - DetailTopInfoCollectionViewCellDelegate
extension DetailViewController: DetailTopInfoCollectionViewCellDelegate {
    func buttonTapped() {
        dataSource.movie?.isFavorite.toggle()
        guard let detail = dataSource.movie else { return }
        render(.presenting(detail))
    }
}
