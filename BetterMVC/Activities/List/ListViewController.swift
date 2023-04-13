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

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            let customLayout = SearchResultCustomFlowLayout()
            collectionView.collectionViewLayout = customLayout
        }
    }

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
//        navigationController?.navigationBar.prefersLargeTitles = true
        let rightBarButtonItem = UIBarButtonItem(title: "더하기", style: .plain, target: self, action: #selector(editTapped))
        rightBarButtonItem.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(title: "빼기", style: .plain, target: self, action: #selector(minusTapped))
        leftBarButtonItem.tintColor = .systemGreen
        navigationItem.leftBarButtonItem = leftBarButtonItem

        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
    }
    
    @objc private func editTapped() {
        let movie = Movie(adult: false, genre_ids: [0], id: 123, original_title: "Original Title", popularity: 5.0, release_date: "2023-04-04", title: "Title", video: false, vote_average: 4.5, vote_count: 4)
        logic.appendMovie(movie, at: 2)
        collectionView.insertItems(at: [IndexPath(item: 2, section: 0)])
    }
    
    @objc private func minusTapped() {
        
        
        collectionView.performBatchUpdates {
            logic.removeMovie(at: 2)
            collectionView.deleteItems(at: [IndexPath(item: 2, section: 0)])
            
            let movie = Movie(adult: false, genre_ids: [0], id: 123, original_title: "Original Title", popularity: 5.0, release_date: "2023-04-04", title: "Title", video: false, vote_average: 4.5, vote_count: 4)
            logic.appendMovie(movie, at: 4)
            collectionView.insertItems(at: [IndexPath(item: 4, section: 0)])
        }
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
//        let detailVC = DetailViewController.initialize(with: movieID)
//        navigationController?.pushViewController(detailVC, animated: true)
    }
}

final class SearchResultCustomFlowLayout: UICollectionViewFlowLayout {
    
    private var deletingIndexPaths = [IndexPath]()
    private var insertingIndexPaths = [IndexPath]()
    
    // cell의 레이아웃 업데이트
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare()
        
        for update in updateItems {
            switch update.updateAction {
            case .delete:
                /// indexPath에 해당하는 item이 삭제되기 전에 deletingIndexPaths에 삽입
                guard let indexPath = update.indexPathBeforeUpdate else { return }
                deletingIndexPaths.append(indexPath)
            case .insert:
                /// indexPath에 해당하는 item이 추가된 다음 insertingIndexPaths에 삽입
                guard let indexPath = update.indexPathAfterUpdate else { return }
                insertingIndexPaths.append(indexPath)
            default:
                break
            }
        }
    }
    
    // 삽입 시 적용 애니메이션
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else { return nil }

        if insertingIndexPaths.contains(itemIndexPath) {
            attributes.alpha = 1.0
            attributes.zIndex = 0
            attributes.frame.size = CGSize(width: collectionView?.frame.size.width ?? 0, height: 0)
            print("@@@@@ ::::: \(#function), itemIndexPath \(itemIndexPath)")
        }

        /// nil반환 시 애니메이션의 start point와 end point 모두 동일한 attributes 사용
        return attributes
    }
    
    // 삭제 시 적용 애니메이션
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else { return nil }
        
        if deletingIndexPaths.contains(itemIndexPath) {
//            if let _ = collectionView?.cellForItem(at: itemIndexPath) as? SearchResultSimilarContainerCell {
                attributes.alpha = 1.0
                attributes.zIndex = 0
            attributes.frame.size = CGSize(width: collectionView?.frame.size.width ?? 0, height: 0)
            print("@@@@@ ::::: \(#function), itemIndexPath \(itemIndexPath)")
//                attributes.frame.size = CGSize(width: availableNudgeWidth, height: 0)
//            } else if let _ = collectionView?.cellForItem(at: itemIndexPath) as? BookmarkFolderNudgeCollectionViewCell {
//                attributes.alpha = 1.0
//                attributes.zIndex = 0
//                attributes.frame.size = CGSize(width: availableFolderWidth, height: 0)
//            }
        }
        
        // nil반환 시 애니메이션의 start point와 end point 모두 동일한 attributes 사용
        return attributes
    }
    
    // performBatchUpdates(:completion)호출에서 compeltion이 시작되기 바로 직전에 호출
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()

        insertingIndexPaths.removeAll()
        deletingIndexPaths.removeAll()
    }
    
}
