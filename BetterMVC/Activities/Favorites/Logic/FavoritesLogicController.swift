//
//  FavoritesLogicController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 08..
//

import Foundation

final class FavoritesLogicController {
    func load(then handler: @escaping (ViewState<[Movie]>) -> Void) {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let list):
                let movies = self.convertFavoriteMovies(list)
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
