//
//  FavoritesDataSource.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 08..
//

import UIKit

protocol FavoritesDataSourceDelegate: AnyObject {
    func moveToDetail(_ movieID: Int)
}

protocol FavoritesDataSourceDataProvider: AnyObject {
    func item(for section: FavoritesDataSource.Section) -> FavoritesDataSource.Item
}

final class FavoritesDataSource: NSObject {
    enum Section: Int, CaseIterable {
        case main
    }

    struct Item {
        let movies: [Movie]

        init(movies: [Movie] = []) {
            self.movies = movies
        }
    }

    weak var delegate: FavoritesDataSourceDelegate?
    weak var provider: FavoritesDataSourceDataProvider?

    init(collectionView: UICollectionView, delegate: FavoritesDataSourceDelegate?, provider: FavoritesDataSourceDataProvider?) {
        self.delegate = delegate
        self.provider = provider

//        let nib = UINib(nibName: "ListCollectionViewCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: "ListCollectionViewCell")
        
        collectionView.registerCell(ListCollectionViewCell.self)
//        collectionView.register(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)
    }

}

// MARK: - UICollectionViewDataSource
extension FavoritesDataSource: UICollectionViewDataSource {
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
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell,
//                  let movies = provider?.item(for: .main).movies else {
//                fatalError("Failed to dequeue ListCollectionViewCell")
//            }
            if let movies = provider?.item(for: .main).movies {
                cell.configure(.init(movie: movies[indexPath.item]))
            }
            return cell
        default:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell else {
//                fatalError("Failed to dequeue ListCollectionViewCell")
//            }
            return cell
        }
    }

}

// MARK: - UICollectionViewDelegate
extension FavoritesDataSource: UICollectionViewDelegate {
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
extension FavoritesDataSource: UICollectionViewDelegateFlowLayout {
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
