//
//  DetailOverviewCollectionViewCell.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit

final class DetailOverviewCollectionViewCell: UICollectionViewCell {
    
    static func fittingSize(availableWidth: CGFloat, movie: MovieDetail) -> CGSize {
        guard let sizingCell = DetailOverviewCollectionViewCell.initFromNib() else { return .zero }
        
        sizingCell.configure(.init(movie: movie))
        
        let availableSize = CGSize(width: availableWidth, height: UIView.layoutFittingCompressedSize.height)
        let size = sizingCell.contentView.systemLayoutSizeFitting(availableSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        return size
    }
    
    struct ViewModel {
        let movie: MovieDetail
        
        var overview: String? { movie.overview }
    }

    @IBOutlet private weak var labelContainerView: UIView!
    @IBOutlet private weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        labelContainerView.backgroundColor = .secondarySystemBackground
        labelContainerView.layer.cornerRadius = 8
        labelContainerView.clipsToBounds = true
        
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
    }
    
    func configure(_ viewModel: ViewModel) {
        label.text = viewModel.overview
    }

}
