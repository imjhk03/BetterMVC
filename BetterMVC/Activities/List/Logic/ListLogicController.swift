//
//  ListLogicController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import Foundation

final class ListLogicController {
    private var popularMovies = [Movie]()
    private let networking = NetworkManager.shared

    func loadPopular(then handler: @escaping (ViewState<[Movie]>) -> Void) {
        networking.request(.popular()) { (response: Result<MovieList, NetworkError>) in
            switch response {
            case .success(let response):
                let movies = response.results
                self.popularMovies = movies
                handler(.presenting(movies))
            case .failure(let error):
                handler(.failed)
            }
        }
    }
    
    func appendMovie(_ movie: Movie, at index: Int) {
        popularMovies.insert(movie, at: index)
    }
    
    func removeMovie(at index: Int) {
        popularMovies.remove(at: index)
    }

}

extension ListLogicController: ListDataSourceDataProvider {
    func item(for section: ListDataSource.Section) -> ListDataSource.Item {
        switch section {
        case .popular:
            return .init(movies: popularMovies)
        }
    }
}
