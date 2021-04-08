//
//  FavoritesLogicController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 08..
//

import Foundation

final class FavoritesLogicController {
    func load(then handler: @escaping (ViewState<[Movie]>) -> Void) {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let list):
                
                var movies = [Movie]()
                list.forEach { movieDetail in
                    let movie = movieDetail.regenrateToMovie()
                    movies.append(movie)
                }
                
                handler(.presenting(movies))
            case .failure(let error):
                handler(.failed)
            }
        }
    }
}
