//
//  ListLogicController.swift
//  BetterMVC
//
//  Created by Joo Hee Kim on 21. 04. 02..
//

import Foundation

final class ListLogicController {
    private var popularMovies = [Movie]()
    private var trendingMovies = [Movie]()
    private let networking = NetworkManager.shared
    
    func load(then handler: @escaping (ViewState<[Movie]>) -> Void) {
        networking.request(.trending(time: .week)) { (response: Result<MovieList, NetworkError>) in
            switch response {
            case .success(let response):
                let movies = response.results
                self.trendingMovies = movies
                handler(.presenting(movies))
            case .failure(let error):
                handler(.failed)
            }
        }
    }
    
}

extension ListLogicController: ListDataSourceDataProvider {
    func item(for section: ListDataSource.Section) -> ListDataSource.Item {
        switch section {
        case .popular:
            return .init(movies: popularMovies)
        case .trending:
            return .init(movies: trendingMovies)
        }
    }
}
