//
//  TrendingViewController.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 06. 22..
//

import UIKit

final class TrendingViewController: DataLoadingViewController {

    enum SegmentedControl: Int, CaseIterable {
        case day
        case week

        var title: String {
            switch self {
            case .day:      return "Today"
            case .week:     return "This Week"
            }
        }
    }

    private let logic = TrendingLogicController()

    private lazy var dataSource = TrendingDataSource(collectionView: collectionView,
                                                 delegate: self,
                                                 provider: logic)

    private var segmentedControl: UISegmentedControl?

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
        var titles = [String]()
        SegmentedControl.allCases.forEach {
            titles.append($0.title)
        }

        segmentedControl = UISegmentedControl(items: titles)
        segmentedControl?.backgroundColor = .secondarySystemBackground
        segmentedControl?.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
        segmentedControl?.selectedSegmentIndex = 0
        navigationItem.titleView = segmentedControl

        navigationItem.title = "Trending"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
    }

    @objc
    private func segmentSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case SegmentedControl.day.rawValue:
            logic.time = .day
        case SegmentedControl.week.rawValue:
            logic.time = .week
        default:
            break
        }

        logic.load { [weak self] state in
            self?.render(state)
        }
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
