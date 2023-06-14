//
//  TrendingDataSource.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 06. 22..
//

import UIKit

protocol TrendingDataSourceDelegate: AnyObject {
    func moveToDetail(_ movieID: Int)
}

protocol TrendingDataSourceDataProvider: AnyObject {
    func item(for section: TrendingDataSource.Section) -> TrendingDataSource.Item
}

final class TrendingDataSource: NSObject {

    enum Section: Int, CaseIterable {
        case main
    }

    struct Item {
        let movies: [Movie]

        init(movies: [Movie] = []) {
            self.movies = movies
        }
    }

    weak var delegate: TrendingDataSourceDelegate?
    weak var provider: TrendingDataSourceDataProvider?

    init(collectionView: UICollectionView, delegate: TrendingDataSourceDelegate?, provider: TrendingDataSourceDataProvider?) {
        self.delegate = delegate
        self.provider = provider
        
        collectionView.registerCell(ListCollectionViewCell.self)
    }

}

// MARK: - UICollectionViewDataSource
extension TrendingDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section(rawValue: section)
        switch section {
        case .main:
            return provider?.item(for: .main).movies.count ?? 0
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section(rawValue: indexPath.section)
        let cell: ListCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        switch section {
        case .main:
            if let movies = provider?.item(for: .main).movies {
                cell.configure(.init(movie: movies[indexPath.item]))
            }
            return cell
        default:
            return cell
        }
    }

}

// MARK: - UICollectionViewDelegate
extension TrendingDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Section(rawValue: indexPath.section)
        var movies = [Movie]()
        switch section {
        case .main:
            movies = provider?.item(for: .main).movies ?? []
        default:
            return
        }
        let movieID = movies[indexPath.item].id
        delegate?.moveToDetail(movieID)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TrendingDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - (16 * 2) - 8) / 2
        return .init(width: width, height: 325)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }

}
