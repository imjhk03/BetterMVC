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
    private var modelController: MovieDetailModelController?
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
        navigationController?.navigationBar.prefersLargeTitles = false
        
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
            modelController = MovieDetailModelController(movieDetail: detail)
            
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
    func buttonTapped(_ actionType: PersistenceActionType) {
        guard let detail = dataSource.movie else { return }
        PersistenceManager.updateWith(favorite: detail, actionType: actionType) { [weak self] error in
            guard let error = error else {
                self?.showHUDView(actionType == .add ? "저장했습니다!" : "저장함에 지웠습니다!")
                self?.render(.presenting(detail))
                return
            }
            
            print(error)
        }
    }
}
