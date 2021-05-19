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
    private var impressionEventStalker: ListingImpression?
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            impressionEventStalker = ListingImpression(minimumPercentageOfCell: 0.75, collectionView: collectionView, delegate: self)
            dataSource.impressionEventStalker = impressionEventStalker
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        render(.loading)
        
        logic.load { [weak self] state in
            self?.render(state)
        }
        
        logic.loadPopular { [weak self] state in
            self?.render(state)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        impressionEventStalker?.stalkCells()
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
    func moveToDetail(_ movieID: Int) {
        let detailVC = DetailViewController.initialize(with: movieID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - ListingImpressionDelegate
extension ListViewController: ListingImpressionDelegate {
    func sendEventForCell(at indexPath: IndexPath) {
        print("Event can be sent for indexPath: \(indexPath)")
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ListCollectionViewCell else { return }
        cell.badge.isHidden = false
        cell.badge.backgroundColor = .systemGreen
        dataSource.indexPathsOfCellsTurnedGreen.append(indexPath)
    }
}
