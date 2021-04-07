//
//  ListDataSource.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import UIKit

protocol ListDataSourceDelegate: AnyObject {
    func moveToDetail()
}

final class ListDataSource: NSObject {
    
    var movies: [Movie] = []
    weak var delegate: ListDataSourceDelegate?
    
    init(collectionView: UICollectionView, delegate: ListDataSourceDelegate?) {
        self.delegate = delegate
        
        let nib = UINib(nibName: "ListCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ListCollectionViewCell")
    }
    
}

// MARK: - UICollectionViewDataSource
extension ListDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell else {
            fatalError("Failed to dequeue ListCollectionViewCell")
        }
        cell.configure(.init(movie: movies[indexPath.item]))
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ListDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.moveToDetail()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - (16 * 2) - 8) / 2
        return .init(width: width, height: 300)
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
