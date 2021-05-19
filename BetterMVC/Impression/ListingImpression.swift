//
//  ListingImpression.swift
//  BetterMVC
//
//  Created by Joohee Kim on 21. 05. 20..
//

import UIKit

protocol ListingImpressionItem {
    func getUniqueId() -> String
}

protocol ListingImpressionDelegate: NSObjectProtocol {
    func sendEventForCell(at indexPath: IndexPath)
}

final class ListingImpression {
    
    let minPercentageOfCell: CGFloat
    weak var collectionView: UICollectionView?
    
    private let minimumPercentageOfCellDefaultValue = CGFloat(0.5)
    private let minimumPercentageMinValue = CGFloat.leastNonzeroMagnitude
    private let minimumPercentageMaxValue = CGFloat(1.0)
    
    private var alreadySentIdentifiers = [String]()
    weak var delegate: ListingImpressionDelegate?
    
    // MARK: - Initializers
    init(minimumPercentageOfCell: CGFloat, collectionView: UICollectionView, delegate: ListingImpressionDelegate?) {
        
        if minimumPercentageOfCell < minimumPercentageMinValue {
            self.minPercentageOfCell = minimumPercentageOfCellDefaultValue
        } else if minimumPercentageOfCell > minimumPercentageMaxValue {
            self.minPercentageOfCell = minimumPercentageOfCellDefaultValue
        } else {
            self.minPercentageOfCell = minimumPercentageOfCell
        }
        
        self.collectionView = collectionView
        self.delegate = delegate
    }
    
    func stalkCells() {
        // TODO: Iterate cells, make calculations for each of them
        // TODO: Decide whether event should be send or not for cell at current indexpath
        
        guard let collectionView = collectionView else { return }
        for cell in collectionView.visibleCells {
            if let listingItemCell = cell as? UICollectionViewCell & ListingImpressionItem {
                let visiblePercentOfCell = percentOfVisiblePart(ofCell: listingItemCell, in: collectionView)
                
                if visiblePercentOfCell >= minPercentageOfCell, !alreadySentIdentifiers.contains(listingItemCell.getUniqueId()) {
                    guard let indexPath = collectionView.indexPath(for: listingItemCell), let delegate = delegate else {
                        continue
                    }
                    delegate.sendEventForCell(at: indexPath)
                    alreadySentIdentifiers.append(listingItemCell.getUniqueId())
                }
            }
        }
    }
    
    private func percentOfVisiblePart(ofCell cell: UICollectionViewCell, in collectionView: UICollectionView) -> CGFloat {
        guard let indexPathForCell = collectionView.indexPath(for: cell),
              let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPathForCell) else {
            return CGFloat.leastNonzeroMagnitude
        }
        
        let cellFrameInSuper = collectionView.convert(layoutAttributes.frame, to: collectionView.superview)
        
        let interSectionRect = cellFrameInSuper.intersection(collectionView.frame)
        let percentOfIntersection: CGFloat = interSectionRect.height / cellFrameInSuper.height
        
        return percentOfIntersection
    }
    
}
