//
//  DetailTopInfoCollectionViewCell.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit
import Nuke

final class DetailTopInfoCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel {
        let movie: MovieDetail
        
        var title: String? { movie.title }
        var genre: String? {
            let joinedTags = movie.genres.map({ $0.name }).joined(separator: " ")
            return joinedTags
        }
        var backgroundImageURL: URL? {
            let finalString = "https://image.tmdb.org/t/p/original" + (movie.backdrop_path ?? "")
            guard let url = URL(string: finalString) else { return nil }
            return url
        }
        var posterImageURL: URL? {
            let finalString = "https://image.tmdb.org/t/p/original" + (movie.poster_path ?? "")
            guard let url = URL(string: finalString) else { return nil }
            return url
        }
        var description: String? { movie.overview }
    }

    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        backgroundImageView.contentMode = .scaleAspectFill
        posterImageView.contentMode = .scaleAspectFill
        titleLabel.textColor = .white
        genreLabel.textColor = .white
        descriptionLabel.font = .preferredFont(forTextStyle: .footnote)
        descriptionLabel.textColor = .white
    }
    
    func configure(_ viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        descriptionLabel.text = viewModel.description
        
        guard let backgroundURL = viewModel.backgroundImageURL else { return }
        let placeholder = UIImage(named: "film.fill")
        let options = ImageLoadingOptions(placeholder: placeholder, transition: .fadeIn(duration: 0.5))
        Nuke.loadImage(with: backgroundURL, options: options, into: backgroundImageView)
        
        guard let posterURL = viewModel.posterImageURL else { return }
        Nuke.loadImage(with: posterURL, options: options, into: posterImageView)
    }

}
