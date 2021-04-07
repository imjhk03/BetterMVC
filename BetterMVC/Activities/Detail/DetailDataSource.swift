//
//  DetailDataSource.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

final class DetailDataSource: NSObject {
    
    enum Section: Int, CaseIterable {
        case topInfo
        case overview
    }
    
    var movie: MovieDetail?
    
    init(collectionView: UICollectionView) {
        let nib = UINib(nibName: "DetailTopInfoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "DetailTopInfoCollectionViewCell")
        
        let overviewNib = UINib(nibName: "DetailOverviewCollectionViewCell", bundle: nil)
        collectionView.register(overviewNib, forCellWithReuseIdentifier: "DetailOverviewCollectionViewCell")
    }
    
}

// MARK: - UICollectionViewDataSource
extension DetailDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch Section(rawValue: indexPath.section) {
        case .topInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailTopInfoCollectionViewCell", for: indexPath) as? DetailTopInfoCollectionViewCell else {
                fatalError("Failed to dequeue DetailTopInfoCollectionViewCell")
            }
            guard let movieDetail = movie else { return cell }
            cell.configure(.init(movie: movieDetail))
            return cell
        case .overview:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailOverviewCollectionViewCell", for: indexPath) as? DetailOverviewCollectionViewCell else {
                fatalError("Failed to dequeue DetailOverviewCollectionViewCell")
            }
            guard let movieDetail = movie else { return cell }
            cell.configure(.init(movie: movieDetail))
            return cell
        case nil:
            return .init()
        }
        
    }
}

// MARK: - UICollectionViewDelegate
extension DetailDataSource: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        switch Section(rawValue: indexPath.section) {
        case .topInfo:
            return .init(width: width, height: width)
        case .overview:
            guard let movieDetail = movie else { return .zero }
            return DetailOverviewCollectionViewCell.fittingSize(availableWidth: width, movie: movieDetail)
        case nil:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
