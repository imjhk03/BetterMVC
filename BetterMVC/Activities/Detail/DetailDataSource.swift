//
//  DetailDataSource.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

final class DetailDataSource: NSObject {
    
    var movie: MovieDetail?
    
    init(collectionView: UICollectionView) {
        let nib = UINib(nibName: "DetailTopInfoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "DetailTopInfoCollectionViewCell")
    }
    
}

// MARK: - UICollectionViewDataSource
extension DetailDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailTopInfoCollectionViewCell", for: indexPath) as? DetailTopInfoCollectionViewCell else {
            fatalError("Failed to dequeue DetailTopInfoCollectionViewCell")
        }
        guard let movieDetail = movie else { return cell }
        cell.configure(.init(movie: movieDetail))
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DetailDataSource: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.size.width, height: 700)
    }
}
