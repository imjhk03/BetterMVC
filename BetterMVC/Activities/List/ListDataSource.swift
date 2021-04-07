//
//  ListDataSource.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import UIKit

final class ListDataSource: NSObject {
    
    var movies: [Movie] = []
    
    init(collectionView: UICollectionView) {
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
