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

//    private lazy var dataSource = TrendingDataSource(collectionView: collectionView,
//                                                 delegate: self,
//                                                 provider: logic)

    private var segmentedControl: UISegmentedControl?
    
    private lazy var firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let vc1: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }()
    private let vc2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        return vc
    }()
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        vc.delegate = self
        vc.dataSource = self
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    var dataViewControllers: [UIViewController] {
        [self.vc1, self.vc2]
      }
      var currentPage: Int = 0 {
        didSet {
          // from segmentedControl -> pageViewController 업데이트
          print(oldValue, self.currentPage)
          let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
          self.pageViewController.setViewControllers(
            [dataViewControllers[self.currentPage]],
            direction: direction,
            animated: true,
            completion: nil
          )
        }
      }

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
        segmentedControl?.selectedSegmentTintColor = .label
        segmentedControl?.setTitleTextAttributes([.foregroundColor: UIColor.systemBackground], for: .selected)
        segmentedControl?.setTitleTextAttributes([.foregroundColor: UIColor.tertiaryLabel], for: .normal)
//        navigationItem.titleView = segmentedControl
        if let segmentedControl {
            view.addSubview(segmentedControl)
            segmentedControl.anchor(
                top: view.safeAreaLayoutGuide.topAnchor,
                leading: view.leadingAnchor,
                bottom: nil,
                trailing: view.trailingAnchor,
                padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
                size: CGSize(width: 0, height: 50)
            )
        }

        navigationItem.title = "Trending"
        navigationController?.navigationBar.prefersLargeTitles = false

//        setupCollectionView()
//        view.addSubview(pageViewController.view)
        add(pageViewController)
        pageViewController.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor
            , leading: view.leadingAnchor
            , bottom: view.safeAreaLayoutGuide.bottomAnchor
            , trailing: view.trailingAnchor
            , padding: UIEdgeInsets(top: 65, left: 16, bottom: 0, right: 16)
        )
    }

    private func setupCollectionView() {
//        collectionView.delegate = dataSource
//        collectionView.dataSource = dataSource
    }

    @objc private func segmentSelected(_ sender: UISegmentedControl) {
        self.currentPage = sender.selectedSegmentIndex
//        switch sender.selectedSegmentIndex {
//        case SegmentedControl.day.rawValue:
//            logic.time = .day
//        case SegmentedControl.week.rawValue:
//            logic.time = .week
//        default:
//            break
//        }
//
//        logic.load { [weak self] state in
//            self?.render(state)
//        }
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

//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
        case .failed:
            hideLoadingView()
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

// MARK: - UIPageViewControllerDelegate
extension TrendingViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard
            let viewController = pageViewController.viewControllers?[0],
            let index = self.dataViewControllers.firstIndex(of: viewController)
        else { return }
        self.currentPage = index
        self.segmentedControl?.selectedSegmentIndex = index
    }
}

// MARK: - UIPageViewControllerDataSource
extension TrendingViewController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let index = self.dataViewControllers.firstIndex(of: viewController),
            index - 1 >= 0
        else { return nil }
        return self.dataViewControllers[index - 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard
            let index = self.dataViewControllers.firstIndex(of: viewController),
            index + 1 < self.dataViewControllers.count
        else { return nil }
        return self.dataViewControllers[index + 1]
    }
}
