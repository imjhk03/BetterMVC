//
//  FavoritesLogicController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 08..
//

import Foundation

final class FavoritesLogicController {
    private var movies = [Movie]()
    
    func load(then handler: @escaping (ViewState<[Movie]>) -> Void) {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let list):
                let movies = self.convertFavoriteMovies(list)
                self.movies = movies
                handler(.presenting(movies))
            case .failure(let error):
                handler(.failed)
            }
        }
    }
    
    private func convertFavoriteMovies(_ favorites: [MovieDetail]) -> [Movie] {
        var movies = [Movie]()
        favorites.forEach { movieDetail in
            let movie = movieDetail.regenrateToMovie()
            movies.append(movie)
        }
        movies.reverse()
        return movies
    }
    
}

extension FavoritesLogicController: FavoritesDataSourceDataProvider {
    func item(for section: FavoritesDataSource.Section) -> FavoritesDataSource.Item {
        switch section {
        case .main:
            return .init(movies: movies)
        }
    }
}
