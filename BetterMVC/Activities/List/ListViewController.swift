//
//  ListViewController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import UIKit

final class ListViewController: DataLoadingViewController {

    private let logic = ListLogicController()

    private lazy var dataSource = ListDataSource(collectionView: collectionView,
                                                 delegate: self,
                                                 provider: logic)

    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        render(.loading)

        logic.loadPopular { [weak self] state in
            self?.render(state)
        }
    }

    private func setupView() {
        navigationItem.title = "영화"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
    }

}

// MARK: - Render
private extension ListViewController {
    private func render(_ state: ViewState<[Movie]>) {
        switch state {
        case .loading:
            showLoadingView()
        case .presenting:
            hideLoadingView()

            DispatchQueue.main.async {
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        case .failed:
            hideLoadingView()

            DispatchQueue.main.async {
                self.collectionView.isHidden = true
                self.showEmptyStateView(with: "Something went wrong. Try again.", in: self.view)
            }
        }
    }
}

// MARK: - ListDataSourceDelegate
extension ListViewController: ListDataSourceDelegate {
    func moveToDetail(_ movieID: Int) {
        let detailVC = DetailViewController.initialize(with: movieID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
