//
//  ListCollectionViewCell.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import UIKit
import Nuke

final class ListCollectionViewCell: UICollectionViewCell, NibReusable {

    struct ViewModel {
        let movie: Movie

        var title: String? { movie.title }
        var releaseDate: String? { movie.release_date }
        var imageURL: URL? {
            let finalString = "https://image.tmdb.org/t/p/original" + (movie.poster_path ?? "")
            guard let url = URL(string: finalString) else { return nil }
            return url
        }
    }

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setupView()
    }

    private func setupView() {
        imageView.contentMode = .scaleAspectFill
    }

    func configure(_ viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        releaseDateLabel.text = viewModel.releaseDate
        guard let url = viewModel.imageURL else { return }
        let placeholder = UIImage(named: "film.fill")
        let options = ImageLoadingOptions(placeholder: placeholder, transition: .fadeIn(duration: 0.5))
        Nuke.loadImage(with: url, options: options, into: imageView)
    }

}
