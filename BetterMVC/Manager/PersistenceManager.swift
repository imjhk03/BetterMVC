//
//  PersistenceManager.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 08..
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {

    static private let defaults = UserDefaults.standard
    enum Keys { static let favorites = "favorites" }

    static func updateWith(favorite: MovieDetail, actionType: PersistenceActionType, completed: @escaping (FavoritesError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }

                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.id == favorite.id }
                }

                completed(save(favorites: favorites))

            case .failure(let error):
                completed(error)
            }
        }
    }

    static func retrieveFavorites(completed: @escaping (Result<[MovieDetail], FavoritesError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([MovieDetail].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }

    static func save(favorites: [MovieDetail]) -> FavoritesError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
        } catch {
            return .unableToFavorite
        }

        return nil
    }

    static func isFavorite(_ movie: MovieDetail) -> Bool {
        var isFavorite: Bool = false

        retrieveFavorites { result in
            switch result {
            case .success(let movies):
                guard !movies.contains(movie) else {
                    isFavorite = true
                    return
                }
                isFavorite = false
            case .failure:
                isFavorite = false
            }
        }

        return isFavorite
    }

}
