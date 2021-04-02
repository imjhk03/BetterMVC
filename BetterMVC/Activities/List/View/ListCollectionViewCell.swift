//
//  ListCollectionViewCell.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import UIKit

final class ListCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel {
        let movie: Movie
        
        var title: String? { movie.title }
        var releaseDate: String? { movie.release_date }
    }

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        imageView.backgroundColor = .systemGreen
    }
    
    func configure(_ viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
    }

}
