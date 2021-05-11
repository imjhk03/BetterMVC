//
//  ListDataSource.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import UIKit

protocol ListDataSourceDelegate: AnyObject {
    func moveToDetail(_ movieID: Int)
}

protocol ListDataSourceDataProvider: AnyObject {
    func item(for section: ListDataSource.Section) -> ListDataSource.Item
}

class ListDataSource: NSObject {
    
    enum Section: Int, CaseIterable {
        case popular
        case trending
    }
    
    struct Item {
        let movies: [Movie]
        
        init(movies: [Movie] = []) {
            self.movies = movies
        }
    }
    
    weak var delegate: ListDataSourceDelegate?
    weak var provider: ListDataSourceDataProvider?
    
    init(collectionView: UICollectionView, delegate: ListDataSourceDelegate?, provider: ListDataSourceDataProvider?) {
        self.delegate = delegate
        self.provider = provider
        
        let nib = UINib(nibName: "ListCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ListCollectionViewCell")
    }
    
}

// MARK: - UICollectionViewDataSource
extension ListDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section(rawValue: section)
        switch section {
        case .popular:
            return provider?.item(for: .popular).movies.count ?? 0
        case .trending:
            return provider?.item(for: .trending).movies.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section(rawValue: indexPath.section)
        switch section {
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell,
                  let movies = provider?.item(for: .popular).movies else {
                fatalError("Failed to dequeue ListCollectionViewCell")
            }
            cell.configure(.init(movie: movies[indexPath.item]))
            return cell
        case .trending:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell,
                  let movies = provider?.item(for: .trending).movies else {
                fatalError("Failed to dequeue ListCollectionViewCell")
            }
            cell.configure(.init(movie: movies[indexPath.item]))
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell else {
                fatalError("Failed to dequeue ListCollectionViewCell")
            }
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ListDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Section(rawValue: indexPath.section)
        var movies = [Movie]()
        switch section {
        case .popular:
            movies = provider?.item(for: .popular).movies ?? []
        case .trending:
            movies = provider?.item(for: .trending).movies ?? []
        default: return
        }
        let movieID = movies[indexPath.item].id
        delegate?.moveToDetail(movieID)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListDataSource: UICollectionViewDelegateFlowLayout {
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
