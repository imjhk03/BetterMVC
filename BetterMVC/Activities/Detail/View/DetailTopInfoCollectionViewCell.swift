//
//  DetailTopInfoCollectionViewCell.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 07..
//

import UIKit
import Nuke

protocol DetailTopInfoCollectionViewCellDelegate: AnyObject {
    func buttonTapped(_ actionType: PersistenceActionType)
}

final class DetailTopInfoCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel {
        let movie: MovieDetail
        
        var title: String? { movie.title }
        var genre: String? {
            let joinedTags = movie.genres.map({ $0.name }).joined(separator: ", ")
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
        var description: String? {
            var value = movie.release_date
            if let runtime = movie.runtime {
                value += "   " + runtime.toRelativeRuntime()
            }
            return value
        }
        var isFavorite: Bool { movie.isFavorite }
    }
    
    private weak var delegate: DetailTopInfoCollectionViewCellDelegate?

    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
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
        favoriteButton.layer.cornerRadius = 8
    }
    
    func configure(_ viewModel: ViewModel, delegate: DetailTopInfoCollectionViewCellDelegate?) {
        self.delegate = delegate
        
        titleLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        descriptionLabel.text = viewModel.description
        
        guard let backgroundURL = viewModel.backgroundImageURL else { return }
        let placeholder = UIImage(named: "film.fill")
        let options = ImageLoadingOptions(placeholder: placeholder, transition: .fadeIn(duration: 0.5))
        Nuke.loadImage(with: backgroundURL, options: options, into: backgroundImageView)
        
        guard let posterURL = viewModel.posterImageURL else { return }
        Nuke.loadImage(with: posterURL, options: options, into: posterImageView)
        
        favoriteButton.isSelected = viewModel.isFavorite
        favoriteButton.tintColor = viewModel.isFavorite ? UIColor.systemPink : UIColor.lightGray
    }
    
    @IBAction private func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(favoriteButton.isSelected ? .remove : .add)
    }
    
}

extension Int {
    func toRelativeRuntime() -> String {
        let hour = self / 60
        let minute = self % 60
        
        return String(format: "%2i시간 %2i분", hour, minute)
        
    }
}
