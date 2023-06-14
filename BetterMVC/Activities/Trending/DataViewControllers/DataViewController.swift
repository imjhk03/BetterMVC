//
//  DataViewController.swift
//  BetterMVC
//
//  Created by Joohee Kim on 2023/06/14.
//

import UIKit

final class DataViewController: DataLoadingViewController {
    
    private let logic = TrendingLogicController()

    private lazy var dataSource = TrendingDataSource(collectionView: collectionView,
                                                 delegate: self,
                                                 provider: logic)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        collectionView.anchorFillToSuperView()
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        logic.load { [weak self] state in
            self?.render(state)
        }
    }
    
    func configure(color: UIColor, time: Time) {
        collectionView.backgroundColor = color
        logic.time = time
    }
    
}

private extension DataViewController {
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
        }
    }
}

// MARK: - TrendingDataSourceDelegate
extension DataViewController: TrendingDataSourceDelegate {
    func moveToDetail(_ movieID: Int) {
        //
    }
    
}
